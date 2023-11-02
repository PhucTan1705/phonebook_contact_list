import 'package:flutter/material.dart';
import 'package:rx_dart_phonebook/dialogs/generic_dialog.dart';

Future<bool> showDelereAccountDialog({
  required BuildContext context,
}) {
  return showGenericDialog(
    context: context,
    title: 'Xóa tài khoản',
    content: 'Bạn có chắc muốn xóa tài khoản không?',
    optionsBuilder:() => {
      'Không': false,
      'Xóa': true,
    },
  ).then((value) => value ?? false);
}
