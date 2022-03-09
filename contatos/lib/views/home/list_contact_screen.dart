import 'package:contatos/controller/contact_controller.dart';
import 'package:contatos/models/contact_model.dart';
import 'package:contatos/views/home/home_page.dart';
import 'package:flutter/material.dart';

class ListContacts extends StatefulWidget {
  const ListContacts({Key? key}) : super(key: key);

  @override
  State<ListContacts> createState() => _ListContactsState();
}

class _ListContactsState extends State<ListContacts> {
  List<ContactModel> contacts = [];

  @override
  void initState() {
    super.initState();
    getContacts().then((value) {
      setState(() {
        contacts = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: contacts.length,
      itemBuilder: (BuildContext context, int index) {
        return _cardContact(context, contacts[index]);
      },
    );
  }

  Future<List<ContactModel>> getContacts() async {
    ContactController contact = ContactController();
    return await contact.getFullContacts();
  }

  Widget _cardContact(BuildContext context, ContactModel contact) {
    return GestureDetector(
      onTap: () {
        HomePage.showContactPage(context, contact: contact);
      },
      child: Card(
          child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: contactImage(contact.img ?? ''),
              ),
              shape: BoxShape.circle,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                contact.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(contact.email ?? ''),
              Text(contact.phone ?? ''),
            ],
          )
        ],
      )),
    );
  }

  ImageProvider<Object> contactImage(String img) {
    if (img.isNotEmpty) {
      return NetworkImage(img, scale: 0.5);
    } else {
      return const AssetImage('lib/assets/images/contact_default.png');
    }
  }
}
