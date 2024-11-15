import 'package:android_project/features/channel/my_channel/pages/about_page.dart';
import 'package:android_project/features/channel/my_channel/pages/home_channel_page.dart';
import 'package:android_project/features/channel/my_channel/pages/video_page_display.dart';
import 'package:flutter/material.dart';

class TabBarViewPage extends StatelessWidget {
  const TabBarViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TabBarView(
        children: [
          HomeChannelPage(),
          VideoPageDisplay(),
          // Center(
          //   child: Text("Shorts"),
          // ),
          // Center(
          //   child: Text("Community"),
          // ),
          // Center(
          //   child: Text("playlist"),
          // ),
          // Center(
          //   child: Text("channels"),
          // ),
          AboutPage(),
        ],
      ),
    );
  }
}
