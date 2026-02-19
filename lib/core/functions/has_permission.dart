import 'package:eventsmanager/features/events/data/models/event_model.dart';

bool hasPermission(
  List<EventPermission> userPermissions,
  EventPermission requiredPermission,
) {
  return userPermissions.contains(requiredPermission);
}

