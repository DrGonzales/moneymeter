class Transaction {
  String description;
  String account;
  String category;
  DateTime timestamp;
  double amount;

  Transaction(this.description, this.account, this.category, this.timestamp,
      this.amount);
}
