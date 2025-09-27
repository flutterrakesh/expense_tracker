import 'package:expense_app/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonButton extends StatelessWidget{
  GestureTapCallback? onPressedBtn;
  bool isEnable;
  bool isShadow;
  String? btnText;
  double? borderRadius;
  double height = 60;
  double? width;
  EdgeInsets? margin;
  double? textSize;
  Color? textColor;
  Color? iconColor;
  Color? btnColor;
  Color? borderColor;
  double? borderWidth;
  FontWeight? fontWeight;

  CommonButton({
    this.onPressedBtn,
    this.isEnable = true,
    this.isShadow = true,
    this.btnText,
    this.borderRadius,
    this.height = 60,
    this.width,
    this.margin,
    this.textSize,
    this.textColor,
    this.btnColor,
    this.borderColor,
    this.borderWidth,
    this.fontWeight,
    this.iconColor,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable ? onPressedBtn : () {},
      child: Container(
        height: height,
        width: width ?? Get.width,
        margin: margin,
        padding: const EdgeInsets.only(right: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isEnable ? btnColor ?? primaryGreenColor : const Color(0xffCBCBCB),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          border: Border.all(color: borderColor ?? Colors.transparent, width: borderWidth ?? 1),
          boxShadow: isShadow ? const [
            BoxShadow(
              color: Color(0x3D001978),
              offset: Offset(0, 3),
              blurRadius: 13,
            )
          ] : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                btnText ?? 'Continue',
                style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: textSize ?? 16,
                    fontWeight: fontWeight ?? FontWeight.w500),
              ),
            ),
            Icon(Icons.arrow_forward_ios_sharp, color: iconColor??Colors.white, size: 20,),
          ],
        ),
      ),
    );
  }


}
