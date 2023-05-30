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
  RxInt currentStep = 0.obs;

  PageController signUpPageController = PageController(initialPage: 0);

  final GlobalKey<FormState> signUpStep1FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpStep2FormKey = GlobalKey<FormState>();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode birthdayFocusNode = FocusNode();

  FocusNode carBrandNameFocusNode = FocusNode();
  FocusNode carModelNameFocusNode = FocusNode();
  FocusNode carPlateFocusNode = FocusNode();
  FocusNode numberOfSeatsFocusNode = FocusNode();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  TextEditingController carBrandNameController = TextEditingController();
  TextEditingController carModelNameController = TextEditingController();
  TextEditingController carPlateController = TextEditingController();
  TextEditingController numberOfSeatsController = TextEditingController();

  Rx<DateTime> pickedBirthDay = DateTime.now().obs;

  RxString selectedGender = 'male'.obs;

  RxBool isLoadingSignUp = false.obs;

  User? authUser;

  void goToStep2() {
    if (!signUpStep1FormKey.currentState!.validate()) return;
    currentStep(1);
    signUpPageController.jumpToPage(1);
  }

  void signUp() {
    if (isLoadingSignUp()) return;
    if (!signUpStep2FormKey.currentState!.validate()) return;
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
          'type': 'driver',
          'deviceToken': await LocalStorageService.loadData(key: StorageKeysConstants.fcmToken, type: DataTypes.string),
          'car': {
            'brand': carBrandNameController.text,
            'model': carModelNameController.text,
            'plate': carPlateController.text,
            'numberOfSeats': int.parse(numberOfSeatsController.text),
          },
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
