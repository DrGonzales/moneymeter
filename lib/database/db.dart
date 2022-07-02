import 'package:moneymeter/model/category.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:moneymeter/model/moneytransaction.dart';

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

    /// Create Table for Transactions
    await db.execute('''
CREATE TABLE $tableMoneyTransaction (
 ${MoneyTransactionFields.id} $idType,
 ${MoneyTransactionFields.account} $textType,
 ${MoneyTransactionFields.category} $textType,
 ${MoneyTransactionFields.description} $textType,
 ${MoneyTransactionFields.timestamp} $textType,
 ${MoneyTransactionFields.amount} $realType
)
''');

    ///Create Table for Categories and accounts
    await db.execute('''
CREATE TABLE $tableCategory (
 ${CategoryFields.id} $idType,
 ${CategoryFields.description} $textType,
 ${CategoryFields.type} $textType
)
''');
  }

  Future<MoneyTransaction> createTransaction<T>(MoneyTransaction data) async {
    final db = await instance.database;
    final id = await db.insert(tableMoneyTransaction, data.toMap());
    return data.copy(id: id);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
