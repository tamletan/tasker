import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../utility/log/logger.dart';
import '../../utility/theme/themes.dart';
import '../core/app_routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        locale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        theme: kLightTheme,
        defaultTransition: Transition.downToUp,
        initialRoute: AppRoutes.INITIAL,
        getPages: AppRoutes.routes,
        logWriterCallback: Logger.write,
      );
}
