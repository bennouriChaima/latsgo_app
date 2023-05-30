import 'package:get/get.dart';

import '../controllers/otp_confirmation_controller.dart';

class OtpConfirmationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpConfirmationController>(
      () => OtpConfirmationController(),
    );
  }
}
