// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

import '../models/post.dart';

class FeedProvider extends GetConnect with ChangeNotifier {
  List<Post>? _posts = [];

  List<Post>? get posts => _posts;

  Future<void> loadPosts() async {
    var box = await Hive.openBox<Post>('post');
    Iterable<Post> posts = box.values;
    print(posts);
    _posts = posts.toList();
    notifyListeners();
  }

  Future<void> getPosts() async {
    var box = await Hive.openBox<Post>('post');
    get('http://192.168.1.15:8080/get').then((response) async => {
          _posts = parsePosts(response.body),
          for (var post in _posts!) {await box.add(post)},
          notifyListeners()
        });
  }

  List<Post> parsePosts(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Post.fromJson(json)).toList();
  }
}
