import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/services/shared_pref_service.dart';
import 'package:eventsmanager/features/notifications/presentation/manager/notification/notifications_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eventsmanager/features/notifications/data/repo/notification_repository.dart';

// TOP-LEVEL FUNCTION - Must be outside the class for background messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print(' Background message: ${message.messageId}');
  // print('Title: ${message.notification?.title}');
  // print('Body: ${message.notification?.body}');
  // print('Data: ${message.data}');
}

class FcmService extends GetxService {
  final NotificationRepository _repo = Get.find();
  final SharedprefService prefs = Get.find<SharedprefService>();

  // Local notifications plugin
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<FcmService> init() async {
    // Initialize local notifications FIRST
    await _initializeLocalNotifications();

    // Request permissions
    await _requestPermission();

    // Get and print token for debugging
    // String? token = await FirebaseMessaging.instance.getToken();
    // print('FCM Token: $token');

    if (prefs.isLoggedIn()) {
      await syncTokenIfNeeded();
      _listenToTokenRefresh();
    }

    // Setup message handlers for ALL users (logged in or not)
    _setupMessageHandlers();

    return this;
  }

  /// Initialize local notifications plugin
  Future<void> _initializeLocalNotifications() async {
    // Android initialization
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create Android notification channel
    const androidChannel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // name
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
    );

    // CORRECTED LINE:
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  /// Request notification permissions
  Future<void> _requestPermission() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    //  print(' Permission status: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // print(' User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // print(' User granted provisional permission');
    } else {
      //print(' User declined or has not accepted permission');
    }
  }

  /// Setup FCM message handlers
  void _setupMessageHandlers() {
    // 1. FOREGROUND MESSAGES (app is open)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print(' Foreground message received');
      // print('Title: ${message.notification?.title}');
      // print('Body: ${message.notification?.body}');
      // print('Data: ${message.data}');

      // Refresh notifications controller
      if (Get.isRegistered<NotificationsController>()) {
        Get.find<NotificationsController>().refreshNotifications();
      }

      // Show local notification (THIS IS CRUCIAL FOR FOREGROUND)
      _showLocalNotification(message);
    });

    // 2. BACKGROUND MESSAGES (app in background, user taps notification)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //print(' Background message opened: ${message.notification?.title}');
      _handleNotificationTap(message.data);
    });

    // 3. TERMINATED MESSAGES (app was closed, opened via notification)
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        //  print(' App opened from terminated state via notification');
        _handleNotificationTap(message.data);
      }
    });
  }

  /// Show local notification when app is in foreground
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
        id: message.hashCode, // notification ID
        title: message.notification?.title ?? 'New Notification',
        body: message.notification?.body ?? '',
        notificationDetails: notificationDetails,
        payload: message.data.toString());
  }

  /// Handle notification tap from local notification
  void _onNotificationTapped(NotificationResponse response) {
    Get.toNamed(AppRoutes.notificationsTabView);
    //  print(' Notification tapped: ${response.payload}');
    // Parse payload and navigate
    // You might need to parse the data map from string
  }

  /// Handle notification tap navigation
  void _handleNotificationTap(Map<String, dynamic> data) {
    Get.toNamed(AppRoutes.notificationsTabView);
  }

  Future<void> syncTokenIfNeeded() async {
    final token = await FirebaseMessaging.instance.getToken();
    //print(' Current FCM Token: $token');

    if (token == null) {
      //print(' Failed to get FCM token');
      return;
    }

    final savedToken = prefs.stringGetter(key: 'fcm_token');
    //print(' Saved FCM Token: $savedToken');

    if (savedToken == token) {
      // print(' Token already synced');
      return;
    }

    // print('Syncing new token to backend...');
    final result = await _repo.registerFcmToken(token);

    result.fold(
      (failure) {
        if (failure.toString().contains('FCM token already registered')) {
          // Just save it locally and move on
          prefs.stringSetter(key: 'fcm_token', value: token);
          //print('Token already on backend, synced locally');
        } else {
          //print(' Real error: $failure');
        }
      },
      (success) async {
        // print(' Token registered successfully');
        await prefs.stringSetter(key: 'fcm_token', value: token);
      },
    );
  }

  void _listenToTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      // print(' Token refreshed: $newToken');
      final result = await _repo.registerFcmToken(newToken);

      result.fold(
        (failure) {
          //print(' Failed to register refreshed token: $failure');
        },
        (success) async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('fcm_token', newToken);
          //  print(' Refreshed token saved');
        },
      );
    });
  }
}
