import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/constants/firestore_documents_keys_constants.dart';

class AboutController extends GetxController {
  RxString aboutText = ''.obs;

  Future<void> getAboutText() async {
    await FirebaseFirestore.instance
        .collection(FireStoreDocumentsKeysConstants.appConfig)
        .doc('appInformations')
        .get()
        .then((querySnapshot) {
      print(querySnapshot.data());
      aboutText(querySnapshot.data()?['aboutUs']);
    });
  }

  @override
  void onInit() {
    getAboutText();
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
