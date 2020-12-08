import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors.dart';

class MTextField extends StatefulWidget {
  const MTextField({
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

  @override
  _MTextFieldState createState() => _MTextFieldState();
}

class _MTextFieldState extends State<MTextField> {
  final TextEditingController _searchQueryController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
          suffixIcon: _focusNode.hasFocus
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    if (_searchQueryController != null &&
                        _searchQueryController.text.isNotEmpty) {
                      _searchQueryController.clear();
                      widget.onChange('');
                    } else {
                      _focusNode.unfocus();
                    }
                  },
                )
              : null,
          contentPadding: const EdgeInsets.all(15.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: accentColor),
            borderRadius: BorderRadius.all(Radius.circular(26)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: accentColor),
            borderRadius: BorderRadius.all(Radius.circular(26)),
          ),
        ),
      ),
    );
  }
}
