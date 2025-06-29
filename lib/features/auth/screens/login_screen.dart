import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/desktop_auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DesktopAuthController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onSubmitted: (_) => _submit(),
            ),
            Row(
              children: [
                Checkbox(value: rememberMe, onChanged: (v) { setState(() { rememberMe = v ?? false; }); }),
                const Text('Remember me'),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() => controller.isRefreshing.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Login'),
                  )),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      Get.find<DesktopAuthController>().login(email: email, password: password, rememberMe: rememberMe);
    }
  }
}
