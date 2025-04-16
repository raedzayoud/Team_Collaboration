import 'package:bloc/bloc.dart';
import 'package:collab_doc/feature/settings/data/repos/settings_repos.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepos settingsRepos;
  SettingsCubit(this.settingsRepos) : super(SettingsInitial());
  Future<void> updateProfile({required String username}) async {
    try {
      emit(SettingsLoading());
      final result = await settingsRepos.updateProfile(username: username);
      result.fold(
        (failure) => emit(SettingsFailure(message: failure.errorMessage)),
        (success) => emit(SettingsSuccess()),
      );
    } on Exception catch (e) {
      emit(SettingsFailure(message: e.toString()));
    }
  }
}
