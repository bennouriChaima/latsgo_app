import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/constants/firestore_documents_keys_constants.dart';
import 'package:urban_app/app/core/constants/storage_keys_constants.dart';
import 'package:urban_app/app/core/services/local_storage_service.dart';
import 'package:urban_app/app/models/user_model.dart';
import 'package:urban_app/app/modules/user_controller.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode birthdayFocusNode = FocusNode();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  Rx<DateTime> pickedBirthDay = DateTime.now().obs;

  RxString selectedGender = 'male'.obs;

  RxBool isLoadingSignUp = false.obs;

  User? authUser;

  void signUp() {
    if (isLoadingSignUp()) return;
    if (!signUpFormKey.currentState!.validate()) return;
    isLoadingSignUp(true);
    FirebaseFirestore.instance
        .collection(FireStoreDocumentsKeysConstants.users)
        .doc(authUser?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      isLoadingSignUp(false);
      if (documentSnapshot.exists) {
        FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.users).doc(authUser?.uid).update({
          'deviceToken': await LocalStorageService.loadData(key: StorageKeysConstants.fcmToken, type: DataTypes.string),
        });
        Get.find<UserController>().setUser(UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>));
        Get.find<UserController>().initialize();
      } else {
        await FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.users).doc(authUser?.uid).set({
          'id': authUser?.uid,
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'birthday': pickedBirthDay().toString(),
          'gender': selectedGender(),
          'phone': authUser?.phoneNumber,
          'type': 'passenger',
          'deviceToken': await LocalStorageService.loadData(key: StorageKeysConstants.fcmToken, type: DataTypes.string),
        });
        FirebaseFirestore.instance
            .collection(FireStoreDocumentsKeysConstants.users)
            .doc(authUser?.uid)
            .get()
            .then((documentSnapshot) {
          Get.find<UserController>().setUser(UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>));
          Get.find<UserController>().initialize();
        });
      }
    });
  }

  @override
  void onInit() {
    authUser = Get.arguments[0]['authUser'];
    print('auth user: ${authUser?.phoneNumber} - ${authUser?.phoneNumber}');
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
