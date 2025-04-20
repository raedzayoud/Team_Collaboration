import 'package:bloc/bloc.dart';
import 'package:collab_doc/feature/chatroom/data/repos/chatroom_repo.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:meta/meta.dart';

part 'chatroom_state.dart';

class ChatroomCubit extends Cubit<ChatroomState> {
  ChatroomRepo chatroomRepo;
  ChatroomCubit(this.chatroomRepo) : super(ChatroomInitial());
  Future<void> getAllTeams() async {
    try {
      emit(ChatroomLoading());
      final result = await chatroomRepo.getAllTeams();
      result.fold(
        (failure) => emit(ChatroomFailure(failure.errorMessage)),
        (teams) => emit(ChatroomSuccess(teams)),
      );
    } on Exception catch (e) {
      emit(ChatroomFailure(e.toString()));
    }
  }
}
