import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/components/buttons/primary_button_component.dart';
import 'package:urban_app/app/core/components/inputs/date_input_component.dart';
import 'package:urban_app/app/core/components/inputs/gender_selector_component.dart';
import 'package:urban_app/app/core/components/inputs/text_input_component.dart';
import 'package:urban_app/app/core/components/others/steper_component.dart';
import 'package:urban_app/app/core/constants/icons_assets_constants.dart';
import 'package:urban_app/app/core/constants/logos_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';
import 'package:urban_app/app/core/utils/validator_util.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: 1.sh,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              SvgPicture.asset(
                LogosAssetsConstants.urbanAppLogo,
                color: MainColors.primaryColor,
                width: 180.w,
              ),
              SizedBox(height: 30.h),
              Center(
                child: Text(
                  StringsAssetsConstants.signUp,
                  style: TextStyles.largeLabelTextStyle(context),
                ),
              ),
              SizedBox(height: 5.h),
              Center(
                child: Text(
                  StringsAssetsConstants.signUpDescription,
                  style: TextStyles.mediumBodyTextStyle(context),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30.h),
              Obx(() {
                return StepperComponent(
                  currentStep: controller.currentStep(),
                );
              }),
              SizedBox(height: 20.h),
              Expanded(
                child: PageView(
                  controller: controller.signUpPageController,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Form(
                          key: controller.signUpStep1FormKey,
                          child: Column(
                            children: [
                              SizedBox(height: 15.h),
                              TextInputComponent(
                                focusNode: controller.firstNameFocusNode,
                                nextNode: controller.lastNameFocusNode,
                                controller: controller.firstNameController,
                                label: StringsAssetsConstants.firstName,
                                isLabelOutside: true,
                                hint: StringsAssetsConstants.firstNameHint,
                                validate: (value) => ValidatorUtil.validName(value,
                                    customMessage: StringsAssetsConstants.firstNameValidation),
                              ),
                              SizedBox(height: 15.h),
                              TextInputComponent(
                                focusNode: controller.lastNameFocusNode,
                                nextNode: controller.birthdayFocusNode,
                                controller: controller.lastNameController,
                                label: StringsAssetsConstants.lastName,
                                isLabelOutside: true,
                                hint: StringsAssetsConstants.lastNameHint,
                                validate: (value) => ValidatorUtil.validName(value,
                                    customMessage: StringsAssetsConstants.lastNameValidation),
                              ),
                              SizedBox(height: 15.h),
                              Obx(() {
                                return DateInputComponent(
                                  focusNode: controller.birthdayFocusNode,
                                  textController: controller.birthdayController,
                                  label: StringsAssetsConstants.birthday,
                                  hint: StringsAssetsConstants.birthdayHint,
                                  isLabelOutside: true,
                                  selectedDate: controller.pickedBirthDay(),
                                  callBack: (selectedDate) => controller.pickedBirthDay(selectedDate),
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
                                      customMessage: StringsAssetsConstants.birthdayValidation),
                                );
                              }),
                              SizedBox(height: 30.h),
                              Obx(() {
                                return GenderSelectorComponent(
                                  selectedGender: controller.selectedGender(),
                                  onSelectGender: (gender) => controller.selectedGender(gender),
                                );
                              }),
                              SizedBox(height: 30.h),
                              Obx(() {
                                return PrimaryButtonComponent(
                                  onTap: () => controller.goToStep2(),
                                  text: StringsAssetsConstants.next,
                                  isLoading: controller.isLoadingSignUp(),
                                );
                              }),
                              SizedBox(height: 30.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Form(
                          key: controller.signUpStep2FormKey,
                          child: Column(
                            children: [
                              SizedBox(height: 15.h),
                              TextInputComponent(
                                focusNode: controller.carBrandNameFocusNode,
                                nextNode: controller.carModelNameFocusNode,
                                controller: controller.carBrandNameController,
                                label: StringsAssetsConstants.carBrandName,
                                isLabelOutside: true,
                                hint: StringsAssetsConstants.carBrandName,
                                validate: (value) => ValidatorUtil.validName(value,
                                    customMessage: StringsAssetsConstants.carBrandNameValidation),
                              ),
                              SizedBox(height: 15.h),
                              TextInputComponent(
                                focusNode: controller.carModelNameFocusNode,
                                nextNode: controller.carPlateFocusNode,
                                controller: controller.carModelNameController,
                                label: StringsAssetsConstants.carModelName,
                                isLabelOutside: true,
                                hint: StringsAssetsConstants.carModelName,
                                validate: (value) => ValidatorUtil.validName(value,
                                    customMessage: StringsAssetsConstants.carModelNameValidation),
                              ),
                              SizedBox(height: 15.h),
                              TextInputComponent(
                                focusNode: controller.carPlateFocusNode,
                                nextNode: controller.numberOfSeatsFocusNode,
                                controller: controller.carPlateController,
                                label: StringsAssetsConstants.carPlate,
                                isLabelOutside: true,
                                hint: StringsAssetsConstants.carPlate,
                                textInputType: TextInputType.number,
                                validate: (value) => ValidatorUtil.validNumber(value,
                                    customMessage: StringsAssetsConstants.carPlateValidation),
                              ),
                              SizedBox(height: 15.h),
                              TextInputComponent(
                                focusNode: controller.numberOfSeatsFocusNode,
                                controller: controller.numberOfSeatsController,
                                label: StringsAssetsConstants.numberOfSeats,
                                isLabelOutside: true,
                                hint: StringsAssetsConstants.numberOfSeats,
                                textInputType: TextInputType.number,
                                validate: (value) => ValidatorUtil.validNumber(value,
                                    customMessage: StringsAssetsConstants.numberOfSeatsValidation),
                              ),
                              SizedBox(height: 30.h),
                              Obx(() {
                                return PrimaryButtonComponent(
                                  onTap: () => controller.signUp(),
                                  text: StringsAssetsConstants.signUp,
                                  isLoading: controller.isLoadingSignUp(),
                                );
                              }),
                              SizedBox(height: 30.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
