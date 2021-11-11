import 'package:eyubank/models/bank_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

final String tableBank = 'bank';
final String columnId = 'id';
final String columnName = 'fullName';
final String columnMobile = 'mobile';
final String columnEmail = 'email';
final String columnAccountNum = 'accountNum';
final String columnIcode = 'ifsc';
final String columnBalance = 'balance';

class BankHelper {
  static Database _database;
  static BankHelper _bankHelper;

  BankHelper._createInstance();
  factory BankHelper() {
    if (_bankHelper == null) {
      _bankHelper = BankHelper._createInstance();
    }
    return _bankHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    String dir = await getDatabasesPath();
    String path = join(dir, "bank.db");

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          create table $tableBank ( 
          $columnId integer primary key autoincrement, 
          $columnName text not null,
          $columnMobile integer not null,
          $columnEmail text,
          $columnAccountNum integer not null,
          $columnIcode integer not null,
          $columnBalance integer not null)
        ''');
      },
    );
    return database;
  }

  Future<int> insertBank(BankInfo alarmInfo) async {
    var db = await this.database;
    var result = await db.insert(tableBank, alarmInfo.toMap());
    print('result : $result');
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableBank, where: '$columnId = ?', whereArgs: [id.toString()]);
  }

  Future<List<BankInfo>> getBank() async {
    List<BankInfo> bankList = [];

    var db = await this.database;
    var result = await db.query(tableBank);
    result.forEach((element) {
      var bankInfo = BankInfo.fromMap(element);
      bankList.add(bankInfo);
    });

    return bankList;
  }

  Future<int> updatebank(BankInfo bankInfo) async {
    var db = await this.database;
    var result = await db.update(tableBank, bankInfo.toMap(), where: '$columnId = ?', whereArgs: [bankInfo.id]);
    print('result : $result');
  }

}