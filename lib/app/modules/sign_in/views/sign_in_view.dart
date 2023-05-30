import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/components/buttons/primary_button_component.dart';
import 'package:urban_app/app/core/components/inputs/text_input_component.dart';
import 'package:urban_app/app/core/components/others/header_component.dart';
import 'package:urban_app/app/core/constants/logos_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';
import 'package:urban_app/app/core/utils/validator_util.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderComponent(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
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
                      StringsAssetsConstants.signIn,
                      style: TextStyles.largeLabelTextStyle(context),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Center(
                    child: Text(
                      StringsAssetsConstants.signInDescription,
                      style: TextStyles.mediumBodyTextStyle(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Form(
                      key: controller.signInFormKey,
                      child: TextInputComponent(
                        focusNode: controller.phoneNumberFocusNode,
                        controller: controller.phoneNumberController,
                        textInputType: TextInputType.number,
                        maxLength: 9,
                        prefix: Row(
                          children: [
                            SizedBox(width: 20.w),
                            Text(
                              controller.countryCode,
                              style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                color: MainColors.primaryColor,
                              ),
                            ),
                            SizedBox(width: 10.w),
                          ],
                        ),
                        validate: (value) => ValidatorUtil.validPhone(value,
                            customMessage: StringsAssetsConstants.phoneNumberValidation),
                      ),
                    ),
                  ),
                  SizedBox(height: 360.h),
                  Obx(() {
                    return PrimaryButtonComponent(
                      onTap: () => controller.sendOtp(),
                      text: StringsAssetsConstants.signIn,
                      isLoading: controller.isLoadingSignIn(),
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
