import 'package:get/get.dart';

import '../controllers/trips_management_controller.dart';

class TripsManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripsManagementController>(
      () => TripsManagementController(),
    );
  }
}
