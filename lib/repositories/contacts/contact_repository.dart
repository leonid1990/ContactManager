import '../../models/contact.dart';
import 'contact_api_interface.dart';

class ContactRepository {
  final IContactAPI _api;

  ContactRepository(this._api);

  Future<Contact?> getContactByUsername(String username) {
    return _api.getContactByUsername(username);
  }
}
