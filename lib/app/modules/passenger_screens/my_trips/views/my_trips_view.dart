import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu_custom/focused_menu.dart';
import 'package:focused_menu_custom/modals.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:urban_app/app/core/components/inputs/text_input_component.dart';
import 'package:urban_app/app/core/components/others/header_component.dart';
import 'package:urban_app/app/core/constants/animations_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';
import 'package:urban_app/app/models/trip_model.dart';
import 'package:urban_app/app/modules/passenger_screens/search/views/components/trip_card_component.dart';
import 'package:urban_app/app/modules/user_controller.dart';

import '../../../../core/components/buttons/primary_button_component.dart';
import '../../../../core/components/others/bottom_sheet_component.dart';
import '../controllers/my_trips_controller.dart';

class MyTripsView extends GetView<MyTripsController> {
  const MyTripsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderComponent(
          title: StringsAssetsConstants.myTrips,
          isBack: true,
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Obx(() {
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
                          physics: const BouncingScrollPhysics(),
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
                                if (controller
                                        .tripsList()[index]
                                        .reservations?[controller.tripsList()[index].reservations?.indexWhere(
                                                (element) =>
                                                    element.passenger?.id == Get.find<UserController>().user()?.id) ??
                                            0]
                                        .status ==
                                    'pending')
                                  FocusedMenuItem(
                                    title: Text(
                                      StringsAssetsConstants.cancel,
                                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                        color: MainColors.errorColor(context),
                                      ),
                                    ),
                                    trailingIcon: Icon(
                                      Icons.close,
                                      color: MainColors.errorColor(context),
                                    ),
                                    onPressed: () {
                                      controller.cancelTrip(
                                          controller.tripsList()[index],
                                          controller
                                              .tripsList()[index]
                                              .reservations?[controller.tripsList()[index].reservations?.indexWhere(
                                                      (element) =>
                                                          element.passenger?.id ==
                                                          Get.find<UserController>().user()?.id) ??
                                                  0]
                                              .id);
                                    },
                                  ),
                                if (controller.tripsList()[index].status == 'done')
                                  FocusedMenuItem(
                                    title: Text(
                                      StringsAssetsConstants.rate,
                                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                        color: MainColors.warningColor(context),
                                      ),
                                    ),
                                    trailingIcon: Icon(
                                      Icons.star_outline,
                                      color: MainColors.warningColor(context),
                                    ),
                                    onPressed: () => showRatingWindow(controller.tripsList()[index]),
                                  )
                              ],
                              onPressed: () {},
                              child: TripCardComponent(
                                showStatus: true,
                                tripData: controller.tripsList()[index],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 25.h);
                          },
                          itemCount: controller.tripsList.length,
                        );
            }),
          ),
        ));
  }

  void showRatingWindow(TripModel tripData) {
    BottomSheetComponent().show(
      Get.context!,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: MainColors.backgroundColor(Get.context!),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h),
            Center(
              child: Text(
                '${StringsAssetsConstants.rateDriver}: ${tripData.driver?.firstName} ${tripData.driver?.lastName}',
                style: TextStyles.mediumBodyTextStyle(Get.context!),
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h),
            Obx(() {
              return RatingBar.builder(
                initialRating: controller.rateValue(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30.r,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: MainColors.warningColor(context),
                  size: 25.r,
                ),
                onRatingUpdate: (rating) => controller.rateValue(rating),
              );
            }),
            SizedBox(height: 20.h),
            TextInputComponent(
              controller: controller.noteController,
              focusNode: controller.noteFocusNode,
              hint: '${StringsAssetsConstants.note}...',
              maxLength: 300,
              maxLines: 3,
            ),
            SizedBox(height: 10.h),
            PrimaryButtonComponent(
              text: StringsAssetsConstants.rate,
              onTap: () => controller.rateDriver(tripData?.driver?.id),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
