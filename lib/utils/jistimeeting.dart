import 'package:firebase_auth/firebase_auth.dart';
import 'package:jitsi_meet_fix/feature_flag/feature_flag.dart';
import 'package:jitsi_meet_fix/jitsi_meet.dart';

class Jitsimeeting {
  CreateMeeting(
      {required String roomName,
      required bool isaudiomuted,
      required bool isvediomutted}) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p

      var options = JitsiMeetingOptions(room: roomName)
        // ..room = "myroom" // Required, spaces will be trimmed
        // ..serverURL = "https://someHost.com"
        ..userDisplayName = FirebaseAuth.instance.currentUser!.displayName
        ..userEmail = FirebaseAuth.instance.currentUser!.email
        ..userAvatarURL = FirebaseAuth.instance.currentUser!.photoURL // or .png
        ..audioOnly = isvediomutted
        ..audioMuted = isaudiomuted
        ..videoMuted = true;
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
