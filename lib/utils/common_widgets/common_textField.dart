import 'package:expense_app/utils/color_constants.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final GestureTapCallback? onPressedBtn;
  final TextInputType? keyboardType;
  final TextInputAction? keyboardAction;
  final String? hint;
  final String? labelTxt;
  final bool isEnable;
  final int? lines; // Corresponds to maxLines for the TextFormField
  final int? minLines; // New: Corresponds to minLines for multi-line input
  final int? length;
  final double? width; // Width can still be useful for horizontal constraint
  final Widget? suffix;
  final Widget? prefix;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final bool? obsTxt;
  final bool? read;
  final Color? textColor;
  final TextAlign? textAlign;
  final TextEditingController? textController;

  const   CommonTextField({
    super.key,
    this.keyboardType,
    this.hint,
    this.suffix,
    this.margin,
    this.padding,
    this.width,
    this.obsTxt,
    this.textController,
    this.keyboardAction,
    this.prefix,
    this.lines, // maxLines for the TextFormField
    this.minLines, // minLines for the TextFormField
    this.read,
    this.contentPadding,
    this.length,
    this.isEnable = true,
    this.onChanged,
    this.textColor,
    this.labelTxt,
    this.textAlign,
    this.onPressedBtn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: width, // Keep width if you want to constrain horizontally
      child: TextFormField(
        keyboardType: keyboardType,
        textInputAction: keyboardAction,
        controller: textController,
        onTap: isEnable ? onPressedBtn : () {},
        onChanged: onChanged,
        obscureText: obsTxt ?? false,
        obscuringCharacter: '*',
        readOnly: read ?? false,
        maxLines: lines ?? (minLines != null ? null : 1),
        minLines: minLines, // Set the minimum number of lines
        textAlign: textAlign ?? TextAlign.start,
        maxLength: length ?? 2500,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor ?? blackColor, // Using ColorConstants.black
        ),
        cursorColor: primaryGreenColor,
        decoration: InputDecoration(
          hintText: hint,
          labelText: labelTxt,
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: grey, // Using ColorConstants.grey
          ),
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: suffix,
          counterText: '', // Hides the character counter
          prefixIcon: prefix,
          // Adjusted default contentPadding for better vertical balance.
          // The original `bottom: 12` might have caused some text clipping.
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryGreenColor),
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: primaryGreenColor),
          )
        ),
      ),
    );
  }
}