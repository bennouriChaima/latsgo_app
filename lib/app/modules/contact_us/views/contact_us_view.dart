import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/components/buttons/primary_button_component.dart';
import 'package:urban_app/app/core/components/inputs/text_input_component.dart';
import 'package:urban_app/app/core/components/others/header_component.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/utils/validator_util.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        title: StringsAssetsConstants.contactUs,
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
                  SizedBox(height: 50.h),
                  Form(
                    key: controller.contactUsFormFormKey,
                    child: Column(
                      children: [
                        TextInputComponent(
                          controller: controller.subjectController,
                          focusNode: controller.subjectFocusNode,
                          nextNode: controller.messageFocusNode,
                          label: StringsAssetsConstants.subject,
                          isLabelOutside: true,
                          hint: '${StringsAssetsConstants.enter} ${StringsAssetsConstants.subject}',
                          validate: (value) => ValidatorUtil.validName(value),
                        ),
                        SizedBox(height: 15.h),
                        TextInputComponent(
                          controller: controller.messageController,
                          focusNode: controller.messageFocusNode,
                          label: StringsAssetsConstants.message,
                          isLabelOutside: true,
                          maxLines: 5,
                          hint: '${StringsAssetsConstants.enter} ${StringsAssetsConstants.message}',
                          validate: (value) => ValidatorUtil.validName(value),
                        ),
                        SizedBox(height: 300.h),
                        Obx(() {
                          return PrimaryButtonComponent(
                            onTap: () => controller.sendRequest(),
                            text: StringsAssetsConstants.send,
                            isLoading: controller.isLoadingSendRequest(),
                          );
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
