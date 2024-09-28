import 'package:android_project/cores/screens/error_page.dart';
import 'package:android_project/cores/screens/loader.dart';
import 'package:android_project/features/auth/provider/user_provider.dart';
import 'package:android_project/features/channel/my_channel/repository/edit_field.dart';
import 'package:android_project/features/channel/my_channel/widgets/edit_setting_dialog.dart';
import 'package:android_project/features/channel/my_channel/widgets/setting_field_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChannelSettings extends ConsumerStatefulWidget {
  const ChannelSettings({super.key});

  @override
  ConsumerState<ChannelSettings> createState() => _ChannelSettingsState();
}

class _ChannelSettingsState extends ConsumerState<ChannelSettings> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserProvider).when(
          data: (currentUser) => Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 170,
                          width: double.infinity,
                          child: Image.asset(
                            "assets/flutter background.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 180,
                          top: 60,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey,
                            backgroundImage: CachedNetworkImageProvider(
                                currentUser.profilePic),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          top: 10,
                          child: Image.asset(
                            "asset/icon/camera.png",
                            height: 34,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    //second part
                    const SizedBox(
                      height: 14,
                    ),
                    SettingsItem(
                      identifier: "Name",
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => SettingsDialog(
                                  identifier: "Your New DisplayName",
                                  onSave: (name) {
                                    ref
                                        .watch(editSettingsProvider)
                                        .editDisplayName(name);
                                  },
                                ));
                      },
                      value: currentUser.displayName,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    SettingsItem(
                      identifier: "Handle",
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => SettingsDialog(
                                  identifier: "Your New UserName",
                                  onSave: (username) {
                                    ref
                                        .watch(editSettingsProvider)
                                        .editUserName(username);
                                  },
                                ));
                      },
                      value: currentUser.username,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    SettingsItem(
                      identifier: "Your New Description",
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => SettingsDialog(
                                  identifier: "Description",
                                  onSave: (description) {
                                    ref
                                        .watch(editSettingsProvider)
                                        .editDescription(description);
                                  },
                                ));
                      },
                      value: currentUser.description,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("keep all my subscribers private"),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              isSwitched = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Text(
                        "Changes made on your names and profile pictures are visible to youtube and no other google services",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          error: (error, stackTrace) => const ErrorPage(),
          loading: () => const Loader(),
        );
  }
}
