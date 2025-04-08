import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:social_lite/hive/hive_registrar.g.dart';
import 'package:social_lite/screens/loginScreen.dart';
import 'package:social_lite/services/loginProvider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapters();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> LoginProvider())
    ],
    child: const GetMaterialApp(
        home: LoginScreen(),
    ),
    );
  }
}

