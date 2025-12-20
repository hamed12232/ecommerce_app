import 'dart:io';

import 'package:ecommerce_app/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/re_authenticate_usecase.dart';
import 'package:ecommerce_app/features/personlization/data/models/user_model.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/fetch_user_details_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/remove_user_record_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/save_user_record_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/update_single_field_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/update_user_details_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/upload_image_usecase.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_model_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserCubit extends Cubit<UserModelState> {
  final SaveUserRecordUseCase saveUserRecordUseCase;
  final FetchUserDetailsUseCase fetchUserDetailsUseCase;
  final UpdateUserDetailsUseCase updateUserDetailsUseCase;
  final UpdateSingleFieldUseCase updateSingleFieldUseCase;
  final RemoveUserRecordUseCase removeUserRecordUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final ReAuthenticateUseCase reAuthenticateUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final UploadImageUseCase uploadImageUseCase;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final updateNameFormKey = GlobalKey<FormState>();

  final reAuthEmailController = TextEditingController();
  final reAuthPasswordController = TextEditingController();
  final reAuthFormKey = GlobalKey<FormState>();

  UserCubit({
    required this.saveUserRecordUseCase,
    required this.fetchUserDetailsUseCase,
    required this.updateUserDetailsUseCase,
    required this.updateSingleFieldUseCase,
    required this.removeUserRecordUseCase,
    required this.deleteAccountUseCase,
    required this.reAuthenticateUseCase,
    required this.loginWithGoogleUseCase,
    required this.uploadImageUseCase,
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
          emit(state.copyWith(profileLoading: false));
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

  /// Function to delete user account - orchestrates the deletion process.
  Future<void> deleteUserAccount() async {
    try {
      final auth = FirebaseAuth.instance;
      final provider = auth.currentUser!.providerData
          .map((e) => e.providerId)
          .first;

      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          emit(state.copyWith(loading: true));
          final result = await loginWithGoogleUseCase();
          await result.fold(
            (failure) async =>
                emit(state.copyWith(loading: false, error: failure.message)),
            (_) async => await deleteAccount(),
          );
        } else if (provider == 'password') {
          emit(state.copyWith(reAuthenticate: true));
        }
      }
    } catch (e) {
      emit(state.copyWith(loading: false, error: 'Oh Snap!: $e'));
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser(
    String email,
    String password,
  ) async {
    emit(state.copyWith(loading: true));
    try {
      final result = await reAuthenticateUseCase(email, password);
      await result.fold(
        (failure) async =>
            emit(state.copyWith(loading: false, error: failure.message)),
        (_) async {
          await deleteAccount();
        },
      );
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  /// Initialize Name controllers
  void initializeNames() {
    firstNameController.text = state.user.firstName;
    lastNameController.text = state.user.lastName;
  }

  /// Toggle Hide Password
  void toggleHidePassword() {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }

  /// Clear re-auth controllers
  void clearReAuthControllers() {
    reAuthEmailController.clear();
    reAuthPasswordController.clear();
  }

  /// Upload User Profile Image
  Future<void> uploadUserProfileImage() async {
    try {
      final imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        emit(state.copyWith(profileLoading: true));
        final path =
            'Users/Images/Profile/${DateTime.now().millisecondsSinceEpoch}.png';
        final result = await uploadImageUseCase(path, File(image.path));

        result.fold(
          (failure) {
            emit(state.copyWith(profileLoading: false, error: failure.message));
          },
          (url) async {
            // Update Firestore with new image URL
            await updateSingleFieldUseCase({'profileImage': url});
            // Update local state
            emit(
              state.copyWith(
                profileLoading: false,
                user: state.user.copyWith(profileImage: url),
                successMessage: "Profile image updated successfully!",
              ),
            );
          },
        );
      }
    } catch (e) {
      emit(state.copyWith(profileLoading: false, error: e.toString()));
    }
  }

  /// Finalize account deletion
  Future<void> deleteAccount() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final result = await deleteAccountUseCase();
      await result.fold(
        (failure) async =>
            emit(state.copyWith(loading: false, error: failure.message)),
        (_) async {
          await removeUserRecord(userId);
          emit(
            state.copyWith(
              loading: false,
              accountDeleted: true,
              successMessage: 'Your account has been deleted!',
            ),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  /// Reset deletion flags
  void resetDeletionFlags() {
    emit(
      state.copyWith(reAuthenticate: false, accountDeleted: false, error: ''),
    );
  }

  /// Clear any error message
  void clearError() {
    emit(state.copyWith(error: ''));
  }

  /// Clear success message
  void clearSuccess() {
    emit(state.copyWith(successMessage: ''));
  }

  /// Clear user data
  void clearUserData() {
    emit(const UserModelState());
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    reAuthEmailController.dispose();
    reAuthPasswordController.dispose();
    return super.close();
  }
}
