import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../Models/product_model.dart';
import 'Screens/product_screen.dart';

final sqflightProvider = Provider(
  (ref) => SqFlightController(),
);

class SqFlightController {
  late Database database;
  void createDatabase() async {
    // Get a location using getDatabasesPath
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'demo.db');
    openAppDb(path: path);
  }

  void deleteDatabases() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'demo.db');
    // deleteDatabases(path);
    deleteDatabase(path);
  }

  void openAppDb({required String path}) async {
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Test (sid INTEGER PRIMARY KEY, id INTEGER, title TEXT, description TEXT, price INTEGER, cart INTEGER, image TEXT, category TEXT)');
    }, onOpen: (Database db) {
      database = db;
      getAllData();
      print("Database is opened");
    });
  }

  // List<Product> testData = [];

  Future<void> getAllData() async {
    addCart = [];
    var daa = await database.query("Test");
    for (var i in daa) {
      addCart.add(Product.fromMap(i));
      // print(i.toString());
    }
    print(daa);
    // update(); //here update is used because 'query' is a getX method.thatsWhy...!!!
  }

  void insertData({required Product product}) async {
    var data = await database.insert("Test", {
      'id': product.id,
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'cart': product.cart!,
      'image': product.image,
      'category': product.category
    });
    debugPrint("$data");
  }

  void updateData({required Product product}) async {
    var updateData = await database.update(
        "Test",
        {
          'id': product.id,
          'title': product.title,
          "description": product.description,
          'price': product.price,
          'cart': product.cart,
          'image': product.image,
          'category': product.category
        },
        where: 'id = ${product.id}');
    print("updated Data");
    getAllData();
    debugPrint(updateData.toString());
  }

  void deleteData({required int id}) {
    database.delete("Test", where: "id = $id");
  }
}
