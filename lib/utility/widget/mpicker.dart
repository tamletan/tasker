import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import 'custom_picker.dart';

class MDatePicker {
  static Future showCustomPicker(
    BuildContext context, {
    MCupertinoDatePickerMode mode,
    DateTime initialTime,
    Function onDone,
    Function(DateTime) onDateChange,
    String label,
    String textBtn,
  }) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Center(
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {},
                      child: Text(
                        label ?? 'Calendar',
                        style: TextStyle(fontSize: 60.sp),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => onDone?.call() ?? Get.back(),
                      child: Text(
                        textBtn ?? 'Done',
                        style: TextStyle(fontSize: 60.sp),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 0.h,
                thickness: 1.h,
                color: accentColor,
              ),
              SizedBox(
                height: 0.3.sh,
                child: MCupertinoDatePicker(
                  mode: mode,
                  initialDateTime: initialTime,
                  onDateTimeChanged: (dateTime) => onDateChange?.call(dateTime),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
