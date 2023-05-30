import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/components/others/toast_component.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/services/random_string_generator_service.dart';
import 'package:urban_app/app/modules/user_controller.dart';

import '../../../core/constants/firestore_documents_keys_constants.dart';

class ContactUsController extends GetxController {
  final GlobalKey<FormState> contactUsFormFormKey = GlobalKey<FormState>();

  FocusNode subjectFocusNode = FocusNode();
  FocusNode messageFocusNode = FocusNode();

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  RxBool isLoadingSendRequest = false.obs;

  Future<void> sendRequest() async {
    if (isLoadingSendRequest()) return;
    if (!contactUsFormFormKey.currentState!.validate()) return;
    isLoadingSendRequest(true);
    await FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.contacts).add(
      {
        'user': Get.find<UserController>().user()?.toJson(),
        'createdAt': DateTime.now().toString(),
        'subject': subjectController.text,
        'message': messageController.text,
        'id': RandomStringGeneratorService().getRandomString(20),
      },
    );
    isLoadingSendRequest(false);
    Get.back();
    ToastComponent()
        .showToast(Get.context!, message: StringsAssetsConstants.successSendContactRequest, type: ToastTypes.success);
  }

  @override
  void onInit() {
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
