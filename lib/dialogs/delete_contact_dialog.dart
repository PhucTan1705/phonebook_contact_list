import 'package:flutter/material.dart' show BuildContext;
import 'package:rx_dart_phonebook/dialogs/generic_dialog.dart';

Future<bool> showDeleteContactDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Xóa liên hệ',
    content:
        'Bạn có muốn xóa liên hệ này không? Bạn không thể không thể khôi phục liên hệ bị xóa!',
    optionsBuilder: () => {
      'Không': false,
      'Xóa': true,
    },
  ).then(
    (value) => value ?? false,
  );
}