import 'package:ecommerce_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.logoutUseCase) : super(const SettingsState());

  final LogoutUseCase logoutUseCase;

  Future<void> logout() async {
    emit(state.copyWith(status: SettingsStatus.loading));
    final result = await logoutUseCase.call();
    result.fold(
      (failure) => emit(
        state.copyWith(status: SettingsStatus.error, error: failure.message),
      ),
      (_) => emit(state.copyWith(status: SettingsStatus.success)),
    );
  }
}
