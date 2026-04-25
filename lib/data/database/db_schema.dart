import 'package:my_contacts_app/data/database/schema/contact_schema.dart';

class DbSchema {
  static List<String> schemas = [];
  static void initialize() {
    schemas.clear();
    ContactSchema.initialize();
  }
}
