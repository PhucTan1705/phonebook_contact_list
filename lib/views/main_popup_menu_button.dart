import 'package:flutter/material.dart';
import 'package:rx_dart_phonebook/dialogs/delete_account_dialog.dart';
import 'package:rx_dart_phonebook/dialogs/log_out_dialog.dart';
import 'package:rx_dart_phonebook/type_definitions.dart';

enum MenuAction { logout, deleteAccount }

class MainPopupMenuButton extends StatelessWidget {
  final LogOutCallBack logout;
  final DeleteAccountCallback deleteAccount;

  const MainPopupMenuButton({
    required this.logout,
    required this.deleteAccount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      onSelected: (value) async {
        switch(value) {
          case MenuAction.logout:
            final shouldLogOut = await showLogOutDialog(context);
            if(shouldLogOut){
              logout();
            }
            break;
          case MenuAction.deleteAccount:
            final shouldDeleteAccount = await showDelereAccountDialog(context: context);
            if (shouldDeleteAccount){
              deleteAccount();
            }
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<MenuAction>(
            value: MenuAction.logout,
            child: Text('Đăng xuất'),
          ),
          const PopupMenuItem<MenuAction>(
            value: MenuAction.deleteAccount,
            child: Text('Xóa tài khoản'),
          ),
        ];
      },
    );
  }
}
