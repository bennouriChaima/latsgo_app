import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/components/others/header_component.dart';
import 'package:urban_app/app/core/constants/logos_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderComponent(
          title: StringsAssetsConstants.whoWeAre,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  SvgPicture.asset(
                    LogosAssetsConstants.urbanAppLogo,
                    color: MainColors.primaryColor,
                  ),
                  SizedBox(height: 30.h),
                  Obx(() {
                    return Center(
                      child: Text(
                        controller.aboutText(),
                        style: TextStyles.largeBodyTextStyle(context),
                        textAlign: TextAlign.justify,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ));
  }
}
