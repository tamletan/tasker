import 'package:get/get.dart';

import '../ui/page/binding.dart';
import '../ui/page/locale.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static const String INITIAL = Routes.HOME;
  static final List<GetPage> routes = <GetPage>[
    GetPage(name: Routes.HOME, page: () => GetLocale(), binding: AppBinding()),
  ];
}

abstract class Routes {
  static const String HOME = '/';
  static const String INFO = '/info';
}
