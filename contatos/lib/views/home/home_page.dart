import 'package:contatos/models/contact_model.dart';
import 'package:contatos/views/contact_page.dart';
import 'package:flutter/material.dart';

import 'list_contact_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  static void showContactPage(BuildContext context, {ContactModel? contact}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactPage(
          contact: contact,
        ),
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contatos"),
      ),
      body: const ListContacts(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          HomePage.showContactPage(context);
        },
      ),
    );
  }
}
