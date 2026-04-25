import 'package:my_contacts_app/data/database/db_schema.dart';

class ContactSchema {
  static void initialize() {
    DbSchema.schemas.add('''
      CREATE TABLE IF NOT EXISTS contacts (
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        Name TEXT NOT NULL,
        Phone TEXT NOT NULL,
        Email TEXT,
        Company TEXT,
        Notes TEXT,
        IsFavourite INTEGER DEFAULT 0,
        CreatedOn TEXT,
        UpdatedOn TEXT
      )
    ''');
  }
}
