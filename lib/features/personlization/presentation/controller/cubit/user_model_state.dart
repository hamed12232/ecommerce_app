import 'package:ecommerce_app/features/personlization/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

class UserModelState extends Equatable {
  final UserModel user;
  final bool loading;
  final bool profileLoading;
  final String error;
  final String? successMessage;
  final bool reAuthenticate;
  final bool accountDeleted;

  const UserModelState({
    this.user = const UserModel(
      id: '',
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      password: '',
      phone: '',
      profileImage: '',
    ),
    this.loading = false,
    this.profileLoading = false,
    this.error = '',
    this.successMessage,
    this.reAuthenticate = false,
    this.accountDeleted = false,
  });

  UserModelState copyWith({
    UserModel? user,
    bool? loading,
    bool? profileLoading,
    String? error,
    String? successMessage,
    bool? reAuthenticate,
    bool? accountDeleted,
  }) {
    return UserModelState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      profileLoading: profileLoading ?? this.profileLoading,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
      reAuthenticate: reAuthenticate ?? this.reAuthenticate,
      accountDeleted: accountDeleted ?? this.accountDeleted,
    );
  }

  @override
  List<Object?> get props => [
    user,
    loading,
    profileLoading,
    error,
    successMessage,
    reAuthenticate,
    accountDeleted,
  ];
}
