import 'package:flutter/material.dart';

import 'controllers/contacts_controller.dart';
import 'pages/contact_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ContactManager',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ContactManager'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final ContactsController _contactsController = ContactsController();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _refreshList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _Form(widget._contactsController, _refreshList),
        _ContactList(widget._contactsController, _refreshList),
      ],
    );
  }
}

class _Form extends StatefulWidget {
  final ContactsController _contactsController;
  final VoidCallback _refreshList;

  const _Form(this._contactsController, this._refreshList);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameFieldController =
      TextEditingController();

  @override
  void dispose() {
    _userNameFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _userNameFieldController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid name';
                }
                return null;
              },
            ),
            Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget._contactsController
                          .addContactName(_userNameFieldController.text);
                      _userNameFieldController.clear();
                      widget._refreshList();
                    }
                  },
                  child: const Text('Add Contact'),
                )),
          ],
        ),
      ),
    );
  }
}

class _ContactList extends StatelessWidget {
  final ContactsController _contactsController;
  final VoidCallback _refreshList;

  const _ContactList(this._contactsController, this._refreshList);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: _contactsController.getContactNames(),
        builder: (context, snapshot) =>
            (snapshot.connectionState == ConnectionState.done)
                ? _buildContacts(snapshot.data!)
                : const Center(child: CircularProgressIndicator()));
  }

  _buildContacts(List<String> contactNames) {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(25.0),
        itemCount: contactNames.length,
        itemBuilder: (context, index) {
          String contactName = contactNames[index];

          return Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ContactDetails(contactName, _contactsController),
                    ),
                  );
                },
                child: Text(
                  contactName,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await _contactsController.removeContactName(contactName);
                  _refreshList();
                },
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        });
  }
}
