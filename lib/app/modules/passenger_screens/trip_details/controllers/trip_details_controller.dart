import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/components/others/toast_component.dart';
import 'package:urban_app/app/core/constants/firestore_documents_keys_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/services/random_string_generator_service.dart';
import 'package:urban_app/app/models/trip_model.dart';
import 'package:urban_app/app/modules/passenger_screens/search/controllers/search_controller.dart';
import 'package:urban_app/app/modules/user_controller.dart';

class TripDetailsController extends GetxController {
  Rx<TripModel> tripData = TripModel().obs;

  RxInt numberOfSeats = 1.obs;

  void addNumberOfSeats() {
    if (numberOfSeats < ((tripData().numberOfSeats ?? 0) - (tripData().reservedSeats ?? 0))) {
      numberOfSeats.value++;
    }
  }

  void minusNumberOfSeats() {
    if (numberOfSeats > 1) {
      numberOfSeats.value--;
    }
  }

  RxBool isLoadingBooking = false.obs;
  void booking() {
    if (isLoadingBooking()) return;
    isLoadingBooking(true);
    FirebaseFirestore.instance
        .collection(FireStoreDocumentsKeysConstants.trips)
        .doc(tripData().id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      print('document exist:::: ${tripData().id}');
      if (documentSnapshot.exists) {
        FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.trips).doc(tripData().id).update({
          'reservedSeats': FieldValue.increment(numberOfSeats()),
          'isSeatsCompleted':
              (tripData().numberOfSeats == (tripData().reservedSeats ?? 0) + numberOfSeats()) ? true : false,
          'reservationsPassengers': FieldValue.arrayUnion([Get.find<UserController>().user()?.id]),
          'reservations': FieldValue.arrayUnion([
            {
              'id': RandomStringGeneratorService().getRandomString(20),
              'date': DateTime.now().toString(),
              'passenger': Get.find<UserController>().user.toJson(),
              'status': 'pending',
              'reservedSeats': numberOfSeats(),
              'totalPrice': numberOfSeats() * (tripData().price ?? 0),
            }
          ]),
        });

        await FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.notifications).add(
          {
            'date': DateTime.now().toString(),
            'usersIds': [tripData().driver?.id],
            'title': StringsAssetsConstants.tripReservedNotificationTitle,
            'body': StringsAssetsConstants.tripReservedNotificationBody,
          },
        );

        Get.find<SearchController>().getTripsSearch();
        Get.back();

        ToastComponent().showToast(
          Get.context!,
          message: StringsAssetsConstants.bookingSuccessMessage,
          type: ToastTypes.success,
        );
      }
      isLoadingBooking(false);
    });
  }

  @override
  void onInit() {
    if (Get.arguments[0]['trip'] != null) {
      tripData(Get.arguments[0]['trip']);
    }
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
