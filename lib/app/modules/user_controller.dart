import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/constants/storage_keys_constants.dart';
import 'package:urban_app/app/core/services/local_storage_service.dart';
import 'package:urban_app/app/models/user_model.dart';
import 'package:urban_app/app/routes/app_pages.dart';

class UserController extends GetxController {
  Rx<UserModel?> user = UserModel().obs;
  User? firebaseUser;

  void setUser(UserModel user) {
    this.user(user);
    LocalStorageService.saveData(
        key: StorageKeysConstants.userData, value: jsonEncode(user.toJson()), type: DataTypes.string);
  }

  void clearUser() {
    LocalStorageService.deleteData(key: StorageKeysConstants.userData);
    FirebaseAuth.instance.signOut();
    initialize();
  }

  initialize() async {
    if (await LocalStorageService.loadData(key: StorageKeysConstants.userData, type: DataTypes.string) != null) {
      user(UserModel.fromJson(
          jsonDecode(await LocalStorageService.loadData(key: StorageKeysConstants.userData, type: DataTypes.string))));
      firebaseUser = FirebaseAuth.instance.currentUser;
      if (user()?.type == 'passenger') {
        Get.offAllNamed(Routes.PASSENGER_SEARCH);
      } else {
        Get.offAllNamed(Routes.DRIVER_TRIPS_MANAGEMENT);
      }
    } else {
      Get.offAllNamed(Routes.TYPE_SELECTOR);
    }
  }
}
