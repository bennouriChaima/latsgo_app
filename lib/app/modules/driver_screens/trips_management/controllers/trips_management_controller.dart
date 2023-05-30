import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/components/others/toast_component.dart';
import 'package:urban_app/app/core/constants/firestore_documents_keys_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/models/reservation_model.dart';
import 'package:urban_app/app/models/trip_model.dart';
import 'package:urban_app/app/modules/user_controller.dart';

class TripsManagementController extends GetxController {
  RxBool isLoadingGetTrips = false.obs;

  RxList<TripModel> tripsList = <TripModel>[].obs;

  void getTrips() {
    tripsList.clear();
    tripsList.refresh();
    isLoadingGetTrips(true);
    FirebaseFirestore.instance
        .collection(FireStoreDocumentsKeysConstants.trips)
        .where('driverId', isEqualTo: Get.find<UserController>().user()?.id)
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

  List<ReservationModel> getReservationsFromTrip(String tripId) {
    List<ReservationModel> reservationsList = [];
    tripsList().forEach((element) {
      if (element.id == tripId) {
        reservationsList = element.reservations ?? [];
      }
    });
    return reservationsList;
  }

  int getReservationWithId(String reservationId, List<ReservationModel> reservationsList) {
    return reservationsList.indexWhere((element) => element.id == reservationId);
  }

  Future<void> changeReservationStatus(String tripId, String reservationId, String status) async {
    List<ReservationModel> reservationsList = getReservationsFromTrip(tripId);
    reservationsList[getReservationWithId(reservationId, reservationsList)].status = status;

    await FirebaseFirestore.instance
        .collection(FireStoreDocumentsKeysConstants.trips)
        .doc(tripId)
        .update({'reservations': reservationsList.map((e) => e.toJson())});

    await FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.notifications).add(
      {
        'date': DateTime.now().toString(),
        'usersIds': [
          reservationsList[reservationsList.indexWhere((element) => element.id == reservationId)].passenger?.id
        ],
        'title': status == 'accepted'
            ? '${StringsAssetsConstants.tripOrderAcceptedNotificationTitle}: ${tripsList()[tripsList().indexWhere((element) => element.id == tripId)].driver?.firstName} ${tripsList()[tripsList().indexWhere((element) => element.id == tripId)].driver?.lastName}'
            : '${StringsAssetsConstants.tripOrderRejectedNotificationTitle}: ${tripsList()[tripsList().indexWhere((element) => element.id == tripId)].driver?.firstName} ${tripsList()[tripsList().indexWhere((element) => element.id == tripId)].driver?.lastName}',
        'body': status == 'accepted'
            ? '${StringsAssetsConstants.tripOrderAcceptedNotificationBody}: ${tripsList()[tripsList().indexWhere((element) => element.id == tripId)].driver?.firstName} ${tripsList()[tripsList().indexWhere((element) => element.id == tripId)].driver?.lastName}'
            : '${StringsAssetsConstants.tripOrderRejectedNotificationBody}: ${tripsList()[tripsList().indexWhere((element) => element.id == tripId)].driver?.firstName} ${tripsList()[tripsList().indexWhere((element) => element.id == tripId)].driver?.lastName}',
      },
    );

    tripsList()[tripsList().indexWhere((element) => element.id == tripId)].reservations = reservationsList;

    ToastComponent().showToast(
      Get.context!,
      message: status == 'accepted'
          ? StringsAssetsConstants.requestAcceptedSuccessMessage
          : StringsAssetsConstants.requestRejectedSuccessMessage,
      type: ToastTypes.success,
    );
    tripsList.refresh();
  }

  Future<void> deleteTrip(String? tripId) async {
    await FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.trips).doc(tripId).delete();
    await FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.notifications).add(
      {
        'date': DateTime.now().toString(),
        'usersIds': tripsList()[tripsList().indexWhere((element) => element.id == tripId)].reservationsPassengers,
        'title': StringsAssetsConstants.tripDeletedNotificationTitle,
        'body':
            '${StringsAssetsConstants.tripDeletedNotificationBody}: ${tripsList()[tripsList().indexWhere((element) => element.id == tripId)].driver?.firstName} ${tripsList()[tripsList().indexWhere((element) => element.id == tripId)].driver?.lastName}',
      },
    );
    ToastComponent().showToast(
      Get.context!,
      message: StringsAssetsConstants.tripCancelSuccessMessage,
      type: ToastTypes.success,
    );
    getTrips();
  }

  Future<void> makeAsDone(String? tripId) async {
    await FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.trips).doc(tripId).update(
      {
        'status': 'done',
      },
    );
    getTrips();
  }

  @override
  void onInit() {
    getTrips();
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
