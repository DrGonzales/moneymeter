import 'package:moneymeter/database/db.dart';
import 'package:moneymeter/model/moneytransaction.dart';

class MoneyTransactionDao {
  Future<MoneyTransaction> create(MoneyTransaction data) async {
    final db = await DB.instance.database;
    final id = await db.insert(tableMoneyTransaction, data.toMap());
    return data.copy(id: id);
  }

  Future<MoneyTransaction> read(int id) async {
    final db = await DB.instance.database;
    final result = await db.query(tableMoneyTransaction,
        columns: MoneyTransactionFields.values,
        where: '${MoneyTransactionFields.id} = ?',
        whereArgs: [id]);
    if (result.isNotEmpty) {
      return MoneyTransaction.fromMap(result.first);
    } else {
      throw Exception('Datensatz mit ID $id nicht gefudnen');
    }
  }

  Future<List<MoneyTransaction>> readAll() async {
    final db = await DB.instance.database;
    final results = await db.query(tableMoneyTransaction,
        columns: MoneyTransactionFields.values);
    return results.map((result) => MoneyTransaction.fromMap(result)).toList();
  }

  Future<List<MoneyTransaction>> readMonthly(DateTime date) async {
    final db = await DB.instance.database;
    final results = await db.rawQuery(
        "SELECT *  from $tableMoneyTransaction where  strftime('%Y-%m-%d', timestamp) BETWEEN date('${date.toIso8601String()}','start of month') and date('${date.toIso8601String()}','start of month','+1 month','-1 day')");
    return results.map((result) => MoneyTransaction.fromMap(result)).toList();
  }

  Future<int> update(MoneyTransaction data) async {
    final db = await DB.instance.database;
    return db.update(tableMoneyTransaction, data.toMap(),
        where: '${MoneyTransactionFields.id} = ?', whereArgs: [data.id]);
  }

  Future<int> delete(int id) async {
    final db = await DB.instance.database;
    return db.delete(tableMoneyTransaction,
        where: '${MoneyTransactionFields.id} = ?', whereArgs: [id]);
  }
}
