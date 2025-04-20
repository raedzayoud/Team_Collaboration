import 'package:collab_doc/feature/meetings/data/repos/meeting_repos.dart';
import 'package:collab_doc/main.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class MettingReposImpl implements MeetingRepos {
  final JitsiMeet jitsiMeet = JitsiMeet();
  @override
  Future<void> createMeeting(String roomName) async {
    try {
      var options = JitsiMeetConferenceOptions(
        serverURL: "https://meet.ffmuc.net",
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": true,
          "startWithVideoMuted": true,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: infoUserSharedPreferences.getString("username") ?? "",
          email: infoUserSharedPreferences.getString("email") ?? "",
        ),
      );
      await jitsiMeet.join(options);
    } catch (e) {
      print("Error starting meeting: $e");
      throw e;
    }
  }

  @override
  Future<void> joinMeeting(String roomName) async {
    createMeeting(roomName);
  }
}
