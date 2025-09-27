import 'package:expense_app/routes/routes.dart';
import 'package:expense_app/screens/add_expense_screen.dart';
import 'package:expense_app/screens/expense_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/spalsh_screen.dart';

class RoutesGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    Widget widgetScreen;

    final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        widgetScreen = const SplashScreen();
        break;

      case Routes.home:
        widgetScreen = AddExpenseScreen();
        break;
      case Routes.expenseList:
        widgetScreen = ExpenseListScreen();
        break;
      default:
        widgetScreen = _errorRoute();
    }
    return GetPageRoute(routeName: settings.name, page: () => widgetScreen, settings: settings);
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(child: Text('No Such screen found in route generator')),
    );
  }

}