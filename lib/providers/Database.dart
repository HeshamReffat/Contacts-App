import 'package:sqflite/sqflite.dart';

class DataBase {
  Future<Database> createDatabase() async {
    return await openDatabase('UserData.db',
        version: 1,
        onCreate: (db, _) async {
          await db.execute(
              'CREATE TABLE contacts(id INTEGER PRIMARY KEY, image TEXT, name TEXT, number1 INTEGER, number2 INTEGER, address TEXT)');
          print('created');
        },
        onOpen: (db) => print('opened'));
  }

  Future<void> insertData({
    Database database,
    String image,
    String name,
    int number1,
    int number2,
    String address,
  }) async {
    await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO contacts (image, name, number1, number2, address) values("$image" , "$name" , $number1 , $number2 , "$address")')
          .then((value) => print(value));
    });
  }

  Future<List<Map>> getData(Database database) async {
    return await database.rawQuery('SELECT * FROM contacts');
  }
  Future<List<Map>> searchContact(Database database, String name) async {
    return await database.rawQuery('SELECT * FROM contacts WHERE name Like "$name%"');
  }
  Future<int> updateContact({
    Database database,
    String image,
    String name,
    int number1,
    int number2,
    String address,
    int id,
  }) async {
    return await database.rawUpdate(
        'UPDATE contacts SET image = ?, name = ?, number1 = ?, number2 = ?, address = ? WHERE id = "$id"',
        ['$image', '$name', number1, number2, '$address']);
  }

  Future<int> deleteContact({Database database, String name}) async {
    return await database
        .rawDelete('DELETE FROM contacts WHERE name = ?', ['$name']);
  }
}
