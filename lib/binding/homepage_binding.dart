import 'package:api_with_getx/controller/homepage_controller.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomePageController>(() => HomePageController());
  }
}
