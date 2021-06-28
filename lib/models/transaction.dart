class Transaction {
  final String title;
  final String tag;
  final double amount;
  final DateTime date;

  Transaction(
      {required this.title,
      required this.tag,
      required this.amount,
      required this.date});
}
