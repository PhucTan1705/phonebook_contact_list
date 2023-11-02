import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rx_dart_phonebook/helpers/if_debugging.dart';
import 'package:rx_dart_phonebook/type_definitions.dart';

class RegisterView extends HookWidget {
  final RegisterFunction register;
  final VoidCallback goToLoginView;

  const RegisterView({
    required this.register,
    required this.goToLoginView,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(
      text: 'phuctan1705@gmail.com'.ifDebugging,
    );

    final passController = useTextEditingController(
      text: '1234556789'.ifDebugging,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng kí'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Nhập email...'),
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.dark,
            ),
            TextField(
              controller: passController,
              decoration: const InputDecoration(hintText: 'Nhập mật khẩu...'),
              obscureText: true,
              keyboardAppearance: Brightness.dark,
            ),
            TextButton(
              onPressed: () {
                final email = emailController.text;
                final pass = passController.text;
                register(
                  email,
                  pass,
                );
              },
              child: const Text('Đăng kí'),
            ),
            TextButton(
              onPressed: goToLoginView,
              child: const Text('Đã có tài khoản? Đăng nhập ngay!'),
            ),
          ],
        ),
      ),
    );
  }
}
