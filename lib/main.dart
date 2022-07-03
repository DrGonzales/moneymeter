import 'package:flutter/material.dart';
import 'package:moneymeter/database/db.dart';
import 'package:moneymeter/model/category.dart';
import 'package:moneymeter/model/moneytransaction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = DB.instance;

  List<Category> l = await db.readAllCatgorys();
  l.forEach(print);

  var mt = MoneyTransaction(description: "description", account: "account", category: "category", timestamp: DateTime.now(), amount: 550.22);
  var mt2 = MoneyTransaction(description: "description", account: "account", category: "category", timestamp: DateTime.now(), amount: 1550.22);
  mt2.id = 2;
  print(mt2);
  db.updateMoneyTransaction(mt2);

  db.deleteTransaction(3);


  //db.createTransaction(mt);

  List<MoneyTransaction> m = await db.readAllTransactions();
  m.forEach(print);


  runApp(const MoneyMeter());
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
