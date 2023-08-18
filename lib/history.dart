import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zoomclone/controller/firestoremethords.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: firestoreMethords().history,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: (snapshot.data as dynamic).docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      "Room Name:${(snapshot.data as dynamic).docs[index]['meetingName']}"),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
