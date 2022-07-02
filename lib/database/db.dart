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

    ///default values
    <Category>[
      Category(description: "Bargeld", type: "Account"),
      Category(description: "Kreditkarte", type: "Account"),
      Category(description: "Paypal", type: "Account"),
      Category(description: "Lebensmittel", type: "Category"),
      Category(description: "Hobby", type: "Category"),
      Category(description: "Mobilität", type: "Category"),
      Category(description: "Gesundheit", type: "Category"),
      Category(description: "Kultur", type: "Category"),
      Category(description: "Bildung", type: "Category"),
      Category(description: "Kleidung", type: "Category")
    ].forEach(createCategory);
  }

  Future<MoneyTransaction> createTransaction(MoneyTransaction data) async {
    final db = await instance.database;
    final id = await db.insert(tableMoneyTransaction, data.toMap());
    return data.copy(id: id);
  }

  Future<Category> createCategory(Category data) async {
    final db = await instance.database;
    final id = await db.insert(tableCategory, data.toMap());
    return data.copy(id: id);
  }

  Future<MoneyTransaction> readTransaction(int id) async {
    final db = await instance.database;
    final result = await db.query(tableMoneyTransaction,
        columns: MoneyTransactionFields.values,
        where: '$MoneyTransactionFields.id = ?',
        whereArgs: [id]);
    if (result.isNotEmpty) {
      return MoneyTransaction.fromMap(result.first);
    } else {
      throw Exception('Datensatz mit ID $id nicht gefudnen');
    }
  }

  Future<Category> readCatgory(int id) async {
    final db = await instance.database;
    final result = await db.query(tableCategory,
        columns: CategoryFields.values,
        where: '$CategoryFields.id = ?',
        whereArgs: [id]);
    if (result.isNotEmpty) {
      return Category.fromMap(result.first);
    } else {
      throw Exception('Datensatz mit ID $id nicht gefudnen');
    }
  }

  Future<List<Category>> readAllCatgorys() async {
    final db = await instance.database;
    final results =
        await db.query(tableCategory, columns: CategoryFields.values);
    return results.map((result) => Category.fromMap(result)).toList();
  }

  Future<int> updateCategory(Category data) async {
    final db = await instance.database;
    return db.update(tableCategory, data.toMap(),
        where: '$CategoryFields.id = ?', whereArgs: [data.id]);
  }

  Future<int> updateMoneyTransaction(MoneyTransaction data) async {
    final db = await instance.database;
    return db.update(tableMoneyTransaction, data.toMap(),
        where: '$MoneyTransactionFields.id = ?', whereArgs: [data.id]);
  }

  Future<int> deleteCategory(int id) async {
    final db = await instance.database;
    return db.delete(tableCategory,
        where: '$CategoryFields.id = ?', whereArgs: [id]);
  }

  Future<int> deleteTransaction(int id) async {
    final db = await instance.database;
    return db.delete(tableMoneyTransaction,
        where: '$MoneyTransactionFields.id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
