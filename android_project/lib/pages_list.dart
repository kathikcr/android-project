import 'package:android_project/content/Long_video/long_video_screen.dart';
import 'package:android_project/features/auth/pages/logout_page.dart';
import 'package:android_project/features/search/pages/search_screen.dart';
import 'package:flutter/material.dart';

List pages = const [
  LongVideoScreen(),
  // Center(child: Text("shorts")),
  Center(child: Text("upload")),
  SearchScreen(),
  LogoutPage(),
];
