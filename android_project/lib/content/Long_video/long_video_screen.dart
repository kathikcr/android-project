import 'package:android_project/content/Long_video/parts/ImagePost.dart';
import 'package:android_project/content/Long_video/parts/post.dart';
import 'package:android_project/cores/screens/error_page.dart';
import 'package:android_project/cores/screens/loader.dart';
import 'package:android_project/features/upload/long_video/video_model.dart';
import 'package:android_project/features/upload/notes_upload/notes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LongVideoScreen extends StatelessWidget {
  const LongVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("videos").snapshots(),
        builder: (context, videoSnapshot) {
          if (!videoSnapshot.hasData) {
            return const ErrorPage();
          } else if (videoSnapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          final videosMap = videoSnapshot.data!.docs;
          final videos = videosMap.map((video) {
            return VideoModel.fromMap(video.data());
          }).toList();

          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection("notes").snapshots(),
            builder: (context, notesSnapshot) {
              if (!notesSnapshot.hasData) {
                return const ErrorPage();
              } else if (notesSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Loader();
              }

              final notesMap = notesSnapshot.data!.docs;
              final notes = notesMap.map((note) {
                return NotesModel.fromMap(note.data());
              }).toList();

              final combinedList = [...videos, ...notes];

              return Expanded(
                child: ListView.builder(
                  itemCount: combinedList.length,
                  itemBuilder: (context, index) {
                    final item = combinedList[index];

                    if (item is VideoModel) {
                      return Post(video: item);
                    } else if (item is NotesModel) {
                      return Imagepost(notes: item);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
