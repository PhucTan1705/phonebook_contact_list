import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rx_dart_phonebook/models/contact.dart';

typedef _Snapshots = QuerySnapshot<Map<String, dynamic>>;
typedef _Document = DocumentReference<Map<String, dynamic>>;

extension Unwrap<T> on Stream<T?> {
  Stream<T> unwrap() => switchMap(
        (optional) async* {
          if (optional != null) {
            yield optional;
          }
        },
      );
}

@immutable
class ContactsBloc {
  final Sink<String?> userId;
  final Sink<Contact> createContact;
  final Sink<Contact> deleteContact;
  final Sink<void> deleteAllContacts;
  final Stream<Iterable<Contact>> contacts;
  final StreamSubscription<void> _createContactSubscription;
  final StreamSubscription<void> _deleteContactSubscription;
  final StreamSubscription<void> _deleteAllContactSubscription;

  void dispose() {
    userId.close();
    createContact.close();
    deleteContact.close();
    deleteAllContacts.close();
    _createContactSubscription.cancel();
    _deleteContactSubscription.cancel();
    _deleteAllContactSubscription.cancel();
  }

  const ContactsBloc._({
    required this.userId,
    required this.createContact,
    required this.deleteContact,
    required this.deleteAllContacts,
    required this.contacts,
    required StreamSubscription<void> createContactSubscription,
    required StreamSubscription<void> deleteContactSubscription,
    required StreamSubscription<void> deleteAllContactSubscription,
  })  : _createContactSubscription = createContactSubscription,
        _deleteContactSubscription = deleteContactSubscription,
        _deleteAllContactSubscription = deleteAllContactSubscription;

  factory ContactsBloc() {
    final backend = FirebaseFirestore.instance;

    //user id
    final userId = BehaviorSubject<String?>();

    //neu user id thay doi, thi thu hoi lien he

    final Stream<Iterable<Contact>> contacts = userId.switchMap<_Snapshots>(
      (userId) {
        if (userId == null) {
          return const Stream<_Snapshots>.empty();
        } else {
          return backend.collection(userId).snapshots();
        }
      },
    ).map<Iterable<Contact>>((snapshots) sync* {
      for (final doc in snapshots.docs) {
        yield Contact.fromJson(
          doc.data(),
          id: doc.id,
        );
      }
    });

    // tao lien he
    final createContact = BehaviorSubject<Contact>();

    final StreamSubscription<void> createContactSubscription = createContact
        .switchMap(
            (Contact contactToCreate) => userId.take(1).unwrap().asyncMap(
                  (userId) => backend.collection(userId).add(
                        contactToCreate.data,
                      ),
                ))
        .listen((event) {});

    // xoa lien he
    final deleteContact = BehaviorSubject<Contact>();

    final StreamSubscription<void> deleteContactSubscription = deleteContact
        .switchMap(
            (Contact contactToDelete) => userId.take(1).unwrap().asyncMap(
                  (userId) => backend
                      .collection(userId)
                      .doc(
                        contactToDelete.id,
                      )
                      .delete(),
                ))
        .listen((event) {});

    //xoa moi lien he
    final deleteAllContacts = BehaviorSubject<void>();

    final StreamSubscription<void> deleteAllContactSubscription =
        deleteAllContacts
            .switchMap((_) => userId
                .take(1)
                .unwrap()
                .asyncMap(
                  (userId) => backend.collection(userId).get(),
                )
                .switchMap((collection) => Stream.fromFutures(
                    collection.docs.map((doc) => doc.reference.delete()))))
            .listen((_) {});
    //tao bloc lien he
    return ContactsBloc._(
      userId: userId,
      createContact: createContact,
      deleteContact: deleteContact,
      deleteAllContacts: deleteAllContacts,
      contacts: contacts,
      createContactSubscription: createContactSubscription,
      deleteContactSubscription: deleteContactSubscription,
      deleteAllContactSubscription: deleteAllContactSubscription,
    );
  }
}
