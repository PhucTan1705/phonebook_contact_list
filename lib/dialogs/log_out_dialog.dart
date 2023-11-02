import 'package:flutter/material.dart' show BuildContext;
import 'package:rx_dart_phonebook/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Đăng xuất',
    content:
        'Bạn có muốn đăng xuất hay không? ',
    optionsBuilder: () => {
      'Không': false,
      'Đăng xuất': true,
    },
  ).then(
    (value) => value ?? false,
  );
}