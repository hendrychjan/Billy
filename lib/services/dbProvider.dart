import 'dart:io';

import 'package:billy/models/debt.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DebtDBProvider {
  DebtDBProvider._();
  static final DebtDBProvider db = DebtDBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "debts.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Debts ("
          "id INTEGER PRIMARY KEY,"
          "value INTEGER,"
          "title TEXT,"
          "detail TEXT,"
          "target TEXT,"
          "date_created TEXT"
          ")");
    });
  }

  getAllDebts() async {
    final db = await database;
    var res = await db.query("Debts");
    List<Debt> list =
        res.isNotEmpty ? res.map((e) => Debt.fromMap(e)).toList() : [];
    return list;
  }

  getDebt(int id) async {
    final db = await database;
    var res = await db.query("Debts", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Debt.fromMap(res.first) : Null;
  }

  Future<Debt> newDebt(Debt newDebt) async {
    try {
      final db = await database;

      // Get id for data
      var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Debts");
      int id = table.first["id"];
      Map<String, dynamic> data = newDebt.toMap();
      data.update("id", (value) => (id == null) ? 0 : id);

      // Save to db
      await db.insert("Debts", data);
      return Debt.fromMap(data);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteDebt(int id) async {
    try {
      final db = await database;
      var res = await db.delete("Debts", where: "id = ?", whereArgs: [id]);
      return true;
    } catch (e) {
      return false;
    }
  }
}
