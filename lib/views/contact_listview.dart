import 'package:flutter/material.dart';
import 'package:rx_dart_phonebook/dialogs/delete_account_dialog.dart';
import 'package:rx_dart_phonebook/models/contact.dart';
import 'package:rx_dart_phonebook/type_definitions.dart';
import 'package:rx_dart_phonebook/views/main_popup_menu_button.dart';

class ContactListView extends StatelessWidget {
  final LogOutCallBack logout;
  final DeleteAccountCallback deleteAccount;
  final DeleteContactCallBack deleteContact;
  final VoidCallback createNewContact;
  final Stream<Iterable<Contact>> contacts;

  const ContactListView({
    required this.logout,
    required this.deleteAccount,
    required this.deleteContact,
    required this.createNewContact,
    required this.contacts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Liên Hệ'),
        actions: [
          MainPopupMenuButton(
            logout: logout,
            deleteAccount: deleteAccount,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewContact,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: StreamBuilder<Iterable<Contact>>(
        stream: contacts,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              final contatcs = snapshot.requireData;
              return ListView.builder(
                itemCount: contatcs.length,
                itemBuilder: (context, index) {
                  final contact = contatcs.elementAt(index);
                  return ContactListTitle(
                    contact: contact,
                    deleteContact: deleteContact,
                  );
                },
              );
          }
        },
      ),
    );
  }
}

class ContactListTitle extends StatelessWidget {
  final Contact contact;
  final DeleteContactCallBack deleteContact;
  const ContactListTitle({
    required this.contact,
    required this.deleteContact,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.fullName),
      trailing: IconButton(
        onPressed: () async {
          final shouldDelete = await showDelereAccountDialog(context: context);
          if (shouldDelete) {
            deleteContact(contact);
          }
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
