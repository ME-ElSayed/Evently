import 'package:dartz/dartz.dart';
import 'package:eventsmanager/core/services/api/api_exceptions.dart';
import 'package:eventsmanager/core/services/api/api_service.dart';
import 'package:eventsmanager/features/events/data/models/event_attendee_model.dart';
import 'package:eventsmanager/features/events/data/models/event_invite_model.dart';
import 'package:eventsmanager/features/events/data/models/event_manager_model.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/data/models/user_search_model.dart';
import 'package:get/get.dart';

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

class EventRepositoryImpl implements EventRepository {
  final ApiService _api = Get.find<ApiService>();

  @override
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
  }) async {
    try {
      await _api.createEvent(
        name: name,
        description: description,
        latitude: latitude,
        longitude: longitude,
        governorate: governorate,
        startAt: startAt,
        duration: duration,
        maxAttendees: maxAttendees,
        visibility: visibility,
        paymentMethod: paymentMethod,
        price: price,
        imagePath: imagePath,
      );

      return const Right(null);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, List<EventModel>>> getOrganizedEvents({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _api.getOrganizedEvents(
        page: page,
        limit: limit,
      );

      final events = (response['data']['events'] as List)
          .map((e) => EventModel.fromJson(e))
          .toList();

      return Right(events);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, List<EventModel>>> getAttendedEvents({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _api.getAttendedEvents(
        page: page,
        limit: limit,
      );

      final events = (response['data']['events'] as List)
          .map((e) => EventModel.fromJson(e))
          .toList();

      return Right(events);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, String>> attendEvent(int eventId) async {
    try {
      final response = await _api.attendEvent(eventId);

      // Extract attendance code from response
      // Response structure: { "success": true, "data": { "attendanceCode": "uuid" } }
      final attendanceCode = response['data']['attendanceCode'] as String;

      return Right(attendanceCode);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, List<EventModel>>> searchEvents({
    String? governorate,
    String? sort,
    String? name,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _api.searchEvents(
        governorate: governorate,
        sort: sort,
        name: name,
        page: page,
        limit: limit,
      );

      final events = (response['data']['events'] as List)
          .map((e) => EventModel.fromJson(e))
          .toList();

      return Right(events);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, EventModel>> getEventDetails(int eventId) async {
    try {
      final response = await _api.getEventById(eventId);

      final eventJson = response['data']['event'];
      final event = EventModel.fromJson(eventJson);

      return Right(event);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
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
  }) async {
    try {
      final response = await _api.updateEvent(
          eventId: eventId,
          name: name,
          description: description,
          latitude: latitude,
          longitude: longitude,
          governorate: governorate,
          startAt: startAt,
          duration: duration,
          maxAttendees: maxAttendees,
          visibility: visibility,
          imagePath: imagePath,
          state: state);

      final eventJson = response['data']['event'];
      final event = EventModel.fromJson(eventJson);

      return Right(event);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, List<EventAttendeeModel>>> getEventAttendees({
    required int eventId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _api.getEventAttendees(
        eventId: eventId,
        page: page,
        limit: limit,
      );

      final attendees = (response['data']['attendees'] as List)
          .map((e) => EventAttendeeModel.fromJson(e))
          .toList();

      return Right(attendees);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> removeAttendee({
    required int eventId,
    required int attendeeId,
  }) async {
    try {
      await _api.removeAttendee(
        eventId: eventId,
        attendeeId: attendeeId,
      );

      return const Right(null);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, List<EventManagerModel>>> getEventManagers({
    required int eventId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _api.getEventManagers(
        eventId: eventId,
        page: page,
        limit: limit,
      );

      final managers = (response['data']['managers'] as List)
          .map((e) => EventManagerModel.fromJson(e))
          .toList();

      return Right(managers);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> removeManager({
    required int managerId,
    required int eventId,
  }) async {
    try {
      await _api.removeManager(
        eventId: eventId,
        managerId: managerId,
      );

      return const Right(null);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

//invites
  @override
  Future<Either<ApiException, List<UserSearchModel>>> searchUsers({
    required String query,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _api.searchUsers(
        query: query,
        page: page,
        limit: limit,
      );

      final users = (response['data']['users'] as List)
          .map((e) => UserSearchModel.fromJson(e))
          .toList();

      return Right(users);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> sendInvite({
    required int eventId,
    required int userId,
    required String role,
    List<String>? permissions,
  }) async {
    try {
      await _api.sendInvite(
        eventId: eventId,
        userId: userId,
        role: role,
        permissions: permissions,
      );

      return const Right(null);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, List<EventInviteModel>>> getEventInvites({
    required int eventId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _api.getEventInvites(
        eventId: eventId,
        page: page,
        limit: limit,
      );

      final invites = (response['data']['invites'] as List)
          .map((e) => EventInviteModel.fromJson(e))
          .toList();

      return Right(invites);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> resendInvite({
    required int eventId,
    required int inviteId,
  }) async {
    try {
      await _api.resendInvite(inviteId: inviteId, eventId: eventId);

      return const Right(null);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> verifyAttendance({
    required int eventId,
    required String attendanceCode,
  }) async {
    try {
      await _api.verifyAttendance(
        eventId: eventId,
        attendanceCode: attendanceCode,
      );

      return const Right(null);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> leaveEvent({
    required int eventId,
  }) async {
    try {
      await _api.leaveEvent(
        eventId: eventId,
      );

      return const Right(null);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}
