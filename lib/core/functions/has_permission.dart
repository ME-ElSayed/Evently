import 'package:eventsmanager/features/events/data/models/event_permission.dart';

bool hasPermission(
  List<EventPermission> userPermissions,
  EventPermission requiredPermission,
) {
  return userPermissions.contains(requiredPermission);
}

