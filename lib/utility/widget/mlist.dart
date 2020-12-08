import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';

class MList extends StatelessWidget {
  const MList({Key key, @required this.items}) : super(key: key);

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length + 2,
      separatorBuilder: (_, __) => Divider(
        height: 1.sp,
        thickness: 3.sp,
        color: accentColor,
      ),
      itemBuilder: (context, index) => (index == 0 || index == items.length + 1)
          ? Container()
          : ListTile(
              title: Text(
                items[index - 1],
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 60.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                print(items[index - 1]);
                // Get.to(Local());
              },
              trailing: Icon(Icons.arrow_forward_ios,
                  color: primaryColor, size: 80.sp),
              // subtitle: Text(items[index]),
            ),
    );
  }
}
