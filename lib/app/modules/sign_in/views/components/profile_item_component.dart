import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/constants/icons_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';

class ProfileItemComponent extends StatelessWidget {
  const ProfileItemComponent(
      {Key? key,
      required this.title,
      required this.iconPath,
      required this.onTap,
      this.backgroundColor,
      this.hideArrow})
      : super(key: key);

  final String title;
  final String iconPath;
  final Function onTap;
  final Color? backgroundColor;
  final bool? hideArrow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 70.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ?? MainColors.primaryColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 25.r,
              color: MainColors.whiteColor,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style: TextStyles.mediumBodyTextStyle(context).copyWith(
                  color: MainColors.whiteColor,
                ),
              ),
            ),
            if (hideArrow != true)
              SvgPicture.asset(
                Get.locale?.languageCode == 'ar'
                    ? IconsAssetsConstants.arrowLeftIcon
                    : IconsAssetsConstants.arrowRightIcon,
                width: 25.r,
                color: MainColors.whiteColor,
              ),
          ],
        ),
      ),
    );
  }
}
