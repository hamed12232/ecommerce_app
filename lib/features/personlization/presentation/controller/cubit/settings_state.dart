part of 'settings_cubit.dart';

enum SettingsStatus { initial, loading, success, error }

class SettingsState {
  final SettingsStatus status;
  final String? error;

  const SettingsState({this.status = SettingsStatus.initial, this.error});

  SettingsState copyWith({SettingsStatus? status, String? error}) {
    return SettingsState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
