import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:zoomclone/controller/firestoremethords.dart';
import 'package:zoomclone/history.dart';
import 'package:zoomclone/join_meeting.dart';
import 'package:zoomclone/main.dart';
import 'package:zoomclone/schedule.dart';
import 'package:zoomclone/share.dart';
import 'package:zoomclone/utils/jistimeeting.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final Jitsimeeting _jitsimeeting = Jitsimeeting();
  CreateNewMeeting() async {
    Random rondom = Random();
    String roomName = (rondom.nextInt(10000000) + 10000000).toString();
    await _jitsimeeting.CreateMeeting(
        roomName: roomName, isaudiomuted: true, isvediomutted: true);

    firestoreMethords().addToMeetingHistory(roomName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.blueGrey.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "0:5",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                ),
                              ),
                              Text(
                                "sunday,August 13,2023",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )
                            ],
                          ),
                        )),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.grey,
                          ),
                          left: BorderSide(
                            color: Colors.grey,
                          ),
                          bottom: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("Today"),
                            subtitle: Text("0.5-0.6\nSaleema 's Meeting"),
                            isThreeLine: true,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.all(50),
                crossAxisSpacing: 40,
                mainAxisSpacing: 40,
                crossAxisCount: 2,
                children: [
                  ActionButtons(
                    buttonColor: Colors.deepOrangeAccent,
                    icon: Icons.video_call,
                    ButtonDiscription: "new Meeting",
                    buttonAcction: () {
                      CreateNewMeeting();
                    },
                  ),
                  ActionButtons(
                    buttonColor: Colors.lightBlueAccent,
                    icon: Icons.add,
                    ButtonDiscription: "join",
                    buttonAcction: () {
                      Get.to(JoinMeeting());
                    },
                  ),
                  ActionButtons(
                    buttonColor: Colors.lightBlueAccent,
                    icon: Icons.calendar_month,
                    ButtonDiscription: "schedule",
                    buttonAcction: () {
                      Get.to(Schedule());
                    },
                  ),
                  ActionButtons(
                    buttonColor: Colors.lightBlueAccent,
                    icon: Icons.share,
                    ButtonDiscription: "share",
                    buttonAcction: () {
                      Get.to(() => Share());
                    },
                  ),
                  ActionButtons(
                    buttonColor: Colors.lightBlueAccent,
                    icon: Icons.history,
                    ButtonDiscription: "history",
                    buttonAcction: () {
                      Get.to(() => History());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  ActionButtons(
      {super.key,
      required this.buttonColor,
      required this.ButtonDiscription,
      required this.buttonAcction,
      required this.icon});
  Color buttonColor;
  String ButtonDiscription;
  final VoidCallback buttonAcction;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            buttonAcction();
          },
          child: Container(
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(
              icon,
              size: 80,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(ButtonDiscription)
      ],
    );
  }
}
