import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:collab_doc/feature/meetings/data/repos/meeting_repos.dart';
import 'package:meta/meta.dart';

part 'mettings_state.dart';

class MettingsCubit extends Cubit<MettingsState> {
  MeetingRepos mettingRepos;
  MettingsCubit(this.mettingRepos) : super(MettingsInitial());

  Future<void> createMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(1000) + 1000).toString();
    mettingRepos.createMeeting(roomName);
  }
  Future<void> joinMeeting(String roomName) async {
    mettingRepos.joinMeeting(roomName);
  }
}
