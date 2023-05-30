import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:urban_app/app/core/components/others/toast_component.dart';
import 'package:urban_app/app/core/constants/firestore_documents_keys_constants.dart';
import 'package:urban_app/app/core/constants/storage_keys_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/services/firebase_phone_authentication_service.dart';
import 'package:urban_app/app/core/services/local_storage_service.dart';
import 'package:urban_app/app/core/utils/validator_util.dart';
import 'package:urban_app/app/models/user_model.dart';
import 'package:urban_app/app/modules/user_controller.dart';
import 'package:urban_app/app/routes/app_pages.dart';

class OtpConfirmationController extends GetxController {
  final GlobalKey<FormState> otpConfirmationFormKey = GlobalKey<FormState>();

  StreamController<ErrorAnimationType> otpErrorController = StreamController<ErrorAnimationType>();

  String? phoneNumber;

  String? type;

  TextEditingController pinController = TextEditingController();
  CustomTimerController timerController = CustomTimerController();

  RxBool isAllowedToResendOtp = false.obs;
  RxBool isLoadingResendOtp = false.obs;
  RxBool isLoadingVerifyOtp = false.obs;

  void resendOtp() {
    isLoadingResendOtp(true);
    PhoneAuthenticationsService().sendOtpToPhone(
      phone: phoneNumber!,
      onSuccess: () {
        isLoadingResendOtp(false);
        ToastComponent()
            .showToast(Get.context!, message: StringsAssetsConstants.sendOtpSuccessMessage, type: ToastTypes.success);
        timerController.reset();
        timerController.start();
        isAllowedToResendOtp(false);
      },
      onError: () {
        isLoadingResendOtp(false);
        ToastComponent()
            .showToast(Get.context!, message: StringsAssetsConstants.sendOtpFailedMessage, type: ToastTypes.error);
      },
    );
  }

  void verifyOtp() {
    if (isLoadingVerifyOtp()) return;
    if (ValidatorUtil.validOtp(pinController.text) != null) {
      otpErrorController.add(ErrorAnimationType.shake);
      return;
    }
    isLoadingVerifyOtp(true);
    PhoneAuthenticationsService().otpVerification(
      otp: pinController.text,
      onSuccess: (user) {
        isLoadingVerifyOtp(false);
        FirebaseFirestore.instance
            .collection(FireStoreDocumentsKeysConstants.users)
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) async {
          if (documentSnapshot.exists) {
            FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.users).doc(user.uid).update({
              'deviceToken':
                  await LocalStorageService.loadData(key: StorageKeysConstants.fcmToken, type: DataTypes.string),
            });
            Get.find<UserController>().setUser(UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>));
            Get.find<UserController>().initialize();
            if (type == 'passenger') {
              Get.offAllNamed(Routes.PASSENGER_SEARCH);
            } else {
              Get.offAllNamed(Routes.DRIVER_TRIPS_MANAGEMENT);
            }
          } else {
            if (type == 'passenger') {
              Get.offAllNamed(
                Routes.PASSENGER_SIGN_UP,
                arguments: [
                  {
                    'authUser': user,
                  },
                ],
              );
            } else {
              Get.offAllNamed(
                Routes.DRIVER_SIGN_UP,
                arguments: [
                  {
                    'authUser': user,
                  },
                ],
              );
            }
          }
        });
      },
      onError: () {
        isLoadingVerifyOtp(false);
        ToastComponent().showToast(Get.context!,
            message: StringsAssetsConstants.otpVerificationWrongMessage, type: ToastTypes.error);
        otpErrorController.add(ErrorAnimationType.shake);
      },
    );
  }

  @override
  void onInit() {
    type = Get.arguments[0]['type'];
    phoneNumber = Get.arguments[0]['phone'];
    super.onInit();
  }

  @override
  void onReady() {
    timerController.start();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
