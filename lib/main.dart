import 'package:flutter/material.dart';
import 'package:moneymeter/database/categorydao.dart';
import 'package:moneymeter/database/db.dart';
import 'package:moneymeter/database/moneytransactiondao.dart';
import 'package:moneymeter/model/category.dart';
import 'package:moneymeter/model/moneytransaction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = DB.instance;
  var moneytransactiondao = MoneyTransactionDao();
  var catdao = CategoryDao();

  List<Category> l = await catdao.readAllCatgorys();
  l.forEach(print);

  var mt = MoneyTransaction(description: "description2", account: "account", category: "category", timestamp:  DateTime.parse("2022-06-16T11:00:00.000Z"), amount: 550.22);
  var mt2 = MoneyTransaction(description: "description1", account: "account", category: "category", timestamp: DateTime.parse("2022-06-13T11:00:00.000Z"), amount: 1550.22);
  moneytransactiondao.create(mt);
  moneytransactiondao.create(mt2);

  //db.createTransaction(mt);

  List<MoneyTransaction> m = await moneytransactiondao.readMonthly( DateTime.parse("2022-06-16T11:00:00.000Z"));
  m.forEach(print);
// List<MoneyTransaction> f = await moneytransactiondao.readAll();
// f.forEach(print);
//   runApp(const MoneyMeter());
 }

class MoneyMeter extends StatelessWidget {
  const MoneyMeter({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold()
    );
  }
}
