import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:moneymeter/model/transaction.dart';

class TransactionsDatabase {
  static final TransactionsDatabase instance = TransactionsDatabase._init();

  static Database? _database;

  TransactionsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('moneymaker.db');
    return _database!;
  }

  Future<Database> _initDB(String db) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, db);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE $tableTransaction (
 ${TransactionFields.id} $idType,
 ${TransactionFields.account} $textType,
 ${TransactionFields.category} $textType,
 ${TransactionFields.description} $textType,
 ${TransactionFields.timestamp} $textType,
 ${TransactionFields.amount} $realType
)
''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
