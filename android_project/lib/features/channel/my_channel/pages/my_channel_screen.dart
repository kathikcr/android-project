import 'package:android_project/cores/screens/error_page.dart';
import 'package:android_project/cores/screens/loader.dart';
import 'package:android_project/features/auth/provider/user_provider.dart';
import 'package:android_project/features/channel/my_channel/parts/buttons.dart';
import 'package:android_project/features/channel/my_channel/parts/tab_bar_view.dart';
import 'package:android_project/features/channel/my_channel/parts/tabbar.dart';
import 'package:android_project/features/channel/my_channel/parts/top_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyChannelScreen extends ConsumerWidget {
  const MyChannelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserProvider).when(
          data: (currentUser) => DefaultTabController(
            length: 7,
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      //top header
                      TopHeader(
                        user: currentUser,
                      ),

                      const Text("More info on the channel"),
                      const Buttons(),
                      //creating a tabbar
                      const Tabbar(),
                      const TabBarViewPage(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          error: (error, StackTrace) => const ErrorPage(),
          loading: () => const Loader(),
        );
  }
}
