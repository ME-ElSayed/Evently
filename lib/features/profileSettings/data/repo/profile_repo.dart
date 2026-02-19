import 'package:dartz/dartz.dart';
import 'package:eventsmanager/core/services/api/api_exceptions.dart';
import 'package:eventsmanager/core/services/api/api_service.dart';
import 'package:eventsmanager/core/services/shared_pref_service.dart';
import 'package:eventsmanager/features/profileSettings/data/models/user_model.dart';
import 'package:get/get.dart';

abstract class ProfileRepository {
  Future<Either<ApiException, UserModel>> getProfile();
  Future<Either<ApiException, UserModel>> updateProfile({
    String? name,
    String? username,
    String? governorate,
    String? profileImagePath,
  });
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiService _apiService = Get.find<ApiService>();
  final SharedprefService _prefs = Get.find<SharedprefService>();

  // ==================== GET PROFILE ====================

  @override
  Future<Either<ApiException, UserModel>> getProfile() async {
    try {
      final response = await _apiService.getProfile();

      if (response['success'] == true) {
        final userJson = response['data']['user'];
        final user = UserModel.fromJson(userJson);

        // Persist user locally
        await _prefs.setUserData(user.toJson());

        return Right(user);
      }

      return Left(
        ApiException(message: 'Failed to fetch profile'),
      );
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        ApiException(message: e.toString()),
      );
    }
  }

  // ==================== UPDATE PROFILE ====================

  @override
  Future<Either<ApiException, UserModel>> updateProfile({
    String? name,
    String? username,
    String? governorate,
    String? profileImagePath,
  }) async {
    try {
      final response = await _apiService.updateProfile(
        name: name,
        username: username,
        governorate: governorate,
        profileImagePath: profileImagePath,
      );

      if (response['success'] == true && response['data'] != null) {
        // FIXED: API returns user directly in data.user, not nested deeper
        final userJson = response['data']['user'];
        final updatedUser = UserModel.fromJson(userJson);

        // Persist updated user
        await _prefs.setUserData(updatedUser.toJson());

        return Right(updatedUser);
      }

      return Left(
        ApiException(message: 'Failed to update profile'),
      );
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        ApiException(message: e.toString()),
      );
    }
  }
}