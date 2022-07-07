import 'package:moneymeter/database/db.dart';
import 'package:moneymeter/model/category.dart';

class CategoryDao {
  Future<Category> createCategory(Category data) async {
    final db = await DB.instance.database;
    final id = await db.insert(tableCategory, data.toMap());
    return data.copy(id: id);
  }

  Future<Category> readCatgory(int id) async {
    final db = await DB.instance.database;
    final result = await db.query(tableCategory,
        columns: CategoryFields.values,
        where: '${CategoryFields.id} = ?',
        whereArgs: [id]);
    if (result.isNotEmpty) {
      return Category.fromMap(result.first);
    } else {
      throw Exception('Datensatz mit ID $id nicht gefudnen');
    }
  }

  Future<List<Category>> readAllCatgorys() async {
    final db = await DB.instance.database;
    final results =
        await db.query(tableCategory, columns: CategoryFields.values);
    return results.map((result) => Category.fromMap(result)).toList();
  }

  Future<int> updateCategory(Category data) async {
    final db = await DB.instance.database;
    return db.update(tableCategory, data.toMap(),
        where: '${CategoryFields.id} = ?', whereArgs: [data.id]);
  }

  Future<int> deleteCategory(int id) async {
    final db = await DB.instance.database;
    return db.delete(tableCategory,
        where: '${CategoryFields.id} = ?', whereArgs: [id]);
  }
}
