import 'package:api_with_getx/binding/homepage_binding.dart';
import 'package:api_with_getx/screen/homepage.dart';
import 'package:api_with_getx/route/nameroute.dart';
import 'package:get/get.dart';

class PageRoutes {
  static final pages = [
    GetPage(
        name: NameRoutes.homepage,
        page: ()=>HomePage(),
      binding: HomePageBinding(),
    )
  ];
}