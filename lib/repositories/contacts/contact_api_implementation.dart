import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../../models/contact.dart';
import 'contact_api_interface.dart';

class ContactAPI implements IContactAPI {
  @override
  Future<Contact?> getContactByUsername(String username) async {
    try {
      final response = await http
          .get(Uri.parse('https://localhost:3000/contacts/$username'))
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        return Contact.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      return null;
    } on SocketException catch (_) {
      return null;
    }

    /* var contactMap = await json
        .decode(await rootBundle.loadString('assets/data/contact.json'));

    return Contact.fromJson(contactMap); */
  }
}
