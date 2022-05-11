import '../../models/contact.dart';

abstract class IContactAPI {
  Future<Contact?> getContactByUsername(String username);
}
