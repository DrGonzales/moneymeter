/// Dataclass hold a single money transaction

const String tableTransaction = 'transactions';

class TransactionFields {
  static const List<String> values = [
    'id',
    description,
    account,
    category,
    timestamp,
    amount
  ];
  static const String description = 'description';
  static const String account = 'account';
  static const String category = 'category';
  static const String timestamp = 'timestamp';
  static const String amount = 'amount';
  static const String id = '_id';
}

class Transaction {
  String description;
  String account;
  String category;
  DateTime timestamp;
  double amount;
  int? id;

  Transaction(
      {this.id,
      required this.description,
      required this.account,
      required this.category,
      required this.timestamp,
      required this.amount});

  Map<String, dynamic> toMap() {
    return {
      TransactionFields.id: id,
      TransactionFields.description: description,
      TransactionFields.account: account,
      TransactionFields.category: category,
      TransactionFields.timestamp: timestamp.toIso8601String(),
      TransactionFields.amount: amount
    };
  }

  @override
  String toString() {
    return 'Transaction({id: $id, description: $description, account: $account, category: $category, timestamp: $timestamp, amount: $amount}';
  }
}
