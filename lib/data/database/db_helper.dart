import 'dart:developer' as developer;

import 'package:my_contacts_app/data/database/db_schema.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      final path = join(await getDatabasesPath(), 'contacts.db');
      developer.log("Initializing database at: $path", name: "DB-INIT");
      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        onOpen: (db) {
          developer.log("Database opened successfully", name: "DB-OPEN");
        },
      );
    } catch (e, stack) {
      developer.log(
        "Failed to initialize database",
        name: "DB-INIT-ERROR",
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      developer.log("Creating database (first time setup)", name: "DB-CREATE");
      DbSchema.initialize();
      for (final schema in DbSchema.schemas) {
        developer.log("Executing schema:\n$schema", name: "DB-SCHEMA");
        await db.execute(schema);
      }
      developer.log("All tables created successfully", name: "DB-CREATE");
    } catch (e, stack) {
      developer.log(
        "Error while creating database",
        name: "DB-ERROR",
        error: e,
        stackTrace: stack,
      );
    }
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    try {
      final db = await database;
      developer.log("INSERT into $table | $values", name: "DB-INSERT");
      return await db.insert(table, values);
    } catch (e, stack) {
      developer.log(
        "INSERT failed in $table",
        name: "DB-INSERT-ERROR",
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    try {
      final db = await database;
      developer.log("FETCH ALL from $table", name: "DB-QUERY");
      return await db.query(table, orderBy: 'Id DESC');
    } catch (e, stack) {
      developer.log(
        "QUERY failed in $table",
        name: "DB-QUERY-ERROR",
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  Future<int> update(
    String table,
    Map<String, dynamic> values,
    String where,
    List<dynamic> whereArgs,
  ) async {
    try {
      final db = await database;
      developer.log(
        " UPDATE $table | $values | where: $where",
        name: "DB-UPDATE",
      );
      return await db.update(table, values, where: where, whereArgs: whereArgs);
    } catch (e, stack) {
      developer.log(
        " UPDATE failed in $table",
        name: "DB-UPDATE-ERROR",
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  Future<int> delete(
    String table,
    String where,
    List<dynamic> whereArgs,
  ) async {
    try {
      final db = await database;

      developer.log("DELETE from $table | where: $where", name: "DB-DELETE");

      return await db.delete(table, where: where, whereArgs: whereArgs);
    } catch (e, stack) {
      developer.log(
        "DELETE failed in $table",
        name: "DB-DELETE-ERROR",
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }
}
