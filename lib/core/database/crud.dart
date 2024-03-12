import 'package:note_app_bloc/core/database/sqlflite_services.dart';
import 'package:sqflite/sqflite.dart';

class Crud {
  SqlDb sqlDb = SqlDb();

  readData(String sql) async {
    Database? db = await sqlDb.db;
    List<Map<String, Object?>> responce = await db!.rawQuery(sql);
    return responce;
  }

  updateData(String sql) async {
    Database? db = await sqlDb.db;
    int responce = await db!.rawUpdate(sql);
    return responce;
  }

  deleteData(String sql) async {
    Database? db = await sqlDb.db;
    int responce = await db!.rawDelete(sql);
    return responce;
  }

  insertData(String sql) async {
    Database? db = await sqlDb.db;
    int responce = await db!.rawInsert(sql);
    return responce;
  }
}
