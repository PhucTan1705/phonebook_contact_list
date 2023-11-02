import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rx_dart_phonebook/helpers/if_debugging.dart';
import 'package:rx_dart_phonebook/type_definitions.dart';

class LoginView extends HookWidget {
  final LoginFunction login;
  final VoidCallback goToRegisterView;

  const LoginView({
    required this.login,
    required this.goToRegisterView,
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
        title: const Text('Đăng nhập'),
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
                login(
                  email,
                  pass,
                );
              },
              child: const Text('Đăng nhập'),
            ),
            TextButton(
              onPressed: goToRegisterView,
              child: const Text('Chưa có tài khoản? Đăng kí ngay!'),
            ),
          ],
        ),
      ),
    );
  }
}
