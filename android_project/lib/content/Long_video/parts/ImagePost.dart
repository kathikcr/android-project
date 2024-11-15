// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:android_project/content/Long_video/parts/imageDisplay.dart';
import 'package:android_project/features/auth/model/user_model.dart';
import 'package:android_project/features/auth/provider/user_provider.dart';
import 'package:android_project/features/upload/notes_upload/notes_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Imagepost extends ConsumerWidget {
  final NotesModel notes;

  const Imagepost({
    required this.notes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserModel> userModel =
        ref.watch(anyUserDataProvider(notes.userId));
    final user = userModel.whenData((user) => user);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDisplay(imageNote: notes),
          ),
        );
        FirebaseFirestore.instance
            .collection("notes")
            .doc(notes.noteId)
            .update({
          "views": FieldValue.increment(1),
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: [
            CachedNetworkImage(imageUrl: notes.thumbnail),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 5),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        CachedNetworkImageProvider(user.value!.profilePic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    notes.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width * 0.12),
              child: Row(
                children: [
                  Text(
                    user.value!.displayName,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      notes.views == 0 ? "No View" : "${notes.views} ",
                      style: const TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  const Text(
                    "a moment ago",
                    style: TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
