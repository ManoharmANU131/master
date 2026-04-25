import 'package:my_contacts_app/data/database/db_helper.dart';
import 'package:my_contacts_app/models/contact.dart';

class ContactRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  static const String table = "contacts";

  Future<int> addContact(Contact contact) async {
    try {
      return await _dbHelper.insert(table, contact.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Contact>> getAllContacts() async {
    try {
      final result = await _dbHelper.database;

      final data = await result.query(table, orderBy: "CreatedOn DESC");

      return data.map((e) => Contact.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateContact(Contact contact) async {
    try {
      final result = await _dbHelper.update(table, contact.toMap(), "Id = ?", [
        contact.id,
      ]);
      return result > 0;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteContact(int id) async {
    try {
      final result = await _dbHelper.delete(table, "Id = ?", [id]);
      return result > 0;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> toggleFavourite(Contact contact) async {
    try {
      final updated = contact.copyWith(
        isFavourite: !contact.isFavourite,
        updatedOn: DateTime.now(),
      );
      return await updateContact(updated);
    } catch (e) {
      rethrow;
    }
  }

  Future<Contact?> getContactById(int id) async {
    try {
      final db = await _dbHelper.database;

      final result = await db.query(
        table,
        where: "Id = ?",
        whereArgs: [id],
        limit: 1,
      );
      if (result.isEmpty) return null;
      return Contact.fromMap(result.first);
    } catch (e) {
      rethrow;
    }
  }
}
