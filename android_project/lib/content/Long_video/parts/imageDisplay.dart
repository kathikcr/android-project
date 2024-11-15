// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:android_project/content/Long_video/widgets/video_external_buttons.dart';
import 'package:android_project/content/Long_video/widgets/video_first_comment.dart';
import 'package:android_project/content/comment/comment_provider.dart';
import 'package:android_project/content/comment/image_comment_sheet.dart';
import 'package:android_project/cores/screens/loader.dart';
import 'package:android_project/cores/widgets/colors.dart';
import 'package:android_project/cores/widgets/flat_button.dart';
import 'package:android_project/features/auth/model/user_model.dart';
import 'package:android_project/features/auth/provider/user_provider.dart';
import 'package:android_project/features/channel/users_channel/subscribe_repository.dart';
import 'package:android_project/features/upload/comments/comment_model.dart';
import 'package:android_project/features/upload/notes_upload/notes_model.dart';
import 'package:android_project/features/upload/notes_upload/notes_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageDisplay extends ConsumerStatefulWidget {
  final NotesModel imageNote; // Changed parameter to NotesModel for images
  const ImageDisplay({
    super.key,
    required this.imageNote,
  });

  @override
  ConsumerState<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends ConsumerState<ImageDisplay> {
  likeVideo() async {
    await ref.watch(imageProvider).likeNotes(
        likes: widget.imageNote.likes,
        noteId: widget.imageNote.noteId,
        currentUserId: FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<UserModel> user = ref.watch(anyUserDataProvider(widget
        .imageNote.userId)); // Updated to fetch user details using image userId
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // Displaying uploaded image instead of video
            CachedNetworkImage(
              imageUrl: widget.imageNote.notesUrl,
              placeholder: (context, url) => Loader(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13.0, top: 4),
              child: Text(
                widget.imageNote.title,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7, top: 5),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 4),
                    child: Text(
                      widget.imageNote.views == 0
                          ? "No Views"
                          : "${widget.imageNote.views} views",
                      style: const TextStyle(
                        fontSize: 13.4,
                        color: Color(0xff5F5F5F),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 8),
                    child: Text(
                      "5 minutes ago",
                      style: const TextStyle(
                        fontSize: 13.4,
                        color: Color(0xff5F5F5F),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                top: 9,
                right: 9,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        CachedNetworkImageProvider(user.value!.profilePic),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 5,
                    ),
                    child: Text(
                      user.value!.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0, left: 6),
                    child: Text(
                      user.value!.subscription.isEmpty
                          ? "No Subscriptions"
                          : "${user.value!.subscription.length} subscriptions",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: FlatButton(
                        text: "Subscribe",
                        onPressed: () async {
                          await ref
                              .watch(SubscribeChannelProvider)
                              .subscribeChannel(
                                userId: user.value!.userId,
                                currentUserId:
                                    FirebaseAuth.instance.currentUser!.uid,
                                subscriptions: user.value!.subscription,
                              );
                        },
                        colour: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9, top: 10.5, right: 9),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 6,
                      ),
                      decoration: const BoxDecoration(
                        color: softBlueGreyBackGround,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: likeVideo,
                            child: Icon(
                              Icons.thumb_up,
                              color: widget.imageNote.likes.contains(
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? Colors.blue
                                  : Colors.black,
                              size: 15.5,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("${widget.imageNote.likes.length}"),
                          const SizedBox(width: 19),
                          const Icon(
                            Icons.thumb_down,
                            size: 15.5,
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 9, right: 9),
                      child: VideoExtraButton(
                        text: "Share",
                        iconData: Icons.share,
                      ),
                    ),
                    const VideoExtraButton(
                      text: "Remix",
                      iconData: Icons.analytics_outlined,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 9, right: 9),
                      child: VideoExtraButton(
                        text: "Download",
                        iconData: Icons.download,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9, top: 10.5, right: 9),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 10,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => ImageCommentSheet(
                              notes: widget.imageNote,
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          height: 70,
                          width: 400,
                          child: Consumer(
                            builder: (context, ref, child) {
                              final AsyncValue<List<CommentModel>> comments =
                                  ref.watch(commentsProvider(
                                      widget.imageNote.noteId));
                              if (comments.value!.isEmpty) {
                                return const SizedBox();
                              }
                              return VideoFirstComment(
                                comments: comments.value!,
                                user: user.value!,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
