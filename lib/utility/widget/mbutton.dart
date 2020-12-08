import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors.dart';

class MButton extends StatelessWidget {
  const MButton({
    Key key,
    @required this.onPress,
    @required this.text,
    this.fillColor,
    this.splashColor,
    this.borderColor,
    this.textColor,
    this.icon,
    this.textSize,
    this.size,
  }) : super(key: key);

  final VoidCallback onPress;
  final Color fillColor;
  final Color splashColor;
  final Color borderColor;
  final Color textColor;
  final Icon icon;
  final String text;
  final double textSize;
  final ButtonSize size;

  @override
  Widget build(BuildContext context) {
    BoxConstraints getBoxConstraints() {
      switch (size) {
        case ButtonSize.max:
          return BoxConstraints(maxWidth: 1.sw);
        case ButtonSize.min:
          return BoxConstraints(minWidth: 88.sp, minHeight: 36.sp);
        case ButtonSize.block:
        default:
          return BoxConstraints(maxWidth: 0.88.sw);
      }
    }

    final Widget textBtn = Text(
      text,
      maxLines: 1,
      style: TextStyle(
        fontSize: textSize ?? 60.sp,
        color: textColor ?? secondaryColor,
        fontWeight: FontWeight.bold,
      ),
    );

    return RawMaterialButton(
      onPressed: onPress,
      fillColor: fillColor ?? primaryColor,
      splashColor: splashColor ?? accentColor,
      constraints: getBoxConstraints(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
        side: BorderSide(color: borderColor ?? secondaryColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(60.sp),
        child: (size != ButtonSize.min)
            ? Stack(
                children: <Widget>[
                  if (icon != null)
                    Align(child: icon, alignment: Alignment.centerLeft),
                  Center(child: textBtn)
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) icon,
                  if (icon != null) SizedBox(width: 10.sp),
                  textBtn
                ],
              ),
      ),
    );
  }
}

enum ButtonSize { max, block, min }
