class Transaction {
  final String type;
  final String date;
  final String amount;
  final String vat;
  final String method;

  Transaction({
    required this.type,
    required this.date,
    required this.amount,
    required this.vat,
    required this.method,
  });
}
