# Diff Details

Date : 2026-02-03 17:26:03

Directory e:\\flutter projects\\eventsmanager\\lib

Total : 44 files,  705 codes, 541 comments, 203 blanks, all 1449 lines

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [lib/core/class/api\_handling\_view.dart](/lib/core/class/api_handling_view.dart) | Dart | 113 | 2 | 20 | 135 |
| [lib/core/class/app\_bindings.dart](/lib/core/class/app_bindings.dart) | Dart | 29 | 10 | 6 | 45 |
| [lib/core/class/base\_will\_pop\_handler.dart](/lib/core/class/base_will_pop_handler.dart) | Dart | 29 | 3 | 5 | 37 |
| [lib/core/class/status\_request.dart](/lib/core/class/status_request.dart) | Dart | -9 | 0 | 0 | -9 |
| [lib/core/constants/app\_image\_asset.dart](/lib/core/constants/app_image_asset.dart) | Dart | 22 | 3 | 2 | 27 |
| [lib/core/constants/image\_asset.dart](/lib/core/constants/image_asset.dart) | Dart | -17 | -3 | -1 | -21 |
| [lib/core/functions/dum.dart](/lib/core/functions/dum.dart) | Dart | 0 | 39 | 2 | 41 |
| [lib/core/middleware/my\_middleware.dart](/lib/core/middleware/my_middleware.dart) | Dart | 7 | 4 | 8 | 19 |
| [lib/core/routing/routes.dart](/lib/core/routing/routes.dart) | Dart | 16 | 0 | 0 | 16 |
| [lib/core/services/api/api\_error\_handler.dart](/lib/core/services/api/api_error_handler.dart) | Dart | -65 | 208 | 29 | 172 |
| [lib/core/services/api/api\_exceptions.dart](/lib/core/services/api/api_exceptions.dart) | Dart | 0 | 0 | 2 | 2 |
| [lib/core/services/api/api\_service.dart](/lib/core/services/api/api_service.dart) | Dart | 19 | 1 | 7 | 27 |
| [lib/core/services/api/api\_status.dart](/lib/core/services/api/api_status.dart) | Dart | 27 | 0 | 4 | 31 |
| [lib/core/services/api/dio\_client.dart](/lib/core/services/api/dio_client.dart) | Dart | -122 | 289 | 30 | 197 |
| [lib/core/services/shared\_pref\_service.dart](/lib/core/services/shared_pref_service.dart) | Dart | -4 | 4 | 0 | 0 |
| [lib/features/Events/presentation/manager/eventDetails/event\_details\_controller.dart](/lib/features/Events/presentation/manager/eventDetails/event_details_controller.dart) | Dart | 2 | 0 | 0 | 2 |
| [lib/features/Events/presentation/manager/root\_binding.dart](/lib/features/Events/presentation/manager/root_binding.dart) | Dart | 2 | -1 | 0 | 1 |
| [lib/features/Events/presentation/view/root.dart](/lib/features/Events/presentation/view/root.dart) | Dart | 2 | 0 | 0 | 2 |
| [lib/features/auth/data/repo/auth\_repo.dart](/lib/features/auth/data/repo/auth_repo.dart) | Dart | 174 | 11 | 33 | 218 |
| [lib/features/auth/presentation/manager/checkEmail/check\_email\_controller.dart](/lib/features/auth/presentation/manager/checkEmail/check_email_controller.dart) | Dart | 25 | -15 | 5 | 15 |
| [lib/features/auth/presentation/manager/completeProfile/complete\_profile\_controller.dart](/lib/features/auth/presentation/manager/completeProfile/complete_profile_controller.dart) | Dart | 53 | 5 | 6 | 64 |
| [lib/features/auth/presentation/manager/forgetPasswordVerifyCode/forget\_password\_verifycode\_controller.dart](/lib/features/auth/presentation/manager/forgetPasswordVerifyCode/forget_password_verifycode_controller.dart) | Dart | 43 | -15 | 9 | 37 |
| [lib/features/auth/presentation/manager/login/login\_controller.dart](/lib/features/auth/presentation/manager/login/login_controller.dart) | Dart | 22 | 13 | 6 | 41 |
| [lib/features/auth/presentation/manager/resetPassword/resetpassword\_controller.dart](/lib/features/auth/presentation/manager/resetPassword/resetpassword_controller.dart) | Dart | 25 | 0 | 3 | 28 |
| [lib/features/auth/presentation/manager/signupVerifyCode/signup\_verify\_code\_controller.dart](/lib/features/auth/presentation/manager/signupVerifyCode/signup_verify_code_controller.dart) | Dart | 45 | -14 | 9 | 40 |
| [lib/features/auth/presentation/manager/signup/signup\_controller.dart](/lib/features/auth/presentation/manager/signup/signup_controller.dart) | Dart | 0 | -2 | -1 | -3 |
| [lib/features/auth/presentation/view/check\_email\_view.dart](/lib/features/auth/presentation/view/check_email_view.dart) | Dart | 12 | 0 | 0 | 12 |
| [lib/features/auth/presentation/view/complete\_profile\_view.dart](/lib/features/auth/presentation/view/complete_profile_view.dart) | Dart | 15 | 0 | 1 | 16 |
| [lib/features/auth/presentation/view/forget\_password\_verify\_code\_view.dart](/lib/features/auth/presentation/view/forget_password_verify_code_view.dart) | Dart | -2 | -2 | 1 | -3 |
| [lib/features/auth/presentation/view/login\_view.dart](/lib/features/auth/presentation/view/login_view.dart) | Dart | -3 | -1 | 1 | -3 |
| [lib/features/auth/presentation/view/reset\_password\_successful\_view.dart](/lib/features/auth/presentation/view/reset_password_successful_view.dart) | Dart | 39 | 0 | 3 | 42 |
| [lib/features/auth/presentation/view/resetpassword\_view.dart](/lib/features/auth/presentation/view/resetpassword_view.dart) | Dart | 12 | 0 | 0 | 12 |
| [lib/features/auth/presentation/view/sign\_up\_verify\_code\_view.dart](/lib/features/auth/presentation/view/sign_up_verify_code_view.dart) | Dart | 7 | -2 | 0 | 5 |
| [lib/features/auth/presentation/view/signup\_view.dart](/lib/features/auth/presentation/view/signup_view.dart) | Dart | -19 | -1 | -1 | -21 |
| [lib/features/auth/presentation/view/widgets/continue\_with\_body\_auth.dart](/lib/features/auth/presentation/view/widgets/continue_with_body_auth.dart) | Dart | -25 | 0 | -3 | -28 |
| [lib/features/auth/presentation/view/widgets/profile\_avatar.dart](/lib/features/auth/presentation/view/widgets/profile_avatar.dart) | Dart | 2 | 0 | 0 | 2 |
| [lib/features/auth/presentation/view/widgets/social\_button.dart](/lib/features/auth/presentation/view/widgets/social_button.dart) | Dart | -34 | 0 | -4 | -38 |
| [lib/features/auth/presentation/view/widgets/verification\_pin.dart](/lib/features/auth/presentation/view/widgets/verification_pin.dart) | Dart | 52 | 0 | 3 | 55 |
| [lib/features/profileSettings/presentation/manager/profile\_settings\_controller.dart](/lib/features/profileSettings/presentation/manager/profile_settings_controller.dart) | Dart | 40 | 2 | 7 | 49 |
| [lib/features/profileSettings/presentation/view/profile\_settings\_view.dart](/lib/features/profileSettings/presentation/view/profile_settings_view.dart) | Dart | 107 | 3 | 8 | 118 |
| [lib/features/profileSettings/presentation/view/widgets/section.dart](/lib/features/profileSettings/presentation/view/widgets/section.dart) | Dart | 35 | 0 | 3 | 38 |
| [lib/features/profileSettings/presentation/view/widgets/settings\_tile.dart](/lib/features/profileSettings/presentation/view/widgets/settings_tile.dart) | Dart | 45 | 0 | 4 | 49 |
| [lib/features/settings/presentation/view/settings\_view.dart](/lib/features/settings/presentation/view/settings_view.dart) | Dart | -12 | 0 | -3 | -15 |
| [lib/main.dart](/lib/main.dart) | Dart | -4 | 0 | -1 | -5 |

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details