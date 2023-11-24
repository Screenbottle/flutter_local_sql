import 'package:flutter_local_sql/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbService {
  static const messageTableName = 'message';
  late Database db;

  DbService() {
    openDb();
  }

  void putMessagesInDb(Message message) async {
    int id = await db.insert(messageTableName, message.toMap());
    print('id $id inserted in db');
  }

  Future<List<Message>> getAllMessagesFromDb() async {
    List<Map<String, Object?>> dbResponse = await db.query(messageTableName);
    return dbResponse.map((record) => Message.fromMap(record)).toList();
  }

  void openDb() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'message.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $messageTableName (id STRING PRIMARY KEY, title TEXT, text TEXT )");
  }
}