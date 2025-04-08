// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty Screen'),
      ),
      body: const Center(
        child: Text('This is an empty screen'),
      ),
    );
  }
}
