import 'package:flutter/material.dart';

import '../controllers/contacts_controller.dart';
import '../models/contact.dart';

class ContactDetails extends StatelessWidget {
  final String _contactName;
  final ContactsController _contactsController;

  const ContactDetails(this._contactName, this._contactsController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$_contactName's details"),
        ),
        body: FutureBuilder<Contact?>(
            future: _contactsController.getContactByUsername(_contactName),
            builder: (context, snapshot) =>
                (snapshot.connectionState == ConnectionState.done)
                    ? _buildContactDetails(snapshot.data)
                    : const Center(child: CircularProgressIndicator())));
  }

  _buildContactDetails(Contact? contact) {
    if (contact == null) {
      return const Center(
          child: Text(
        'No details',
        style: TextStyle(fontSize: 30),
      ));
    }

    return ListView(
      children: [
        _buildListTile(contact.username, Icons.account_circle),
        _buildListTile(contact.phone, Icons.phone),
        _buildListTile(contact.email, Icons.email),
        _buildListTile(contact.country, Icons.my_location),
        _buildListTile(contact.city, Icons.location_city),
      ],
    );
  }

  _buildListTile(String text, IconData icon) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
      leading: Icon(icon),
    );
  }
}
