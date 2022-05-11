import '../../models/contact.dart';
import 'contact_api_interface.dart';

class ContactAPIStub implements IContactAPI {
  @override
  Future<Contact?> getContactByUsername(String username) async {
    await Future.delayed(const Duration(milliseconds: 800));

    List<Contact?> list = [
      {
        'username': 'contact1',
        'phone': '111',
      },
      {
        'username': 'contact2',
        'phone': '222',
      },
      {
        'username': 'contact3',
        'phone': '333',
      },
      {
        'username': 'moshe',
        'phone': '0546897879',
      },
      {
        'username': 'contact4',
        'phone': '444',
      }
    ].map((c) => Contact.fromMap(c)).toList();

    Contact? result;
    try {
      result = list.firstWhere((contact) => contact!.username == username);
    } catch (e) {
      result = null;
    }

    return result;
  }
}
