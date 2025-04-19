import 'package:bloc/bloc.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:collab_doc/feature/teams/data/repos/teams_repo.dart';
import 'package:meta/meta.dart';

part 'team_state.dart';

class TeamCubit extends Cubit<TeamState> {
  TeamsRepo teamsRepo;
  TeamCubit(this.teamsRepo) : super(TeamInitial());

  Future<void> AddNewTeam(
      String teamName, String teamDescription, String maxteamMembers) async {
    try {
      emit(TeamLoading());
      final result =
          await teamsRepo.addNewTeam(teamName, teamDescription, maxteamMembers);
      result.fold(
          (failure) => emit(TeamFailure(errorsMessage: failure.errorMessage)),
          (success) => emit(TeamSuccess()));
    } catch (e) {
      emit(TeamFailure(errorsMessage: e.toString()));
    }
  }

  Future<void>getAllMyTeam()async{
    try {
      emit(MyTeamLoading());
      final result =
          await teamsRepo.getMyTeams();
      result.fold(
          (failure) => emit(MyTeamFailure(errorsMessage: failure.errorMessage)),
          (success) => emit(MyTeamSuccess(myteams: success)));
    } catch (e) {
      emit(TeamFailure(errorsMessage: e.toString()));
    }
  }

  Future<void>getAllMyTeamAsmemeber()async{
    try {
      emit(MyTeamLoading());
      final result =
          await teamsRepo.getMyTeamsAsMemeber();
      result.fold(
          (failure) => emit(MyTeamFailure(errorsMessage: failure.errorMessage)),
          (success) => emit(MyTeamSuccess(myteams: success)));
    } catch (e) {
      emit(TeamFailure(errorsMessage: e.toString()));
    }
  }
}
