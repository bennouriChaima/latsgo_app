import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/constants/firestore_documents_keys_constants.dart';
import 'package:urban_app/app/models/notification_model.dart';
import 'package:urban_app/app/modules/user_controller.dart';

class NotificationsController extends GetxController {
  RxBool isLoadingGetNotifications = false.obs;

  RxList<NotificationModel> notificationsList = <NotificationModel>[].obs;

  void getNotifications() {
    print(Get.find<UserController>().user()?.id);
    notificationsList.clear();
    notificationsList.refresh();
    isLoadingGetNotifications(true);
    FirebaseFirestore.instance
        .collection(FireStoreDocumentsKeysConstants.notifications)
        .where('usersIds', arrayContains: Get.find<UserController>().user()?.id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      isLoadingGetNotifications(false);
      querySnapshot.docs.forEach((element) {
        notificationsList().add(NotificationModel.fromJson(element.data() as Map<String, dynamic>));
        notificationsList.refresh();
      });
    });

    print('states count::: ${notificationsList.length}');
  }

  @override
  void onInit() {
    getNotifications();
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
