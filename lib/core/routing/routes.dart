import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/middleware/my_middleware.dart';
import 'package:eventsmanager/features/events/presentation/manager/editEvent/edit_event_binding.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventAttendees/event_attendess_binding.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventDashboard/event_dashboard_binding.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventDetails/event_details_binding.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventInvites/event_invites_binding.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventManagers/event_managers_binding.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventMap/event_map_binding.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventQr/event_qr_binding.dart';
import 'package:eventsmanager/features/events/presentation/manager/root_binding.dart';
import 'package:eventsmanager/features/events/presentation/manager/scanQr/scan_qr_binding.dart';
import 'package:eventsmanager/features/events/presentation/manager/sendInvite/send_invite_binding.dart';
import 'package:eventsmanager/features/events/presentation/view/dashboard_view.dart';
import 'package:eventsmanager/features/events/presentation/view/edit_event_view.dart';
import 'package:eventsmanager/features/events/presentation/view/event_attendees_view.dart';
import 'package:eventsmanager/features/events/presentation/view/event_details_view.dart';
import 'package:eventsmanager/features/events/presentation/view/event_invites_view.dart';
import 'package:eventsmanager/features/events/presentation/view/event_managers_view.dart';
import 'package:eventsmanager/features/events/presentation/view/event_map_view.dart';
import 'package:eventsmanager/features/events/presentation/view/event_qr_view.dart';
import 'package:eventsmanager/features/auth/presentation/manager/checkEmail/check_email_binding.dart';
import 'package:eventsmanager/features/auth/presentation/manager/completeProfile/complete_profile_binding.dart';
import 'package:eventsmanager/features/auth/presentation/manager/forgetPasswordVerifyCode/forgetpassword_verifycode_binding.dart';
import 'package:eventsmanager/features/auth/presentation/manager/login/login_binding.dart';
import 'package:eventsmanager/features/auth/presentation/manager/resetPassword/resetpassword_binding.dart';
import 'package:eventsmanager/features/auth/presentation/manager/signup/signup_binding.dart';
import 'package:eventsmanager/features/auth/presentation/manager/signupVerifyCode/signup_verify_code_binding.dart';
import 'package:eventsmanager/features/auth/presentation/view/complete_profile_view.dart';
import 'package:eventsmanager/features/auth/presentation/view/login_view.dart';
import 'package:eventsmanager/features/auth/presentation/view/reset_password_successful_view.dart';
import 'package:eventsmanager/features/auth/presentation/view/resetpassword_view.dart';
import 'package:eventsmanager/features/auth/presentation/view/sign_up_verify_code_view.dart';
import 'package:eventsmanager/features/auth/presentation/view/signup_view.dart';
import 'package:eventsmanager/features/auth/presentation/view/check_email_view.dart';
import 'package:eventsmanager/features/auth/presentation/view/forget_password_verify_code_view.dart';
import 'package:eventsmanager/features/events/presentation/view/root.dart';
import 'package:eventsmanager/features/events/presentation/view/scan_qr_view.dart';
import 'package:eventsmanager/features/events/presentation/view/send_invite_view.dart';
import 'package:eventsmanager/features/notifications/presentation/view/notifications_tab_view.dart';
import 'package:eventsmanager/features/notifications/presentation/view/notifications_view.dart';
import 'package:eventsmanager/features/onboarding/presentation/manager/onBoardingController/on_boarding_binding.dart';
import 'package:eventsmanager/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:eventsmanager/features/profileSettings/presentation/view/edit_profile_view.dart';

import 'package:get/route_manager.dart';

List<GetPage<dynamic>>? routes = [
//   //auth
  GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding()),
  GetPage(
      name: AppRoutes.signUp,
      page: () => const SignupView(),
      binding: SignupBinding()),
  GetPage(
    name: AppRoutes.completeProfile,
    page: () => const CompleteProfileView(),
    binding: CompleteProfileBinding(),
  ),
//   GetPage(
//       name: AppRoutes.signupsuccess,
//       page: () => const SignUpSuccessView(),
//       binding: SignupSuccessBinding()),
  GetPage(
      name: AppRoutes.signupveifycode,
      page: () => const SignUpVerifyCodeView(),
      binding: SignupVerifyCodeBinding()),

//   //on boarding
  GetPage(
    name: "/",
    page: () => const OnBoardingView(),
    binding: OnBoardingBinding(),
    middlewares: [Mymiddleware()],
  ),

//   //forget password
  GetPage(
      name: AppRoutes.checkemail,
      page: () => const CheckEmailView(),
      binding: CheckEmailBinding()),
  GetPage(
      name: AppRoutes.restpassword,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding()),
  GetPage(
      name: AppRoutes.forgetPasswordVerifyCode,
      page: () => const ForgetPasswordVerifiyCodeView(),
      binding: ForgetPasswordVerifyCodeBinding()),
  GetPage(
      name: AppRoutes.restpasswordsuccess,
      page: () => const ResetPasswordSuccessfulView()),
//home
  GetPage(
      name: AppRoutes.root, page: () => const Root(), binding: RootBinding()),
  //events
  GetPage(
      name: AppRoutes.eventDetails,
      page: () => const EventDetailsView(),
      binding: EventDetailsBinding()),
  GetPage(
      name: AppRoutes.map,
      page: () => EventMapView(),
      binding: EventMapBinding()),
  GetPage(
      name: AppRoutes.qrView,
      page: () => const EventQrView(),
      binding: EventQrBinding()),
  GetPage(
      name: AppRoutes.editEvent,
      page: () => const EditEventView(),
      binding: EditEventBinding()),
  //profile

  GetPage(
    name: AppRoutes.editprofile,
    page: () => const EditProfileView(),
  ),
  // notifications
  GetPage(
    name: AppRoutes.notificationsView,
    page: () => const NotificationsView(),
  ),
  GetPage(
    name: AppRoutes.notificationsTabView,
    page: () => const NotificationsTabView(),
  ),
  GetPage(
    name: AppRoutes.dashBoard,
    page: () => const DashboardView(),
    binding: EventDashboardBinding(),
  ),
  GetPage(
    name: AppRoutes.eventAttendees,
    page: () => const EventAttendeesView(),
    binding: EventAttendessBinding(),
  ),
  GetPage(
    name: AppRoutes.eventManagers,
    page: () => const EventManagersView(),
    binding: EventManagersBinding(),
  ),
  GetPage(
    name: AppRoutes.eventInvites,
    page: () => const EventInvitesView(),
    binding: EventInvitesBinding(),
  ),

  GetPage(
    name: AppRoutes.senInvite,
    page: () => const SendInviteView(),
    binding: SendInviteBinding(),
  ),

  GetPage(
    name: AppRoutes.scanQrView,
    page: () => const ScanQrView(),
    binding: ScanQrBinding(),
  ),
];
