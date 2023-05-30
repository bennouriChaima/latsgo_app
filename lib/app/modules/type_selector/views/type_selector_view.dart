import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/components/buttons/primary_button_component.dart';
import 'package:urban_app/app/core/constants/logos_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';
import 'package:urban_app/app/modules/type_selector/views/components/type_selector_component.dart';
import 'package:urban_app/app/routes/app_pages.dart';

import '../controllers/type_selector_controller.dart';

class TypeSelectorView extends GetView<TypeSelectorController> {
  const TypeSelectorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                LogosAssetsConstants.urbanAppLogo,
                color: MainColors.primaryColor,
                width: 180.w,
              ),
              Column(
                children: [
                  Center(
                    child: Text(
                      StringsAssetsConstants.pleaseSelectATypeOfService,
                      style: TextStyles.largeBodyTextStyle(context),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Obx(() {
                    return TypeSelectorComponent(
                      onSelect: () => controller.selectedType('passenger'),
                      title: StringsAssetsConstants.passenger,
                      isSelected: controller.selectedType() == 'passenger',
                    );
                  }),
                  SizedBox(height: 10.h),
                  Obx(() {
                    return TypeSelectorComponent(
                      onSelect: () => controller.selectedType('driver'),
                      title: StringsAssetsConstants.driver,
                      isSelected: controller.selectedType() == 'driver',
                    );
                  }),
                ],
              ),
              PrimaryButtonComponent(
                onTap: () => Get.toNamed(Routes.SIGN_IN, arguments: [
                  {
                    'type': controller.selectedType(),
                  },
                ]),
                text: StringsAssetsConstants.next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
