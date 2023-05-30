import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:urban_app/app/core/components/others/header_component.dart';
import 'package:urban_app/app/core/constants/logos_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';

import '../../../core/components/buttons/primary_button_component.dart';
import '../controllers/otp_confirmation_controller.dart';

class OtpConfirmationView extends GetView<OtpConfirmationController> {
  const OtpConfirmationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderComponent(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 25.h),
                  SvgPicture.asset(
                    LogosAssetsConstants.urbanAppLogo,
                    color: MainColors.primaryColor,
                    width: 300.w,
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: Text(
                      StringsAssetsConstants.otpConfirmation,
                      style: TextStyles.largeLabelTextStyle(context),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: '${StringsAssetsConstants.otpConfirmationDescription} ',
                        style: TextStyles.mediumBodyTextStyle(context),
                        children: <TextSpan>[
                          TextSpan(
                            text: '(${controller.phoneNumber})',
                            style: TextStyles.mediumBodyTextStyle(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8.r),
                        fieldHeight: 75.h,
                        fieldWidth: 48.w,
                        borderWidth: 1,
                        activeColor: MainColors.primaryColor,
                        disabledColor: MainColors.disableColor(context),
                        selectedFillColor: MainColors.inputColor(context),
                        activeFillColor: MainColors.backgroundColor(context),
                        errorBorderColor: MainColors.errorColor(context),
                        inactiveColor: MainColors.disableColor(context),
                        inactiveFillColor: MainColors.inputColor(context),
                        selectedColor: MainColors.primaryColor,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: MainColors.transparentColor,
                      cursorColor: MainColors.primaryColor,
                      enableActiveFill: true,
                      textStyle: TextStyles.mediumBodyTextStyle(context),
                      keyboardType: TextInputType.number,
                      enablePinAutofill: true,
                      controller: controller.pinController,
                      errorAnimationController: controller.otpErrorController,
                      onCompleted: (v) {},
                      onChanged: (value) {},
                      beforeTextPaste: (text) => true,
                      appContext: context,
                    ),
                  ),
                  SizedBox(height: 90.h),
                  Obx(
                    () {
                      return Center(
                        child: (!controller.isAllowedToResendOtp())
                            ? CustomTimer(
                                controller: controller.timerController,
                                begin: const Duration(seconds: 30),
                                end: const Duration(),
                                onChangeState: (status) {
                                  if (status == CustomTimerState.finished) {
                                    controller.isAllowedToResendOtp(true);
                                  }
                                },
                                builder: (time) {
                                  return RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: '${StringsAssetsConstants.otpConfirmationResendDescription} ',
                                      style: TextStyles.smallBodyTextStyle(context),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: (int.parse(time.seconds) > 9)
                                              ? time.seconds
                                              : time.seconds.replaceFirst('0', ''),
                                          style: TextStyles.smallBodyTextStyle(context).copyWith(
                                            color: MainColors.primaryColor,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' ${StringsAssetsConstants.second}',
                                          style: TextStyles.smallBodyTextStyle(context),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : (!controller.isLoadingResendOtp())
                                ? InkWell(
                                    onTap: () => controller.resendOtp(),
                                    child: Text(
                                      StringsAssetsConstants.resend,
                                      style: TextStyles.smallBodyTextStyle(context).copyWith(
                                        color: MainColors.primaryColor,
                                      ),
                                    ),
                                  )
                                : LoadingAnimationWidget.inkDrop(
                                    color: MainColors.primaryColor,
                                    size: 30.r,
                                  ),
                      );
                    },
                  ),
                  SizedBox(height: 220.h),
                  Obx(() {
                    return PrimaryButtonComponent(
                      onTap: () => controller.verifyOtp(),
                      text: StringsAssetsConstants.confirm,
                      isLoading: controller.isLoadingVerifyOtp(),
                    );
                  }),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
