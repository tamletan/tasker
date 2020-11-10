import 'package:flutter/services.dart';

import '../../utility/channel/config.dart';
import '../../utility/log/logger.dart';

class Presenter {
  final MethodChannel methodChannel = MethodChannel(method_channel_name);

  Future<String> testFunction(bool isAway) async {
    return isAway
        ? await methodChannel.invokeMethod(method_mute)
        : await methodChannel.invokeMethod(method_unmute);
  }

  void startSV() async {
    final result = await methodChannel.invokeMethod(method_call_sv_on);
    Logger.write("startSV: $result");
  }

  void stopSV() async {
    final result = await methodChannel.invokeMethod(method_call_sv_off);
    Logger.write("stopSV: $result");
  }

  void setOnROD() async {
    final result = await methodChannel.invokeMethod(method_call_rod_on);
    Logger.write("setOnROD: $result");
  }

  void setOffROD() async {
    final result = await methodChannel.invokeMethod(method_call_rod_off);
    Logger.write("setOffROD: $result");
  }

  void setOnROB() async {
    final result = await methodChannel.invokeMethod(method_call_rob_on);
    Logger.write("setOnROB: $result");
  }

  void setOffROB() async {
    final result = await methodChannel.invokeMethod(method_call_rob_off);
    Logger.write("setOffROB: $result");
  }
}
