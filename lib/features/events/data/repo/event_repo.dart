import 'package:dartz/dartz.dart';
import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/features/events/data/models/event_attendee_model.dart';
import 'package:eventsmanager/features/events/data/models/event_invite_model.dart';
import 'package:eventsmanager/features/events/data/models/event_manager_model.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/data/models/user_search_model.dart';

abstract class EventRepository {
  Future<Either<ApiException, void>> createEvent({
    required String name,
    required String description,
    required double latitude,
    required double longitude,
    required String governorate,
    required DateTime startAt,
    required int duration,
    required int maxAttendees,
    required String visibility,
    required String paymentMethod,
    double? price,
    String? imagePath,
  });
  Future<Either<ApiException, String>> attendEvent(int eventId);

  /// PAGINATED
  Future<Either<ApiException, List<EventModel>>> getOrganizedEvents({
    required int page,
    required int limit,
  });

  Future<Either<ApiException, List<EventModel>>> getAttendedEvents({
    required int page,
    required int limit,
  });
  Future<Either<ApiException, List<EventModel>>> searchEvents({
    String? governorate,
    String? sort,
    String? name,
    required int page,
    required int limit,
  });

  Future<Either<ApiException, EventModel>> updateEvent({
    required int eventId,
    String? name,
    String? description,
    double? latitude,
    double? longitude,
    String? governorate,
    DateTime? startAt,
    int? duration,
    int? maxAttendees,
    String? visibility,
    String? imagePath,
    String? state,
  });

  Future<Either<ApiException, List<EventAttendeeModel>>> getEventAttendees({
    required int eventId,
    required int page,
    required int limit,
  });

  Future<Either<ApiException, void>> removeAttendee({
    required int eventId,
    required int attendeeId,
  });

  Future<Either<ApiException, List<EventManagerModel>>> getEventManagers({
    required int eventId,
    required int page,
    required int limit,
  });

  Future<Either<ApiException, void>> removeManager({
    required int eventId,
    required int managerId,
  });

  Future<Either<ApiException, EventModel>> getEventDetails(int eventId);

  Future<Either<ApiException, List<UserSearchModel>>> searchUsers({
    required String query,
    required int page,
    required int limit,
  });

  Future<Either<ApiException, void>> sendInvite({
    required int eventId,
    required int userId,
    required String role,
    List<String>? permissions,
  });

  Future<Either<ApiException, List<EventInviteModel>>> getEventInvites({
    required int eventId,
    required int page,
    required int limit,
  });
  Future<Either<ApiException, void>> resendInvite({
    required int eventId,
    required int inviteId,
  });

  Future<Either<ApiException, void>> verifyAttendance({
    required int eventId,
    required String attendanceCode,
  });

   Future<Either<ApiException, void>> leaveEvent({
    required int eventId,
  });
}