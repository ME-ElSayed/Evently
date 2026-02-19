import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/services/api/api_service.dart';
import 'package:eventsmanager/core/services/api/dio_client.dart';
import 'package:eventsmanager/core/services/fcm_service.dart';
import 'package:eventsmanager/core/services/shared_pref_service.dart';
import 'package:eventsmanager/features/events/data/repo/event_repo.dart';
import 'package:eventsmanager/features/auth/data/repo/auth_repo.dart';
import 'package:eventsmanager/features/notifications/data/repo/invite_repository.dart';
import 'package:eventsmanager/features/notifications/data/repo/notification_repository.dart';
import 'package:eventsmanager/features/profileSettings/data/repo/profile_repo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class AppBindings {
  /// Initialize all core services in correct order
  static Future<void> init() async {
    // 1. Initialize SharedPreferences (no dependencies)
    await Get.putAsync(() => SharedprefService().init());
  final baseUrl = (dotenv.env['BASE_URL'] ?? '').trim();
    // 2. Initialize DioClient (depends on SharedprefService)
    Get.put(
      DioClient(
        baseUrl:baseUrl ,
        onTokenRefreshFailed: _handleLogout,
      ),
      permanent: true,
    );

    // 3. Initialize ApiService (depends on DioClient & SharedprefService)
    await Get.putAsync(() => ApiService().init(), permanent: true);

    // 4. Repositories (lazy loaded when needed)
    _initRepositories();
  }

  /// Initialize repositories lazily
  static void _initRepositories() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<EventRepository>(() => EventRepositoryImpl(), fenix: true);
    Get.lazyPut<ProfileRepository>(() => ProfileRepositoryImpl(), fenix: true);

    Get.put<NotificationRepository>(NotificationRepositoryImpl());
    Get.put<InviteRepository>(InviteRepositoryImpl());
    Get.putAsync(() => FcmService().init(), permanent: true);
  }

  /// Handle logout on token refresh failure
  static void _handleLogout() {
    final prefs = Get.find<SharedprefService>();
    prefs.clearTokens();
    prefs.clearUserData();
    Get.offAllNamed(AppRoutes.login);
  }
}
