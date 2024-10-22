// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:android_project/content/bottom_navigation.dart';
import 'package:android_project/cores/screens/error_page.dart';
import 'package:android_project/cores/screens/loader.dart';
import 'package:android_project/cores/widgets/image_button.dart';
import 'package:android_project/features/account/account_page.dart';
import 'package:android_project/features/auth/provider/user_provider.dart';
import 'package:android_project/features/upload/upload_bottom_sheet.dart';
import 'package:android_project/pages_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 36,
                ),
                const SizedBox(width: 4),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(
                    height: 42,
                    child: ImageButton(
                      image: "cast.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: 38,
                  child: ImageButton(
                    image: "notification.png",
                    onPressed: () {},
                    haveColor: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 15),
                  child: SizedBox(
                    height: 41.5,
                    child: ImageButton(
                      image: 'search.png',
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(currentUserProvider).when(
                          data: (currentUser) => Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AccountPage(
                                      user: currentUser,
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.grey,
                                backgroundImage: CachedNetworkImageProvider(
                                    currentUser.profilePic),
                              ),
                            ),
                          ),
                          error: (error, StackTrace) => const ErrorPage(),
                          loading: () => const Loader(),
                        );
                  },
                ),
              ],
            ),
            Expanded(
              child: pages[currentIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        onpressed: (index) {
          if (index != 1) {
            currentIndex = index;
            setState(() {});
          } else {
            showModalBottomSheet(
              context: context,
              builder: (context) => const CreateBottomSheet(),
            );
          }
        },
      ),
    );
  }
}
