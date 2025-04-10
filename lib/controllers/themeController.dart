import 'package:get/get.dart';

class ThemeController extends GetxController {
  // RxBool to manage the theme mode
  var isDarkMode = false.obs;

  // Switch theme mode
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}
