class ExpenseModel {
  final double amount;
  final String category;
  final String date;

  ExpenseModel({required this.amount, required this.category, required this.date});

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'category': category,
    'date': date,
  };

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      amount: json['amount'],
      category: json['category'],
      date: json['date'],
    );
  }
}