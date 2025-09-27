import 'package:expense_app/screens/expense_controller.dart';
import 'package:expense_app/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseListScreen extends StatelessWidget {
  ExpenseListScreen({super.key});

  var showSummary = true.obs;

  final ExpenseController controller = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Expense List"),
        automaticallyImplyLeading: true,
        backgroundColor: primaryGreenColor,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              showSummary.value = !showSummary.value;
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 12, bottom: 8),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("Summary", style: TextStyle(
                      fontSize: 16, color: blackColor, fontWeight: FontWeight.w500
                  ),)
              ),
            ),
          ),
          Obx(()=>Visibility(
            visible: showSummary.value,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                  border: Border.all(color: grey, width: 1),
                  borderRadius: BorderRadius.circular(15)
              ),
              height: 120,
              child: Column(
                children: [
                  Obx(() => ListTile(
                    leading: const Icon(Icons.calendar_view_day_rounded, color: Color(0xFF4CAF50)),
                    title: const Text('Today\'s Spend'),
                    trailing: Text('\$${controller.todayTotal.value.toStringAsFixed(2)}'),
                  ),),
                  Obx(() => ListTile(
                    leading: const Icon(Icons.calendar_view_week, color: Color(0xFF4CAF50)),
                    title: const Text('This Week\'s Spend'),
                    trailing: Text('\$${controller.weekTotal.value.toStringAsFixed(2)}'),
                  ),)
                ],
              ),
            ),),),
          Obx(()=>controller.expenses.isNotEmpty?
          Flexible(
            child: ListView.separated(
              padding: EdgeInsets.only(left: 20, right: 20),
              itemCount: controller.expenses.length,
              itemBuilder: (context, index){
                final e = controller.expenses[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        getCategoryIcon(e.category),
                        SizedBox(width: 8,),
                        Text(e.category),
                      ],
                    ),
                    SizedBox(width: 8,),
                    Text(e.date),
                    SizedBox(width: 8,),
                    Text('\$${e.amount.toStringAsFixed(2)}'),
                  ],
                );
              }, separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 18,);
            },
            ),
          ):Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Center(
              child: Text("No Expenses Added Yet", style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: blackColor
              ),),
            ),
          ),)
        ],
      ),
    );
  }
  Icon getCategoryIcon(String category) {
    switch (category) {
      case "Food":
        return const Icon(Icons.fastfood, color: Color(0xFF4CAF50));
      case "Transport":
        return const Icon(Icons.directions_car, color: Color(0xFF4CAF50));
      case "Bills":
        return const Icon(Icons.receipt_long, color: Color(0xFF4CAF50));
      case "Shopping":
        return const Icon(Icons.shopping_cart, color: Color(0xFF4CAF50));
      default:
        return const Icon(Icons.attach_money, color: Color(0xFF4CAF50));
    }
  }
}
