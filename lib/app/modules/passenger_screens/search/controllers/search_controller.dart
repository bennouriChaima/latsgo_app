import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/constants/firestore_documents_keys_constants.dart';
import 'package:urban_app/app/models/trip_model.dart';
import 'package:urban_app/app/models/util_model.dart';

class SearchController extends GetxController {
  RxList<UtilModel> statesList = <UtilModel>[].obs;

  void getStatesList() {
    FirebaseFirestore.instance
        .collection(FireStoreDocumentsKeysConstants.states)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        statesList().add(UtilModel.fromJson(element.data() as Map<String, dynamic>));
        statesList.refresh();
      });
    });

    print('states count::: ${statesList.length}');
  }

  UtilModel? selectedStartingPoint;
  void selectStartingPoint(UtilModel? value) {
    selectedStartingPoint = value;
  }

  UtilModel? selectedArivalPoint;
  void selectArivalPoint(UtilModel? value) {
    selectedArivalPoint = value;
  }

  FocusNode startingPointFocusNode = FocusNode();
  FocusNode arivalPointFocusNode = FocusNode();

  RxBool isLoadingGetTrips = false.obs;

  RxList<TripModel> tripsList = <TripModel>[].obs;

  void getTripsSearch() {
    tripsList.clear();
    tripsList.refresh();
    isLoadingGetTrips(true);
    FirebaseFirestore.instance
        .collection(FireStoreDocumentsKeysConstants.trips)
        .where('startingPoint.id', isEqualTo: selectedStartingPoint?.id)
        .where('arivalPoint.id', isEqualTo: selectedArivalPoint?.id)
        .where('isSeatsCompleted', isEqualTo: false)
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

  @override
  void onInit() {
    getStatesList();
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
