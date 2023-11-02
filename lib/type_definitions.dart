import 'package:flutter/material.dart';
import 'package:rx_dart_phonebook/models/contact.dart';

typedef LogOutCallBack = VoidCallback;
typedef DeleteAccountCallback = VoidCallback;
typedef GoBackCallBack = VoidCallback;

typedef LoginFunction = void Function(
  String email,
  String password,
);

typedef RegisterFunction = void Function(
  String email,
  String password,
);

typedef CreateContactCallBack = void Function(
  String firstName,
  String lastName,
  String phoneNumber,
);

typedef DeleteContactCallBack = void Function(
  Contact contact,
);
