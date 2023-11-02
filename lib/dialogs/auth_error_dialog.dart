import 'package:flutter/material.dart';
import 'package:rx_dart_phonebook/blocs/auth_bloc/auth_error.dart';
import 'package:rx_dart_phonebook/dialogs/generic_dialog.dart';

Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) {
  return showGenericDialog(
    context: context,
    title: authError.dialogTitle,
    content: authError.dialogText,
    optionsBuilder: () => {
      'OK': true,
    },
  );
}
