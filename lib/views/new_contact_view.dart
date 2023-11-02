import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rx_dart_phonebook/helpers/if_debugging.dart';
import 'package:rx_dart_phonebook/type_definitions.dart';

class NewContactView extends HookWidget {
  final CreateContactCallBack createContact;
  final GoBackCallBack goBack;

  const NewContactView({
    required this.createContact,
    required this.goBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final firstNameContrller = useTextEditingController(
      text: 'Tan'.ifDebugging,
    );
    final lastNameContrller = useTextEditingController(
      text: 'Phuc'.ifDebugging,
    );
    final phoneNumberContrller = useTextEditingController(
      text: '+123456789'.ifDebugging,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo tài khoản mới!'),
        leading: IconButton(
          onPressed: goBack,
          icon: const Icon(Icons.close),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: firstNameContrller,
                decoration: const InputDecoration(hintText: 'Tên...'),
                keyboardType: TextInputType.name,
                keyboardAppearance: Brightness.dark,
              ),
              TextField(
                controller: lastNameContrller,
                decoration: const InputDecoration(hintText: 'Họ...'),
                keyboardType: TextInputType.name,
                keyboardAppearance: Brightness.dark,
              ),
              TextField(
                controller: phoneNumberContrller,
                decoration: const InputDecoration(hintText: 'Số điện thoại...'),
                keyboardType: TextInputType.phone,
                keyboardAppearance: Brightness.dark,
              ),
              TextButton(onPressed:() {
                final firstName=firstNameContrller.text;
                final lastName=lastNameContrller.text;
                final phoneNumber=phoneNumberContrller.text;
                createContact(firstName,lastName,phoneNumber,);
                goBack();
              }, child: const Text('Lưu Liên Hệ'),)
            ],
          ),
        ),
      ),
    );
  }
}
