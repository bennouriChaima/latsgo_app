import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/components/others/header_component.dart';
import 'package:urban_app/app/core/constants/icons_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';
import 'package:urban_app/app/modules/sign_in/views/components/profile_item_component.dart';
import 'package:urban_app/app/modules/sign_in/views/components/user_avatar_component.dart';
import 'package:urban_app/app/modules/user_controller.dart';
import 'package:urban_app/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderComponent(
        backgroundColor: MainColors.primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MainColors.primaryColor,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30.r), bottomRight: Radius.circular(30.r)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Obx(() {
                        return UserAvatarComponent(
                          gender: Get.find<UserController>().user()?.gender ?? 'male',
                        );
                      }),
                      SizedBox(height: 15.h),
                      Obx(() {
                        return Center(
                          child: Text(
                            '${Get.find<UserController>().user()?.firstName} ${Get.find<UserController>().user()?.lastName}',
                            style: TextStyles.mediumLabelTextStyle(context).copyWith(
                              color: MainColors.whiteColor,
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 5.h),
                      Obx(() {
                        return Center(
                          child: Text(
                            Get.find<UserController>().user()?.phone ?? '/',
                            style: TextStyles.mediumBodyTextStyle(context).copyWith(
                              color: MainColors.whiteColor,
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    children: [
                      ProfileItemComponent(
                        title: StringsAssetsConstants.editProfile,
                        iconPath: IconsAssetsConstants.profileIcon,
                        onTap: () {},
                      ),
                      if (Get.find<UserController>().user()?.type == 'passenger') SizedBox(height: 15.h),
                      if (Get.find<UserController>().user()?.type == 'passenger')
                        ProfileItemComponent(
                          title: StringsAssetsConstants.myTrips,
                          iconPath: IconsAssetsConstants.ticketIcon,
                          onTap: () => Get.toNamed(Routes.PASSENGER_MY_TRIPS),
                        ),
                      SizedBox(height: 15.h),
                      ProfileItemComponent(
                        title: StringsAssetsConstants.contactUs,
                        iconPath: IconsAssetsConstants.contactusIcon,
                        onTap: () => Get.toNamed(Routes.CONTACT_US),
                      ),
                      SizedBox(height: 15.h),
                      ProfileItemComponent(
                        title: StringsAssetsConstants.whoWeAre,
                        iconPath: IconsAssetsConstants.faqIcon,
                        onTap: () => Get.toNamed(Routes.ABOUT),
                      ),
                      SizedBox(height: 190.h),
                      ProfileItemComponent(
                        title: StringsAssetsConstants.signOut,
                        iconPath: IconsAssetsConstants.signoutIcon,
                        onTap: () => Get.find<UserController>().clearUser(),
                        hideArrow: true,
                        backgroundColor: MainColors.errorColor(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
