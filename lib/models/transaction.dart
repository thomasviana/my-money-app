class Tx {
  final String title;
  final String tag;
  final double amount;
  final DateTime date;
  final String id;
  final String type;

  Tx(
      {required this.title,
      required this.tag,
      required this.amount,
      required this.date,
      required this.id,
      required this.type});
}
