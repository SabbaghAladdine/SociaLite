import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:social_lite/models/appSettings.dart';

class ThemeController extends GetxController {
  // RxBool to manage the theme mode

  var isDarkMode = false.obs;

  // Switch theme mode
  Future<void> toggleTheme() async {
    var box = await Hive.openBox<Settings>('settings');

    box.values.isEmpty?isDarkMode.value=false:{
      isDarkMode.value = box.get('theme')!.darkTheme
    };

  }
}
