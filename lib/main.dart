import 'package:flutter/material.dart';
import 'package:moneymeter/database/categorydao.dart';
import 'package:moneymeter/database/db.dart';
import 'package:moneymeter/database/moneytransactiondao.dart';
import 'package:moneymeter/model/category.dart';
import 'package:moneymeter/model/moneytransaction.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      home: Slidable(
  // Specify a key if the Slidable is dismissible.
  key: const ValueKey(0),

  // The start action pane is the one at the left or the top side.
  startActionPane: ActionPane(
    // A motion is a widget used to control how the pane animates.
    motion: const ScrollMotion(),

    // A pane can dismiss the Slidable.
    dismissible: DismissiblePane(onDismissed: () {}),

    // All actions are defined in the children parameter.
    children: const [
      // A SlidableAction can have an icon and/or a label.
      SlidableAction(
        onPressed: doNothing,
        backgroundColor: Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: 'Delete',
      ),
      SlidableAction(
        onPressed: doNothing,
        backgroundColor: Color(0xFF21B7CA),
        foregroundColor: Colors.white,
        icon: Icons.share,
        label: 'Share',
      ),
    ],
  ),

  // The end action pane is the one at the right or the bottom side.
  endActionPane: const ActionPane(
    motion: ScrollMotion(),
    children: [
      SlidableAction(
        // An action can be bigger than the others.
        flex: 2,
        onPressed: doNothing,
        backgroundColor: Color(0xFF7BC043),
        foregroundColor: Colors.white,
        icon: Icons.archive,
        label: 'Archive',
      ),
      SlidableAction(
        onPressed: doNothing,
        backgroundColor: Color(0xFF0392CF),
        foregroundColor: Colors.white,
        icon: Icons.save,
        label: 'Save',
      ),
    ],
  ),

  // The child of the Slidable is what the user sees when the
  // component is not dragged.
  child: const ListTile(title: Text('Slide me')),
),,
      
      
    );
  }
}
