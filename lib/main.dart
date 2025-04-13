import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:social_lite/controllers/themeController.dart';
import 'package:social_lite/hive/hive_registrar.g.dart';
import 'package:social_lite/models/appSettings.dart';
import 'package:social_lite/screens/loginScreen.dart';
import 'package:social_lite/services/chatProvider.dart';
import 'package:social_lite/services/feedProvider.dart';
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
    final ThemeController themeController = Get.put(ThemeController());
    applySavedTheme();
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> FeedProvider()),
      ChangeNotifierProvider(create: (_)=> LoginProvider()),
      ChangeNotifierProvider(create: (_)=> ChatProvider()),
    ],
    child:  GetMaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        home: const LoginScreen(),
    ),
    );
  }
}
void applySavedTheme() async {
  final box = await Hive.openBox<Settings>('settings');
  final settings = box.get('theme');
  if (settings != null && settings.darkTheme) {
    Get.changeTheme(ThemeData.dark());
  } else {
    Get.changeTheme(ThemeData.light());
  }
}

