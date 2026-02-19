import 'package:eventsmanager/features/events/data/models/event_model.dart';

bool isEventStatic({required EventState eventState})=>
(eventState==EventState.cancelled||eventState==EventState.ongoing||eventState==EventState.completed) 
;