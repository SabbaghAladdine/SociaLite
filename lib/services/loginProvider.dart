// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import '../models/appuser.dart';

class LoginProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  int userIndex=-1;


  Future<void> signUp(String username, String password) async {
    var box = await Hive.openBox<User>('users');
    if (box.values.any((user) => user.username == username)) {
      Get.snackbar("Failure", "User already exists");
    }
    final newUser = User(username: username, password: password);
    await box.add(newUser);
    _currentUser = newUser;
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    var box = await Hive.openBox<User>('users');
    final user = box.values.firstWhere(
          (user) => user.username == username && user.password == password,
      orElse: () => throw Exception('Invalid credentials'),
    );
    _currentUser = user;
    notifyListeners();
  }

  Future<void> updateCurrentUser(User user) async {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    notifyListeners();
  }
}

