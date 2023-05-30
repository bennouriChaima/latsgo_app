import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/components/buttons/primary_button_component.dart';
import 'package:urban_app/app/core/components/inputs/date_input_component.dart';
import 'package:urban_app/app/core/components/inputs/text_input_component.dart';
import 'package:urban_app/app/core/components/inputs/time_input_component.dart';
import 'package:urban_app/app/core/components/others/dropdown_component.dart';
import 'package:urban_app/app/core/components/others/header_component.dart';
import 'package:urban_app/app/core/components/others/switch_component.dart';
import 'package:urban_app/app/core/constants/icons_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';
import 'package:urban_app/app/core/utils/validator_util.dart';
import 'package:urban_app/app/modules/driver_screens/create_new_trip/views/components/trip_type_selector_component.dart';

import '../controllers/create_new_trip_controller.dart';

class CreateNewTripView extends GetView<CreateNewTripController> {
  const CreateNewTripView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        title: StringsAssetsConstants.createNewTrip,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  Form(
                    key: controller.createNewTripFormFormKey,
                    child: Column(
                      children: [
                        Obx(() {
                          return DropDownComponent(
                            isLabelOutside: true,
                            width: double.infinity,
                            focusNode: controller.startingPointFocusNode,
                            nextNode: controller.arivalPointFocusNode,
                            label: StringsAssetsConstants.startingPoint,
                            hint: StringsAssetsConstants.startingPointHint,
                            changeSelectedItem: (util) => controller.selectStartingPoint(util),
                            selectedUtil: controller.selectedStartingPoint,
                            dataList: controller.statesList(),
                            validate: (value) => ValidatorUtil.validNullable(value,
                                customMessage: StringsAssetsConstants.startingPointValidation),
                          );
                        }),
                        Obx(() {
                          return DropDownComponent(
                            isLabelOutside: true,
                            width: double.infinity,
                            focusNode: controller.arivalPointFocusNode,
                            nextNode: controller.startingDateFocusNode,
                            label: StringsAssetsConstants.arivalPoint,
                            hint: StringsAssetsConstants.arivalPointHint,
                            changeSelectedItem: (util) => controller.selectArivalPoint(util),
                            selectedUtil: controller.selectedArivalPoint,
                            dataList: controller.statesList(),
                            validate: (value) => ValidatorUtil.validNullable(value,
                                customMessage: StringsAssetsConstants.arivalPointValidation),
                          );
                        }),
                        SizedBox(height: 10.h),
                        Obx(() {
                          return DateInputComponent(
                            focusNode: controller.startingDateFocusNode,
                            textController: controller.startingDateController,
                            label: StringsAssetsConstants.startingDate,
                            hint: StringsAssetsConstants.birthdayHint,
                            isLabelOutside: true,
                            selectedDate: controller.pickedStartingDate(),
                            callBack: (selectedDate) => controller.pickedStartingDate(selectedDate),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 30)),
                            suffix: Row(
                              children: [
                                SizedBox(width: 20.w),
                                SvgPicture.asset(
                                  IconsAssetsConstants.calenderIcon,
                                  color: MainColors.disableColor(context),
                                  width: 25.r,
                                ),
                                SizedBox(width: 20.w),
                              ],
                            ),
                            validate: (value) => ValidatorUtil.validEmpty(value,
                                customMessage: StringsAssetsConstants.startingDateValidation),
                          );
                        }),
                        SizedBox(height: 10.h),
                        Obx(() {
                          return TimeInputComponent(
                            focusNode: controller.startingTimeFocusNode,
                            textController: controller.startingTimeController,
                            label: StringsAssetsConstants.startingTime,
                            hint: StringsAssetsConstants.startingTimeHint,
                            isLabelOutside: true,
                            selectedTime: controller.pickedStartingTime(),
                            callBack: (selectedTime) => controller.pickedStartingTime(selectedTime),
                            suffix: Row(
                              children: [
                                SizedBox(width: 20.w),
                                SvgPicture.asset(
                                  IconsAssetsConstants.watchIcon,
                                  color: MainColors.disableColor(context),
                                  width: 25.r,
                                ),
                                SizedBox(width: 20.w),
                              ],
                            ),
                            validate: (value) => ValidatorUtil.validEmpty(value,
                                customMessage: StringsAssetsConstants.startingTimeValidation),
                          );
                        }),
                        SizedBox(height: 10.h),
                        TextInputComponent(
                          focusNode: controller.descriptionFocusNode,
                          nextNode: controller.numberOfSeatsFocusNode,
                          controller: controller.descriptionController,
                          label: StringsAssetsConstants.description,
                          isLabelOutside: true,
                          maxLines: 5,
                          hint: StringsAssetsConstants.descriptionHint,
                          textInputType: TextInputType.text,
                          validate: (value) => ValidatorUtil.validEmpty(value,
                              customMessage: StringsAssetsConstants.descriptionValidation),
                        ),
                        SizedBox(height: 15.h),
                        TextInputComponent(
                          focusNode: controller.numberOfSeatsFocusNode,
                          nextNode: controller.priceFocusNode,
                          controller: controller.numberOfSeatsController,
                          label: StringsAssetsConstants.numberOfSeats,
                          isLabelOutside: true,
                          hint: StringsAssetsConstants.numberOfSeatsHint,
                          textInputType: TextInputType.number,
                          validate: (value) => ValidatorUtil.validNumber(value,
                              customMessage: StringsAssetsConstants.numberOfSeatsValidation),
                        ),
                        SizedBox(height: 15.h),
                        TextInputComponent(
                          focusNode: controller.priceFocusNode,
                          controller: controller.priceController,
                          label: StringsAssetsConstants.price,
                          isLabelOutside: true,
                          hint: StringsAssetsConstants.priceHint,
                          textInputType: TextInputType.number,
                          validate: (value) =>
                              ValidatorUtil.validNumber(value, customMessage: StringsAssetsConstants.priceValidation),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Obx(() {
                    return TripTypeSelectorComponent(
                      type: controller.tripType(),
                      onSelect: (type) => controller.tripType(type),
                    );
                  }),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Obx(() {
                        return SwitchComponent(
                          enable: controller.isOnlyWomens(),
                          onChange: (value) => controller.isOnlyWomens(value),
                        );
                      }),
                      SizedBox(width: 10.w),
                      Text(
                        StringsAssetsConstants.onlyWomen,
                        style: TextStyles.mediumBodyTextStyle(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Obx(() {
                    return PrimaryButtonComponent(
                      onTap: () => controller.createNewTrip(),
                      text: StringsAssetsConstants.createNewTrip,
                      isLoading: controller.isLoadingCreateNewTrip(),
                    );
                  }),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
