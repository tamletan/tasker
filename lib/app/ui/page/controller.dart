import 'package:flutter/services.dart';
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

  @override
  void onInit() {
    super.onInit();
    _presenter.startSV();
    Logger.write(DateFormat.jms().format(DateTime.now()));
    _presenter.methodChannel.setMethodCallHandler(_handleMethod);
  }

  Future<void> _handleMethod(MethodCall call) async {
    if (call.method == "locale") {
      func();
    }
  }

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

  Future<void> getPos() async {
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
    Logger.write(DateFormat.jms().format(DateTime.now()));
    await getPos();
    isAway.value = !(home.value == address.value);
    var d = await _presenter.testFunction(isAway.value);
    Logger.write(d);
  }

  void testBG() async {
    _presenter.stopSV();
  }
}
