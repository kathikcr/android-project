import 'package:android_project/content/Long_video/parts/post.dart';
import 'package:android_project/cores/widgets/custom_button.dart';
import 'package:android_project/features/auth/model/user_model.dart';
import 'package:android_project/features/search/providers/search_provider.dart';
import 'package:android_project/features/search/widgets/search_channel_title_widget.dart';
import 'package:android_project/features/upload/long_video/video_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List foundItems = [];

  Future<void> filterList(String keywordSelected) async {
    List<UserModel> users = await ref.watch(allChannelsProvider);

    List results = [];

    final foundChannels = users.where((user) {
      return user.displayName
          .toString()
          .toLowerCase()
          .contains(keywordSelected);
    }).toList();

    results.addAll(foundChannels);

    final List<VideoModel> video = await ref.watch(allVideosProvider);

    final foundVideos = video.where((video) {
      return video.title.toString().toLowerCase().contains(keywordSelected);
    }).toList();

    results.addAll(foundVideos);
    setState(() {
      results.shuffle();
      foundItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(
                    height: 43,
                    width: 279,
                    child: TextFormField(
                      onChanged: (value) async {
                        await filterList(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Search For Content Here...",
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xfff2f2f2),
                        contentPadding: const EdgeInsets.only(
                          left: 13,
                          bottom: 12,
                        ),
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 43,
                    width: 55,
                    child: CustomButton(
                      iconData: Icons.search,
                      onTap: () {},
                      haveColor: true,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: foundItems.length,
                  itemBuilder: (context, index) {
                    List<Widget> itemsWidgets = [];
                    final selectedItem = foundItems[index];
                    if (selectedItem.type == "video") {
                      itemsWidgets.add(
                        Post(video: selectedItem),
                      );
                    }
                    if (selectedItem.type == "user") {
                      itemsWidgets.add(
                        SearchChannelTitleWidget(
                          user: selectedItem,
                        ),
                      );
                    }
                    if (foundItems.isEmpty) {
                      return const SizedBox();
                    }
                    return itemsWidgets[0];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
