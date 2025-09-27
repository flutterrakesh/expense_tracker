import 'package:expense_app/data/expense_model.dart';
import 'package:expense_app/routes/routes.dart';
import 'package:expense_app/screens/expense_controller.dart';
import 'package:expense_app/utils/color_constants.dart';
import 'package:expense_app/utils/common_widgets/common_button.dart';
import 'package:expense_app/utils/common_widgets/common_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpenseScreen extends StatelessWidget {
  AddExpenseScreen({super.key});

  final dateController = TextEditingController();
  final amountController = TextEditingController();

  var selectedCategory = "Select Category".obs;
  List<String> categories = ["Food", "Transport", "Bills", "Shopping"];

  final ExpenseController controller = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusScopeNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Add Expense"),
          automaticallyImplyLeading: false,
          backgroundColor: primaryGreenColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CommonTextField(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      hint: "Add Amount",
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 14),
                        child: Text("\$", style: TextStyle(
                          fontSize: 16, color: blackColor
                        ),),
                      ),
                      textController: amountController,
                      keyboardType: TextInputType.number,
                    ),
                    Obx(()=>CommonTextField(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          hint: selectedCategory.value,
          read: true,
          isEnable: true,
          onPressedBtn: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              builder: (context) {
                return Container(
                  height: 240,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(categories[index]),
                        onTap: () {
                          selectedCategory.value = categories[index];
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
          keyboardType: TextInputType.number,
        ),),
                    CommonTextField(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      hint: "Select Date",
                      textController: dateController,
                      read: true,
                      isEnable: true,
                      onPressedBtn: ()async{
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: primaryGreenColor, // header background color
                                  onPrimary: Colors.white, // header text color
                                  onSurface: Colors.black, // body text color
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          String formattedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.day.toString().padLeft(2,'0')}";
                          dateController.text = formattedDate;
                          debugPrint("Selected Date ===> $formattedDate");
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.expenseList);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("Show Expense List", style: TextStyle(
                              fontSize: 16, color: primaryGreenColor, fontWeight: FontWeight.w500
                            ),)),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            CommonButton(
              margin: EdgeInsets.only(bottom: 30, left: 20, right: 20),
              height: 45,
              onPressedBtn: (){
                double amount = double.tryParse(amountController.text) ?? 0;
                String category = selectedCategory.value;
                String date = dateController.text;

                if (amount > 0 && category != "Select Category" && date.isNotEmpty) {
                  ExpenseModel newExpense = ExpenseModel(
                    amount: amount,
                    category: category,
                    date: date,
                  );

                  controller.addExpense(newExpense);
                  amountController.clear();
                  dateController.clear();
                  selectedCategory.value = 'Select Category';
                  Get.toNamed(Routes.expenseList);
                } else {
                  Get.snackbar('Error', 'Please fill all fields',
                      backgroundColor: Colors.red, colorText: Colors.white);
                }
              },
              btnText: "Submit",
            )
          ],
        ),
      ),
    );
  }
}
