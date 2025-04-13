import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_lite/models/appSettings.dart';
import 'package:social_lite/screens/loginScreen.dart';
import 'package:social_lite/services/chatProvider.dart';
import 'package:social_lite/services/loginProvider.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
 const SettingsScreen({super.key});


  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  bool _expanded = false;
  var isDarkMode = Get.isDarkMode.obs;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<LoginProvider>(context, listen: false).currentUser;
    _usernameController = TextEditingController(text: user?.username ?? '');
    _passwordController = TextEditingController(text: user?.password ?? '');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    var user = loginProvider.currentUser;
    if (user != null) {
      user.username = _usernameController.text;
      user.password = _passwordController.text;
      user.save().whenComplete((){
        Get.snackbar("success", "User Profile Updated");
        loginProvider.updateCurrentUser(user);
        _usernameController.clear();
        _passwordController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ExpansionTile(
            title: const Text('Edit Profile'),
            initiallyExpanded: _expanded,
            onExpansionChanged: (value) {
              setState(() {
                _expanded = value;
              });
            },
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Save Changes'),
              ),

            ],
          ),
          ListTile(
            title: const Text("Change Theme"),
            trailing: IconButton(
              icon: Icon(Get.isDarkMode
                  ? Icons.brightness_7 // Sun icon for light mode
                  : Icons.brightness_3), // Moon icon for dark mode
              onPressed: changeTheme,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              logout(context);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Future<void> changeTheme() async {
    final box = await Hive.openBox<Settings>('settings');
    bool useDark = !Get.isDarkMode;
    Get.changeTheme(useDark ? ThemeData.dark() : ThemeData.light());
    await box.put('theme', Settings(darkTheme: useDark));
    debugPrint('Theme saved: ${box.get('theme')?.darkTheme}');
  }

  void logout(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    loginProvider.logout();
    chatProvider.disconnectSocket();
    Get.offAll(()=> const LoginScreen());
  }
}
