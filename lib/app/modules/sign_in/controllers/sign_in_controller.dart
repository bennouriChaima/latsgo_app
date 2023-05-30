import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/components/others/toast_component.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/services/firebase_phone_authentication_service.dart';
import 'package:urban_app/app/routes/app_pages.dart';

class SignInController extends GetxController {
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  String? type;

  RxBool isLoadingSignIn = false.obs;

  String countryCode = '+213';
  FocusNode phoneNumberFocusNode = FocusNode();
  TextEditingController phoneNumberController = TextEditingController();

  void sendOtp() {
    if (isLoadingSignIn()) return;
    if (!signInFormKey.currentState!.validate()) return;
    isLoadingSignIn(true);
    PhoneAuthenticationsService().sendOtpToPhone(
      phone: '$countryCode${phoneNumberController.text}',
      onSuccess: () {
        isLoadingSignIn(false);
        ToastComponent()
            .showToast(Get.context!, message: StringsAssetsConstants.sendOtpSuccessMessage, type: ToastTypes.success);
        Get.toNamed(
          Routes.OTP_CONFIRMATION,
          arguments: [
            {
              'type': type,
              'phone': '$countryCode${phoneNumberController.text}',
            },
          ],
        );
      },
      onError: () {
        isLoadingSignIn(false);
        ToastComponent()
            .showToast(Get.context!, message: StringsAssetsConstants.sendOtpFailedMessage, type: ToastTypes.error);
      },
    );
  }

  @override
  void onInit() {
    type = Get.arguments[0]['type'];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
