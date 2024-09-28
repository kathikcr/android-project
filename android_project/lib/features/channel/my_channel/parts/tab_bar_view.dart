import 'package:flutter/material.dart';

class TabBarViewPage extends StatelessWidget {
  const TabBarViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TabBarView(
        children: [
          Center(
            child: Text("Home"),
          ),
          Center(
            child: Text("Videos"),
          ),
          Center(
            child: Text("Shorts"),
          ),
          Center(
            child: Text("Community"),
          ),
          Center(
            child: Text("playlist"),
          ),
          Center(
            child: Text("channels"),
          ),
          Center(
            child: Text("about"),
          ),
        ],
      ),
    );
  }
}
