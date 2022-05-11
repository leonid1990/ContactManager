import 'package:contact_manager_app/repositories/contacts/contact_repository.dart';

import '../models/contact.dart';
import '../repositories/contacts/contact_api_implementation.dart';
import '../repositories/contacts/contact_api_stub.dart';

class ContactsController {
  final ContactRepository _contactRepository = ContactRepository(ContactAPI());

  List<String> contactNames = ['moshe'];

  /* Future<List<Future<Contact?>>> getAllContacts() async {
    List<String>? contactNames = await getContactNames();
    if (contactNames == null) {
      return [];
    } else {
      var result = contactNames
          .map((cn) async => await _contactRepository.getContactByUsername(cn))
          .toList();

      return result;
    }
  } */

  Future<Contact?> getContactByUsername(String username) {
    return _contactRepository.getContactByUsername(username);
  }

  Future<List<String>> getContactNames() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return contactNames;
  }

  addContactName(String username) {
    contactNames.add(username);
  }

  removeContactName(String username) {
    contactNames.removeWhere((un) => un == username);
  }
}
