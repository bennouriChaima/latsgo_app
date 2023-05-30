import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/constants/logos_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.primaryColor,
      body: Center(
        child: SvgPicture.asset(
          LogosAssetsConstants.urbanAppLogo,
          color: MainColors.whiteColor,
          width: 300.w,
        ),
      ),
    );
  }
}
