import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focused_menu_custom/focused_menu.dart';
import 'package:focused_menu_custom/modals.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:urban_app/app/core/components/buttons/icon_button_component.dart';
import 'package:urban_app/app/core/components/buttons/primary_button_component.dart';
import 'package:urban_app/app/core/components/others/user_avatar_component.dart';
import 'package:urban_app/app/core/constants/animations_assets_constants.dart';
import 'package:urban_app/app/core/constants/icons_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';
import 'package:urban_app/app/modules/passenger_screens/search/views/components/trip_card_component.dart';
import 'package:urban_app/app/routes/app_pages.dart';

import '../controllers/trips_management_controller.dart';

class TripsManagementView extends GetView<TripsManagementController> {
  const TripsManagementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserAvatarComponent(),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
                    child: SvgPicture.asset(
                      IconsAssetsConstants.notificationIcon,
                      color: MainColors.textColor(context),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: PrimaryButtonComponent(
                              text: StringsAssetsConstants.createNewTrip,
                              onTap: () => Get.toNamed(Routes.DRIVER_CREATE_NEW_TRIP),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          IconButtonComponent(
                            iconLink: IconsAssetsConstants.refreshIcon,
                            onTap: () => controller.getTrips(),
                            backgroundColor: MainColors.primaryColor,
                            iconColor: MainColors.whiteColor,
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      return (controller.isLoadingGetTrips())
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 40.h,
                                ),
                                LoadingAnimationWidget.staggeredDotsWave(
                                  color: MainColors.primaryColor,
                                  size: 80.r,
                                ),
                              ],
                            )
                          : (controller.tripsList.isEmpty)
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 40.h,
                                    ),
                                    Lottie.asset(AnimationsAssetsConstants.emptyAnimation, width: 300.r),
                                    Center(
                                      child: Text(
                                        StringsAssetsConstants.empty,
                                        style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                          color: MainColors.textColor(context)?.withOpacity(0.6),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.separated(
                                  padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return FocusedMenuHolder(
                                      enableMenuScroll: true,
                                      blurSize: 5.0.r,
                                      menuItemExtent: 45,
                                      menuBoxDecoration: BoxDecoration(
                                        color: MainColors.disableColor(context),
                                      ),
                                      duration: const Duration(milliseconds: 300),
                                      animateMenuItems: true,
                                      blurBackgroundColor: MainColors.blackColor,
                                      openWithTap: false,
                                      menuOffset: 10.0,
                                      bottomOffsetHeight: 80.0,
                                      menuItems: <FocusedMenuItem>[
                                        FocusedMenuItem(
                                          title: Text(
                                            StringsAssetsConstants.delete,
                                            style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                              color: MainColors.errorColor(context),
                                            ),
                                          ),
                                          trailingIcon: Icon(
                                            Icons.delete_outline,
                                            color: MainColors.errorColor(context),
                                          ),
                                          onPressed: () => controller.deleteTrip(controller.tripsList()[index].id),
                                        ),
                                        if (controller.tripsList()[index].status == 'pending')
                                          FocusedMenuItem(
                                            title: Text(
                                              StringsAssetsConstants.makeAsDone,
                                              style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                                color: MainColors.successColor(context),
                                              ),
                                            ),
                                            trailingIcon: Icon(
                                              Icons.check,
                                              color: MainColors.successColor(context),
                                            ),
                                            onPressed: () => controller.makeAsDone(controller.tripsList()[index].id),
                                          ),
                                      ],
                                      onPressed: () {},
                                      child: TripCardComponent(
                                        tripData: controller.tripsList()[index],
                                        showReservations: true,
                                        onAccept: controller.changeReservationStatus,
                                        onReject: controller.changeReservationStatus,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 25.h);
                                  },
                                  itemCount: controller.tripsList.length,
                                );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
