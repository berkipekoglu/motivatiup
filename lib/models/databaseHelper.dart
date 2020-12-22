import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:motivatiup/data/api/motivatiupModels.dart';
import 'package:motivatiup/models/openingQuoteData.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  factory DatabaseHelper() {
    var databaseHelper = _databaseHelper;
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();

      print(
          '**** Daha önceden veritabanı dsoyası olmadığından yeni bir veritabanı dosyası oluşturuldu. ****');
      return _databaseHelper;
    } else {
      print('**** Var olan veritabanı dosyası geri döndürüldü. ****');
      return _databaseHelper;
    }
  }

  DatabaseHelper._internal();

  _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      print('**** Yeni bir veritabanı oluşturuldu. ****');
      return _database;
    } else {
      print('**** Var olan veritabanı işleme alındı. ****');
      return _database;
    }
  }

  Future<Database> _initializeDatabase() async {
    var lock = Lock();
    Database _db;

    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var databasesPath = await getDatabasesPath();
          var path = join(databasesPath, "motivatiup.db");
          print('Oluşacak Database dosyasının pathi: $path');
          var file = new File(path);

          // check if file exists
          if (!await file.exists()) {
            // Copy from asset
            ByteData data =
                await rootBundle.load(join("assets/data", "motivatiup.db"));
            List<int> bytes =
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }
          // open the database
          _db = await openDatabase(path, readOnly: false);
        }
      });
    }

    return _db;
  }

  getQuoteLength() async {
    Database db = await _getDatabase();
    var result = await db.query("motivatiup");
    print(result.length.toString());
    return result.length;
  }

  getRandomQuote(int randomNumber) async {
    Database db = await _getDatabase();
    var result = await db.query("motivatiup");
    return result[randomNumber];
  }

  int randomNumber;
  getOneRandomQuote() async {
    QuoteData quoteData;
    var r = Random();
    int newRandomNumber;
    int length = await getQuoteLength();
    if (randomNumber == null) {
      newRandomNumber = r.nextInt(length);
      randomNumber = newRandomNumber;
    }
    newRandomNumber = r.nextInt(length);
    while (newRandomNumber == randomNumber) {
      newRandomNumber = r.nextInt(length);
    }
    randomNumber = newRandomNumber;
    print('Random üretilen sayı: ' + randomNumber.toString());
    var item = await getRandomQuote(randomNumber);
    print("Models dan gelen kısım");
    print(item);
    /*
    quoteData = QuoteData(item['_id'], item['quoteWord'],
        item['quoteWordOwner'], item['quoteCategory'], item['isFavorited']);
    print("Main çalıştı ve çekilen veri:");
    quoteData.toMap().forEach((key, value) {
      print(key.toString() + " : " + value.toString());
    });
    */
    return item;
  }

  void getQuotes() async {
    Database db = await _getDatabase();
    var result = await db.query("motivatiup");

    print("başarılı");
    for (var item in result) {
      print(item);
    }
  }

  void insertQuote(Map<String, dynamic> quote) async {
    Database db = await _getDatabase();
    int result = await db.insert('motivatiup', quote);
    try {
      print("Veri, tabloya başarıyla eklendi.");
    } catch (x) {
      print("Bir hata oluştu.");
      print("Hata mesajı:");
      print(x.toString());
    }
  }

  Future<int> updateQuote(Map<String, dynamic> quote) async {
    Database db = await _getDatabase();
    int id = quote['_id'];
    print('gelen id: $id');
    int result =
        await db.update('motivatiup', quote, where: '_id = ?', whereArgs: [id]);
    print('Başarıyla güncellendi.');
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await _getDatabase();
    return await db.delete('motivatiup', where: '_id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> likedQuotes() async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> returnLikedQuotes =
        await db.query('motivatiup', where: 'isFavorited = 1');
    return returnLikedQuotes;
  }

  Future<int> idUpdate(int id) async {
    Database db = await _getDatabase();
    print('Favorilerden çıkarılan id: ' + id.toString());
    int result = await db
        .rawUpdate('UPDATE motivatiup SET isFavorited = 0 WHERE _id = $id');
    result == 1
        ? print('Başarıyla güncellendi.')
        : print('Güncellerken bir sorun oluştu.');
  }
}
