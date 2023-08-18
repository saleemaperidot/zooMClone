import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zoomclone/controller/firestoremethords.dart';
import 'package:zoomclone/utils/jistimeeting.dart';

class JoinMeeting extends StatefulWidget {
  JoinMeeting({super.key});

  @override
  State<JoinMeeting> createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController _roonIdController = TextEditingController();

  TextEditingController _username = TextEditingController();

  bool isVedioMuted = false;

  bool isAudioMutted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextFormField(
            controller: _roonIdController,
          ),
          TextFormField(
            controller: _username,
          ),
          Switch(
            value: isVedioMuted,
            onChanged: (value) {
              setState(() {
                isVedioMuted = value;
              });
            },
          ),
          Switch.adaptive(
            value: isAudioMutted,
            onChanged: (value) {
              setState(() {
                isAudioMutted = value;
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                _joinMeeting();
              },
              child: Text("join"))
        ],
      )),
    );
  }

  _joinMeeting() {
    Jitsimeeting _jitsMetting = Jitsimeeting();

    _jitsMetting.CreateMeeting(
        roomName: _roonIdController.text,
        isaudiomuted: isAudioMutted,
        isvediomutted: isVedioMuted);

    firestoreMethords().addToMeetingHistory(_roonIdController.text);
  }
}
