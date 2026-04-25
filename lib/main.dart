import 'package:flutter/cupertino.dart';
import 'package:my_contacts_app/app/my_contacts_app.dart';
import 'package:my_contacts_app/data/database/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database;
  runApp(const MyContactsApp());
}
