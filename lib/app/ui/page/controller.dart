import 'dart:isolate';
import 'dart:ui';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utility/log/logger.dart';
import '../../core/presenter.dart';

class LocaleController extends GetxController {
  RxString address = "".obs;
  RxString home = "".obs;
  Position position;
  RxBool isAway = false.obs;

  Presenter _presenter = Presenter();
  final String isolateName = 'isolate';
  final ReceivePort port = ReceivePort();
  SendPort uiSendPort;

  @override
  void onInit() {
    super.onInit();
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      isolateName,
    );
    AndroidAlarmManager.initialize();
    port.listen((_) => func());
    // timer();
    // _presenter.startSV();
    // _presenter.methodChannel.setMethodCallHandler(_handleMethod);
  }

  // Future<void> _handleMethod(MethodCall call) async {
  //   if (call.method == "locale") {
  //       func();
  //   }
  // }

  void getPermission() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission permission = await Geolocator.requestPermission();
    }
  }

  void getPos() async {
    Logger.write(DateFormat.jms().format(DateTime.now()));
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> p =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = p[0];
      address.value =
          "${place.street}, ${place.administrativeArea}, ${place.country}";
    } catch (e) {
      print(e);
    }
  }

  void getAdd() async {
    List<Location> locations = await locationFromAddress("18 Pasteur, Hai Chau",
        localeIdentifier: 'vi');
    Location location = locations[0];
    try {
      List<Placemark> p =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      Placemark place = p[0];
      home.value =
          "${place.street}, ${place.administrativeArea}, ${place.country}";
    } catch (e) {
      print(e);
    }
  }

  void func() async {
    // await getPos();
    isAway.value = !(home.value == address.value);
    var d = await _presenter.testFunction(isAway.value);
    Logger.write(d);
  }

  void callback() async {
    Logger.write('Alarm fired!');
    Logger.write(DateFormat.jms().format(DateTime.now()));
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> p =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = p[0];
      address.value =
      "${place.street}, ${place.administrativeArea}, ${place.country}";
    } catch (e) {
      print(e);
    }
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);
  }

  void timer() async {
    Logger.write(DateFormat.jms().format(DateTime.now()));
    await AndroidAlarmManager.periodic(const Duration(minutes: 1), 0, callback,
        exact: true, wakeup: true);
  }

// void testBG() async {
//   _presenter.stopSV();
// }
}
