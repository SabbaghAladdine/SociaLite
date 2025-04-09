// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:social_lite/screens/chatScreen.dart';
import 'package:social_lite/screens/settingsScreen.dart';
import 'package:social_lite/services/feedProvider.dart';

import '../widgets/postContainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final feedProvider = Provider.of<FeedProvider>(context, listen: false);
      feedProvider.loadPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final feedProvider = Provider.of<FeedProvider>(context, listen: true);
    final posts = feedProvider.posts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: ()=>{Get.to(const ChatScreen())},
              child: const Icon(Icons.chat_bubble,size: 30,),
            ),
          ),
          Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: ()=>{Get.to(const SettingsScreen())},
              child: const Icon(Icons.settings,size: 30,),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => await feedProvider.getPosts(),
        child: posts == null
            ? const Center(child: CircularProgressIndicator())
            : posts.isEmpty
            ? ListView(
          children: const [
            SizedBox(height: 150),
            Center(
              child: Text(
                'It seems the feed is empty.\nTry pulling down to refresh.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
            : ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostContainer(post: posts[index]);
          },
        ),
      ),
    );
  }
}
