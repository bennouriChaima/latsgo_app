import 'package:get/get.dart';

import '../controllers/type_selector_controller.dart';

class TypeSelectorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TypeSelectorController>(
      () => TypeSelectorController(),
    );
  }
}
