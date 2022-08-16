import 'package:e_commerce_num2/models/cart_model.dart';
import 'package:sqflite/sqflite.dart';

class CartDbHelper {
  static late Database _db;
  static const String _tableName = "cartTable";

  static Future<void> open() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + '/cart.db';

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
          create table $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId TEXT,
            title TEXT,
            subTitle TEXT,
            color TEXT,
            size TEXT,
            image TEXT,
            price REAL,
            quantity INTEGER)
          ''',
        );
      },
    );
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db.query(_tableName);
  }

  static Future<CartModel> insert(CartModel cartModel) async {
    cartModel.id = await _db.insert(_tableName, cartModel.toMap());
    return cartModel;
  }

  static Future<void> update(CartModel cartModel) async {
    await _db.rawUpdate(
      "UPDATE $_tableName SET quantity = ? WHERE id = ?",
      [cartModel.quantity, cartModel.id],
    );
  }

  static Future<int> delete(CartModel cartModel) async {
    return await _db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [cartModel.id],
    );
  }

  static Future<int> deleteCartTable() async {
    return await _db.delete(_tableName);
  }
}
