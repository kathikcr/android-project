import 'package:android_project/features/auth/model/user_model.dart';
import 'package:android_project/features/upload/long_video/video_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allChannelsProvider = Provider(
  (ref) async {
    final userMap = await FirebaseFirestore.instance.collection("users").get();
    List<UserModel> users = userMap.docs
        .map(
          (user) => UserModel.fromMap(
            user.data(),
          ),
        )
        .toList();
    return users;
  },
);
final allVideosProvider = Provider(
  (ref) async {
    final videosMap =
        await FirebaseFirestore.instance.collection("videos").get();
    List<VideoModel> videos = videosMap.docs
        .map(
          (video) => VideoModel.fromMap(
            video.data(),
          ),
        )
        .toList();
    return videos;
  },
);
