import 'package:contatos/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final ContactModel? contact;

  ContactPage({this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late ContactModel _contact;
  String _titleAppBar = "Novo Contato";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contact = widget.contact ?? ContactModel(name: '');

    _nameController.text = _contact.name;
    _emailController.text = _contact.email ?? '';
    _phoneController.text = _contact.phone ?? '';

    _titleAppBar = _contact.name.isEmpty ? _titleAppBar : _contact.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_titleAppBar),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: contactImage(_contact.img ?? ''),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              TextFormField(
                controller: _nameController,
                onChanged: (txt) {
                  setState(() {
                    _titleAppBar = txt;
                  });
                },
                decoration: InputDecoration(labelText: "Nome"),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: "Telefone"),
              ),
            ],
          ),
        ),
      ),
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
