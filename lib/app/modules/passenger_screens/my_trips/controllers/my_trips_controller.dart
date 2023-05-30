import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/constants/firestore_documents_keys_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/models/reservation_model.dart';
import 'package:urban_app/app/models/trip_model.dart';
import 'package:urban_app/app/modules/user_controller.dart';

import '../../../../core/components/others/toast_component.dart';

class MyTripsController extends GetxController {
  RxBool isLoadingGetTrips = false.obs;

  RxList<TripModel> tripsList = <TripModel>[].obs;

  void getTripsSearch() {
    tripsList.clear();
    tripsList.refresh();
    isLoadingGetTrips(true);
    FirebaseFirestore.instance
        .collection(FireStoreDocumentsKeysConstants.trips)
        .where(
          'reservationsPassengers',
          arrayContains: Get.find<UserController>().user()?.id,
        )
        .get()
        .then((QuerySnapshot querySnapshot) {
      isLoadingGetTrips(false);
      querySnapshot.docs.forEach((element) {
        print('trip :::: ${element.id}');
        tripsList().add(TripModel.fromJson(element.data() as Map<String, dynamic>, element.id));
        tripsList.refresh();
      });
    });

    print('states count::: ${tripsList.length}');
  }

  RxBool isLoadingCancel = false.obs;

  Future<void> cancelTrip(TripModel tripData, String? reservationId) async {
    print('reservation id::: ${reservationId}');
    if (isLoadingCancel()) return;
    List<String> reservationsPassengers = List.from(tripData.reservationsPassengers ?? []);
    reservationsPassengers.remove(Get.find<UserController>().user()?.id);
    List<ReservationModel> reservations = List.from(tripData.reservations ?? []);
    reservations.removeWhere((element) => element.id == reservationId);
    isLoadingCancel(true);
    await FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.trips).doc(tripData.id).update({
      'reservedSeats': FieldValue.increment(
          -(tripData.reservations?.where((element) => element.id == reservationId).toList()[0].reservedSeats ?? 0)),
      'isSeatsCompleted': false,
      'reservationsPassengers': reservationsPassengers,
      'reservations': reservations,
    });

    await FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.notifications).add(
      {
        'date': DateTime.now().toString(),
        'usersIds': [tripData.driver?.id],
        'title': StringsAssetsConstants.passengerCancelTripNotificationTitle,
        'body':
            '${Get.find<UserController>().user()?.firstName} ${Get.find<UserController>().user()?.lastName} ${StringsAssetsConstants.passengerCancelTripNotificationBody}',
      },
    );

    ToastComponent().showToast(
      Get.context!,
      message: StringsAssetsConstants.bookingCancelSuccessMessage,
      type: ToastTypes.success,
    );

    getTripsSearch();

    isLoadingCancel(false);
  }

  FocusNode noteFocusNode = FocusNode();
  TextEditingController noteController = TextEditingController();
  RxDouble rateValue = 0.0.obs;

  Future<void> rateDriver(String? driverId) async {
    await FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.users).doc(driverId).update(
      {
        'rates': FieldValue.arrayUnion([
          {
            'date': DateTime.now().toString(),
            'note': noteController.text,
            'rating': rateValue(),
            'userId': Get.find<UserController>().user()?.id,
          }
        ]),
      },
    );
    Get.back();
  }

  @override
  void onInit() {
    getTripsSearch();
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
