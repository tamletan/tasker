import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';

class MPopUp {
  static void showCustomDialog(
    BuildContext context, {
    @required String content,
    TextStyle contentStyle,
    String textConfirm,
    String textCancel,
    @required Function onConfirm,
    Function onCancel,
    Color buttonColor,
    Color confirmTextColor,
    Color cancelTextColor,
    Color backgroundColor,
    bool barrierDismissible = true,
    Widget confirm,
    Widget cancel,
    List<Widget> actions,
  }) {
    final widget = AlertDialog(
      contentPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      backgroundColor: backgroundColor ?? canvasColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(content ?? '',
                textAlign: TextAlign.center,
                style: contentStyle ??
                    TextStyle(fontSize: 36.sp, color: Colors.black)),
          ),
          const Divider(thickness: 1, height: 0, color: accentColor),
          IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (onCancel != null)
                  Expanded(
                    child: FlatButton(
                      onPressed: () => onCancel?.call(),
                      child: Text(
                        textCancel ?? 'Cancel',
                        style: TextStyle(
                          color: cancelTextColor ?? accentColor,
                          fontSize: 36.sp,
                        ),
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                if (onCancel != null)
                  const VerticalDivider(
                      thickness: 1, width: 0, color: accentColor),
                Expanded(
                  child: FlatButton(
                    onPressed: () => onConfirm?.call(),
                    child: Text(
                      textConfirm ?? 'OK',
                      style: TextStyle(
                        color: confirmTextColor ?? accentColor,
                        fontSize: 36.sp,
                      ),
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

    Get.generalDialog(
      pageBuilder: (buildContext, animation, secondaryAnimation) =>
          SafeArea(child: Builder(builder: (context) => widget)),
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutQuad,
          ),
          child: child,
        );
      },
      useRootNavigator: true,
    );
  }
}
