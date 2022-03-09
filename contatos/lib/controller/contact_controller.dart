import 'dart:convert';

import 'package:contatos/models/contact_model.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactController {
  static final ContactController _instance = ContactController.internal();

  factory ContactController() => _instance;

  ContactController.internal();

  Database? _db;

  get db async {
    _db ??= await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String path = await getDatabasesPath();
    String databasepath = join(path, "contact.db");
    return await openDatabase(databasepath, version: 1, onCreate: (db, newerVersion) async {
      await db.execute("""CREATE TABLE ${ContactTable.nameTable}(
        ${ContactTable.fieldId} INTEGER PRIMARY KEY,
        ${ContactTable.fieldName} STRING,
        ${ContactTable.fieldEmail} STRING,
        ${ContactTable.fieldPhone} STRING,
        ${ContactTable.fieldImg} STRING
        )""");
    });
  }

  Future<ContactModel> saveContact(ContactModel contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(ContactTable.nameTable, contact.toMap());
    return contact;
  }

  Future<ContactModel?> getContactFromId(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(
      ContactTable.nameTable,
      columns: ContactTable.columns,
      where: "id=?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ContactModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<ContactModel>> getFullContacts() async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(
      ContactTable.nameTable,
      columns: ContactTable.columns,
    );
    if (maps.isNotEmpty) {
      return maps.map((e) => ContactModel.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  Future<int> insertContactsTest() async {
    String jsonStr = await rootBundle.loadString('lib/assets/contacts_test.json');
    List jsonDecoded = jsonDecode(jsonStr);
    return jsonDecoded
        .map((e) async {
          ContactModel contact = ContactModel.fromMap(e);
          contact = await saveContact(contact);
        })
        .toList()
        .length;
    // return jsonDecoded.length;
  }
}
