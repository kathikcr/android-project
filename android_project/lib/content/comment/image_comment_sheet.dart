// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:android_project/content/comment/comment_tile.dart';
import 'package:android_project/cores/screens/error_page.dart';
import 'package:android_project/cores/screens/loader.dart';
import 'package:android_project/features/auth/provider/user_provider.dart';
import 'package:android_project/features/upload/comments/comment_model.dart';
import 'package:android_project/features/upload/comments/comment_repository.dart';
import 'package:android_project/features/upload/notes_upload/notes_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageCommentSheet extends ConsumerStatefulWidget {
  final NotesModel notes;
  const ImageCommentSheet({
    required this.notes,
  });

  @override
  ConsumerState<ImageCommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends ConsumerState<ImageCommentSheet> {
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).whenData((user) => user);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
            ),
            child: const Text(
                "Remember to keep comments respectful and to follow our community and guideline"),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("comments")
                .where("noteId", isEqualTo: widget.notes.noteId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const ErrorPage();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              final commentsMap = snapshot.data!.docs;
              final List<CommentModel> comments = commentsMap
                  .map((comment) => CommentModel.fromMap(comment.data()))
                  .toList();
              return Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return CommentTile(
                      comment: comments[index],
                    );
                  },
                ),
              );
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 8, left: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(
                    user.value!.profilePic,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 45,
                  width: 275,
                  child: TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: "Add a comment",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await ref.watch(commentProvider).uploadCommentToFirestore(
                          commentText: commentController.text,
                          videoId: widget.notes.noteId,
                          displayName: user.value!.displayName,
                          profilePic: user.value!.profilePic,
                        );
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.green,
                    size: 35,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
