import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/components/others/toast_component.dart';
import 'package:urban_app/app/core/constants/firestore_documents_keys_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/models/util_model.dart';
import 'package:urban_app/app/modules/driver_screens/trips_management/controllers/trips_management_controller.dart';
import 'package:urban_app/app/modules/user_controller.dart';

class CreateNewTripController extends GetxController {
  final GlobalKey<FormState> createNewTripFormFormKey = GlobalKey<FormState>();

  FocusNode startingPointFocusNode = FocusNode();
  FocusNode arivalPointFocusNode = FocusNode();
  FocusNode startingDateFocusNode = FocusNode();
  FocusNode startingTimeFocusNode = FocusNode();
  FocusNode numberOfSeatsFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode priceFocusNode = FocusNode();

  TextEditingController startingPointController = TextEditingController();
  TextEditingController arivalPointController = TextEditingController();
  TextEditingController startingDateController = TextEditingController();
  TextEditingController startingTimeController = TextEditingController();
  TextEditingController numberOfSeatsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  RxString selectedTripType = 'round'.obs;

  RxBool isOnlyWomens = false.obs;

  RxList<UtilModel> startingPointsList = <UtilModel>[
    UtilModel(id: 1, titleEn: 'adrar'),
    UtilModel(id: 2, titleEn: 'souk ahras'),
  ].obs;

  UtilModel? selectedStartingPoint;
  void selectStartingPoint(UtilModel? value) {
    selectedStartingPoint = value;
  }

  UtilModel? selectedArivalPoint;
  void selectArivalPoint(UtilModel? value) {
    selectedArivalPoint = value;
  }

  Rx<DateTime> pickedStartingDate = DateTime.now().obs;

  Rx<TimeOfDay> pickedStartingTime = TimeOfDay.now().obs;

  RxString tripType = 'round'.obs;

  RxBool isLoadingCreateNewTrip = false.obs;

  Future<void> createNewTrip() async {
    if (isLoadingCreateNewTrip()) return;
    if (!createNewTripFormFormKey.currentState!.validate()) return;
    isLoadingCreateNewTrip(true);
    await FirebaseFirestore.instance.collection(FireStoreDocumentsKeysConstants.trips).add(
      {
        'driverId': Get.find<UserController>().user()?.id,
        'startingPoint': selectedStartingPoint?.toJson(),
        'arivalPoint': selectedArivalPoint?.toJson(),
        'startingDate': pickedStartingDate().toString(),
        'startingTime': '${pickedStartingTime().hour}:${pickedStartingTime().minute}',
        'description': descriptionController.text,
        'numberOfSeats': numberOfSeatsController.text,
        'price': priceController.text,
        'type': tripType(),
        'onlyWomen': isOnlyWomens(),
        'driver': Get.find<UserController>().user()?.toJson(),
        'isSeatsCompleted': false,
        'status': 'pending',
      },
    );
    isLoadingCreateNewTrip(false);
    Get.find<TripsManagementController>().getTrips();
    Get.back();
    ToastComponent().showToast(
      Get.context!,
      message: StringsAssetsConstants.tripCreatedSuccessMessage,
      type: ToastTypes.success,
    );
  }

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

  @override
  void onInit() {
    getStatesList();
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
