// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:android_project/features/auth/model/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TopHeader extends StatelessWidget {
  final UserModel user;
  const TopHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 38,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(user.profilePic),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 4),
          child: Text(
            user.displayName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.blueGrey,
              ),
              children: [
                TextSpan(text: "${user.username}     "),
                TextSpan(text: "${user.subscription.length} subscription "),
                TextSpan(text: "${user.videos} videos"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
