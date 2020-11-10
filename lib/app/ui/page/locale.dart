import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class GetLocale extends GetWidget<LocaleController> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('QWERTY')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text("Home: ${controller.home.value}")),
              SizedBox(height: 30),
              Obx(() => Text("Position: ${controller.address.value}")),
              SizedBox(height: 30),
              Obx(() => Text("Away: ${controller.isAway.value}")),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.timer,
          child: Icon(Icons.update),
        ),
      );
}
