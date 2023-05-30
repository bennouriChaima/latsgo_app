import 'package:get/get.dart';

import '../controllers/my_trips_controller.dart';

class MyTripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTripsController>(
      () => MyTripsController(),
    );
  }
}
