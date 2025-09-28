import 'dart:convert';

import 'package:expense_app/data/expense_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseController extends GetxController{

  RxList<ExpenseModel> expenses = <ExpenseModel>[].obs;
  RxDouble todayTotal = 0.0.obs;
  RxDouble weekTotal = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(expenses, (_) => _calculateTotals());
    loadExpenses();
  }

  void loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? expensesString = prefs.getString('expenses');
    if (expensesString != null) {
      List decodedList = jsonDecode(expensesString);
      expenses.value = decodedList.map((e) => ExpenseModel.fromJson(e)).toList();
    }
  }

  void addExpense(ExpenseModel expense) async {
    expenses.add(expense);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List jsonList = expenses.map((e) => e.toJson()).toList();
    await prefs.setString('expenses', jsonEncode(jsonList));

  }

  void _calculateTotals({DateTime? selectedDate}) {
    DateTime endDate = selectedDate ?? DateTime.now();
    String endDateStr = endDate.toIso8601String().substring(0, 10);

    // Today total (for selected date)
    todayTotal.value = expenses
        .where((e) => e.date == endDateStr)
        .fold(0, (sum, e) => sum + e.amount);

    // Week total (7 days ending on selected date)
    DateTime weekStart = endDate.subtract(const Duration(days: 6)); // 7-day range

    weekTotal.value = expenses.where((e) {
      DateTime expenseDate = DateTime.parse(e.date);
      return !expenseDate.isBefore(weekStart) && !expenseDate.isAfter(endDate);
    }).fold(0, (sum, e) => sum + e.amount);
  }

}