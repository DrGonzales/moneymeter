/// Dataclass hold a single money transaction

const String tableMoneyTransaction = 'moneytransactions';

class MoneyTransactionFields {
  static const List<String> values = [
    id,
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
  static const String id = 'id';
}

class MoneyTransaction {
  String description;
  String account;
  String category;
  DateTime timestamp;
  double amount;
  int? id;

  MoneyTransaction(
      {this.id,
      required this.description,
      required this.account,
      required this.category,
      required this.timestamp,
      required this.amount});

  Map<String, dynamic> toMap() {
    return {
      MoneyTransactionFields.id: id,
      MoneyTransactionFields.description: description,
      MoneyTransactionFields.account: account,
      MoneyTransactionFields.category: category,
      MoneyTransactionFields.timestamp: timestamp.toIso8601String(),
      MoneyTransactionFields.amount: amount
    };
  }

  MoneyTransaction copy(
          {int? id,
          String? description,
          String? account,
          String? category,
          DateTime? timestamp,
          double? amount}) =>
      MoneyTransaction(
          id: id ?? this.id,
          description: description ?? this.description,
          account: account ?? this.account,
          category: category ?? this.category,
          timestamp: timestamp ?? this.timestamp,
          amount: amount ?? this.amount);

  static MoneyTransaction fromMap(Map<String, Object?> map) => MoneyTransaction(
      id: map[MoneyTransactionFields.id] as int?,
      description: map[MoneyTransactionFields.description] as String,
      account: map[MoneyTransactionFields.account] as String,
      category: map[MoneyTransactionFields.category] as String,
      timestamp: DateTime.parse(map[MoneyTransactionFields.timestamp] as String),
      amount: map[MoneyTransactionFields.amount] as double);

  @override
  String toString() {
    return 'MoneyTransaction({id: $id, description: $description, account: $account, category: $category, timestamp: $timestamp, amount: $amount}';
  }
}
