# Diff Details

Date : 2026-02-13 23:40:42

Directory e:\\flutter projects\\eventsmanager\\lib

Total : 38 files,  1249 codes, -35 comments, 134 blanks, all 1348 lines

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [lib/core/class/app\_bindings.dart](/lib/core/class/app_bindings.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/core/constants/event\_state\_list.dart](/lib/core/constants/event_state_list.dart) | Dart | 6 | 0 | 2 | 8 |
| [lib/core/functions/show\_message.dart](/lib/core/functions/show_message.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/core/services/api/api\_service.dart](/lib/core/services/api/api_service.dart) | Dart | 146 | 7 | 22 | 175 |
| [lib/features/events/data/models/event\_attendee\_model.dart](/lib/features/events/data/models/event_attendee_model.dart) | Dart | 67 | 0 | 7 | 74 |
| [lib/features/events/data/models/event\_invite\_model.dart](/lib/features/events/data/models/event_invite_model.dart) | Dart | 59 | 0 | 7 | 66 |
| [lib/features/events/data/models/event\_manager\_model.dart](/lib/features/events/data/models/event_manager_model.dart) | Dart | 36 | 0 | 3 | 39 |
| [lib/features/events/data/models/event\_model.dart](/lib/features/events/data/models/event_model.dart) | Dart | 38 | -3 | 11 | 46 |
| [lib/features/events/data/models/invite\_role.dart](/lib/features/events/data/models/invite_role.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/features/events/data/models/invite\_status.dart](/lib/features/events/data/models/invite_status.dart) | Dart | 30 | 1 | 3 | 34 |
| [lib/features/events/data/models/user\_search\_model.dart](/lib/features/events/data/models/user_search_model.dart) | Dart | 6 | 0 | 0 | 6 |
| [lib/features/events/data/repo/event\_repo.dart](/lib/features/events/data/repo/event_repo.dart) | Dart | 290 | 1 | 38 | 329 |
| [lib/features/events/presentation/manager/editEvent/edit\_event\_controller.dart](/lib/features/events/presentation/manager/editEvent/edit_event_controller.dart) | Dart | 44 | 2 | 2 | 48 |
| [lib/features/events/presentation/manager/eventAttendees/event\_attendess\_controller.dart](/lib/features/events/presentation/manager/eventAttendees/event_attendess_controller.dart) | Dart | 68 | 0 | 13 | 81 |
| [lib/features/events/presentation/manager/eventDashboard/event\_dashboard\_controller.dart](/lib/features/events/presentation/manager/eventDashboard/event_dashboard_controller.dart) | Dart | 31 | 0 | 4 | 35 |
| [lib/features/events/presentation/manager/eventInvites/event\_invites\_controller.dart](/lib/features/events/presentation/manager/eventInvites/event_invites_controller.dart) | Dart | 24 | -8 | -5 | 11 |
| [lib/features/events/presentation/manager/eventManagers/event\_managers\_controller.dart](/lib/features/events/presentation/manager/eventManagers/event_managers_controller.dart) | Dart | 64 | 0 | 10 | 74 |
| [lib/features/events/presentation/manager/scanQr/scan\_qr\_controller.dart](/lib/features/events/presentation/manager/scanQr/scan_qr_controller.dart) | Dart | 31 | -5 | 4 | 30 |
| [lib/features/events/presentation/manager/sendInvite/send\_invite\_controller.dart](/lib/features/events/presentation/manager/sendInvite/send_invite_controller.dart) | Dart | 71 | -8 | 5 | 68 |
| [lib/features/events/presentation/view/dashboard\_view.dart](/lib/features/events/presentation/view/dashboard_view.dart) | Dart | 4 | 0 | 0 | 4 |
| [lib/features/events/presentation/view/edit\_event\_view.dart](/lib/features/events/presentation/view/edit_event_view.dart) | Dart | 24 | 17 | 2 | 43 |
| [lib/features/events/presentation/view/event\_attendees\_view.dart](/lib/features/events/presentation/view/event_attendees_view.dart) | Dart | 32 | -11 | 0 | 21 |
| [lib/features/events/presentation/view/event\_invites\_view.dart](/lib/features/events/presentation/view/event_invites_view.dart) | Dart | 28 | -14 | -1 | 13 |
| [lib/features/events/presentation/view/event\_managers\_view.dart](/lib/features/events/presentation/view/event_managers_view.dart) | Dart | 29 | -11 | 1 | 19 |
| [lib/features/events/presentation/view/scan\_qr\_view.dart](/lib/features/events/presentation/view/scan_qr_view.dart) | Dart | 27 | 0 | 5 | 32 |
| [lib/features/events/presentation/view/send\_invite\_view.dart](/lib/features/events/presentation/view/send_invite_view.dart) | Dart | 31 | 0 | 0 | 31 |
| [lib/features/events/presentation/view/widgets/attendee\_card.dart](/lib/features/events/presentation/view/widgets/attendee_card.dart) | Dart | 8 | 0 | 0 | 8 |
| [lib/features/events/presentation/view/widgets/attendees\_list.dart](/lib/features/events/presentation/view/widgets/attendees_list.dart) | Dart | 4 | -1 | 0 | 3 |
| [lib/features/events/presentation/view/widgets/event\_image\_pic.dart](/lib/features/events/presentation/view/widgets/event_image_pic.dart) | Dart | 14 | 0 | -1 | 13 |
| [lib/features/events/presentation/view/widgets/invite\_card.dart](/lib/features/events/presentation/view/widgets/invite_card.dart) | Dart | 16 | 0 | 1 | 17 |
| [lib/features/events/presentation/view/widgets/invites\_list.dart](/lib/features/events/presentation/view/widgets/invites_list.dart) | Dart | 2 | -1 | 0 | 1 |
| [lib/features/events/presentation/view/widgets/managers\_card.dart](/lib/features/events/presentation/view/widgets/managers_card.dart) | Dart | 5 | 0 | 0 | 5 |
| [lib/features/events/presentation/view/widgets/managers\_list.dart](/lib/features/events/presentation/view/widgets/managers_list.dart) | Dart | 5 | -1 | 0 | 4 |
| [lib/features/events/presentation/view/widgets/permission\_selector.dart](/lib/features/events/presentation/view/widgets/permission_selector.dart) | Dart | -2 | 0 | 1 | -1 |
| [lib/features/events/presentation/view/widgets/user\_card.dart](/lib/features/events/presentation/view/widgets/user_card.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/features/events/presentation/view/widgets/user\_search\_list.dart](/lib/features/events/presentation/view/widgets/user_search_list.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/features/notifications/presentation/manager/notifications\_controller.dart](/lib/features/notifications/presentation/manager/notifications_controller.dart) | Dart | 6 | 0 | -1 | 5 |
| [lib/features/profileSettings/presentation/manager/profile\_settings\_controller.dart](/lib/features/profileSettings/presentation/manager/profile_settings_controller.dart) | Dart | 0 | 0 | -1 | -1 |

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details