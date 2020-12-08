import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../theme/colors.dart';
import 'custom_picker.dart';
import 'mpicker.dart';

class MTextPicker extends StatefulWidget {
  const MTextPicker({
    Key key,
    @required this.onChange,
    this.fillColor,
    this.hintText,
    this.textStyle,
    this.hintStyle,
    this.hideText,
    this.keyboardType,
    this.blockField = false,
    this.multiLines = false,
    this.initialTime,
    this.pickerMode,
  }) : super(key: key);

  final Function(String) onChange;
  final bool hideText;
  final bool blockField;
  final bool multiLines;
  final Color fillColor;
  final String hintText;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final TextInputType keyboardType;
  final DateTime initialTime;
  final MCupertinoDatePickerMode pickerMode;

  @override
  _MMTextPickerState createState() => _MMTextPickerState();
}

class _MMTextPickerState extends State<MTextPicker> {
  final TextEditingController _searchQueryController = TextEditingController();
  final FocusNode _focusNode = AlwaysDisabledFocusNode();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    DateTime current = widget.initialTime ?? DateTime.now();
    _searchQueryController.text = getText(current);
    return Container(
      width: widget.blockField ? screenWidth * 0.88 : screenWidth,
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: TextField(
        keyboardType: widget.multiLines
            ? TextInputType.multiline
            : widget.keyboardType ?? TextInputType.text,
        maxLines: widget.multiLines ? 4 : 1,
        obscureText: widget.hideText ?? false,
        focusNode: _focusNode,
        controller: _searchQueryController,
        onChanged: widget.onChange,
        style: widget.textStyle ??
            TextStyle(color: Colors.black87, fontSize: 36.sp),
        cursorColor: Colors.red,
        decoration: InputDecoration(
          fillColor: widget.fillColor ?? Colors.white,
          filled: true,
          hintText: widget.hintText ?? '',
          hintStyle: widget.hintStyle ??
              TextStyle(color: Colors.black54, fontSize: 36.sp),
          suffixIcon: IconButton(
            icon: Icon(Icons.arrow_drop_down, color: primaryColor, size: 56.sp),
            onPressed: () {
              MDatePicker.showCustomPicker(
                context,
                initialTime: current,
                mode: widget.pickerMode,
                onDateChange: (time) => current = time,
                onDone: () {
                  _searchQueryController.text = getText(current);
                  Get.back();
                },
              );
            },
          ),
          contentPadding: const EdgeInsets.all(15.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: accentColor),
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
        ),
      ),
    );
  }

  String getText(DateTime time) {
    switch (widget.pickerMode) {
      case MCupertinoDatePickerMode.year:
        return DateFormat.y().format(time);
      case MCupertinoDatePickerMode.month:
        return DateFormat.yM().format(time);
      case MCupertinoDatePickerMode.date:
        return DateFormat.yMd().format(time);
      case MCupertinoDatePickerMode.time:
        return DateFormat.jms().format(time);
      default:
        return DateFormat.yMd().add_jms().format(time);
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
