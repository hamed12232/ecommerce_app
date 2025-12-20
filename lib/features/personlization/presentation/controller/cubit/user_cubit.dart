import 'package:ecommerce_app/features/personlization/data/models/user_model.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/fetch_user_details_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/remove_user_record_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/save_user_record_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/update_single_field_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/update_user_details_usecase.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_model_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserModelState> {
  final SaveUserRecordUseCase saveUserRecordUseCase;
  final FetchUserDetailsUseCase fetchUserDetailsUseCase;
  final UpdateUserDetailsUseCase updateUserDetailsUseCase;
  final UpdateSingleFieldUseCase updateSingleFieldUseCase;
  final RemoveUserRecordUseCase removeUserRecordUseCase;

  UserCubit({
    required this.saveUserRecordUseCase,
    required this.fetchUserDetailsUseCase,
    required this.updateUserDetailsUseCase,
    required this.updateSingleFieldUseCase,
    required this.removeUserRecordUseCase,
  }) : super(const UserModelState());

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // First Update Rx User and then check if user data is already stored. If not store new data
      await fetchUserRecord();

      // If no record already stored.
      if (state.user.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts = UserModel.nameParts(
            userCredentials.user!.displayName ?? '',
          );
          final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? '',
          );

          // Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1
                ? nameParts.sublist(1).join(' ')
                : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phone: userCredentials.user!.phoneNumber ?? '',
            profileImage: userCredentials.user!.photoURL ?? '',
            password: '',
          );

          // Save user data
          await saveUserRecordUseCase(user);
        }
      }
    } catch (e) {
      emit(
        state.copyWith(
          error:
              'Something went wrong while saving your information. You can re-save your data in your Profile.',
        ),
      );
    }
  }

  /// Fetch User Record
  Future<void> fetchUserRecord() async {
    emit(state.copyWith(loading: true));
    try {
      final result = await fetchUserDetailsUseCase();
      result.fold(
        (failure) {
          emit(state.copyWith(loading: false, error: failure.message));
        },
        (user) {
          emit(state.copyWith(loading: false, user: user));
        },
      );
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  /// Update User Details
  Future<void> updateUserDetails(UserModel updatedUser) async {
    emit(state.copyWith(profileLoading: true));
    try {
      final result = await updateUserDetailsUseCase(updatedUser);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              profileLoading: false,
              error: 'Something went wrong: ${failure.message}',
            ),
          );
        },
        (_) {
          emit(
            state.copyWith(
              profileLoading: false,
              user: updatedUser,
              successMessage: 'Your Profile has been updated!',
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          profileLoading: false,
          error: 'Something went wrong: $e',
        ),
      );
    }
  }

  /// Update any field in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    emit(state.copyWith(profileLoading: true));
    try {
      final result = await updateSingleFieldUseCase(json);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              profileLoading: false,
              error: 'Something went wrong: ${failure.message}',
            ),
          );
        },
        (_) {
          emit(
            state.copyWith(
              profileLoading: false,
              successMessage: 'Your Profile has been updated!',
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          profileLoading: false,
          error: 'Something went wrong: $e',
        ),
      );
    }
  }

  /// Function to remove user data from Firestore.
  Future<void> removeUserRecord(String userId) async {
    emit(state.copyWith(profileLoading: true));
    try {
      final result = await removeUserRecordUseCase(userId);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              profileLoading: false,
              error: 'Something went wrong: ${failure.message}',
            ),
          );
        },
        (_) {
          emit(
            state.copyWith(
              profileLoading: false,
              successMessage: 'Your account has been deleted!',
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          profileLoading: false,
          error: 'Something went wrong: $e',
        ),
      );
    }
  }
}
