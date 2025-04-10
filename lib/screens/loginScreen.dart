import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:social_lite/screens/homeScreen.dart';
import 'package:social_lite/services/loginProvider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;

  String username = '';
  String password = '';

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    try {
      if (isLogin) {
        await loginProvider.login(username, password);
        Get.snackbar(duration: const Duration(seconds: 1),'Success', 'Logged in successfully');
        Get.offAll(()=> const HomeScreen());
      } else {
        await loginProvider.signUp(username, password);  // Changed email to username
        Get.snackbar('Success', 'Account created successfully');
      }

      // Navigate to home screen or whatever
      // Get.offAll(() => HomeScreen());
    } catch (e) {
      Get.snackbar(snackPosition:SnackPosition.BOTTOM,'Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Login' : 'Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Image(width:150,image: AssetImage("lib/assets/socialliteIcon.png")),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),  // Changed Email to Username
                onSaved: (val) => username = val!,
                validator: (val) => val!.isEmpty ? 'Enter username' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (val) => password = val!,
                validator: (val) =>
                val!.length < 6 ? 'Password too short' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isLogin ? 'Login' : 'Sign Up'),
              ),
              TextButton(
                onPressed: () => setState(() => isLogin = !isLogin),
                child: Text(
                    isLogin ? "Don't have an account?" : "Already registered?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
