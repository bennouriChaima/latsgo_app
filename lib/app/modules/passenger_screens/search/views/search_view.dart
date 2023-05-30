import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:urban_app/app/core/components/buttons/primary_button_component.dart';
import 'package:urban_app/app/core/components/others/dropdown_component.dart';
import 'package:urban_app/app/core/components/others/user_avatar_component.dart';
import 'package:urban_app/app/core/constants/animations_assets_constants.dart';
import 'package:urban_app/app/core/constants/icons_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/modules/passenger_screens/search/views/components/trip_card_component.dart';
import 'package:urban_app/app/routes/app_pages.dart';

import '../../../../core/styles/text_styles.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        decoration: BoxDecoration(
                          color: MainColors.disableColor(context)?.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() {
                              return DropDownComponent(
                                isLabelOutside: true,
                                width: double.infinity,
                                focusNode: controller.startingPointFocusNode,
                                nextNode: controller.arivalPointFocusNode,
                                label: StringsAssetsConstants.startingPoint,
                                hint: StringsAssetsConstants.startingPointHint,
                                changeSelectedItem: (util) => controller.selectStartingPoint(util),
                                selectedUtil: controller.selectedStartingPoint,
                                dataList: controller.statesList(),
                                backgroundColor: MainColors.backgroundColor(context),
                              );
                            }),
                            Obx(() {
                              return DropDownComponent(
                                isLabelOutside: true,
                                width: double.infinity,
                                focusNode: controller.arivalPointFocusNode,
                                label: StringsAssetsConstants.arivalPoint,
                                hint: StringsAssetsConstants.arivalPointHint,
                                changeSelectedItem: (util) => controller.selectArivalPoint(util),
                                selectedUtil: controller.selectedArivalPoint,
                                dataList: controller.statesList(),
                                backgroundColor: MainColors.backgroundColor(context),
                              );
                            }),
                            SizedBox(height: 10.h),
                            PrimaryButtonComponent(
                              onTap: () => controller.getTripsSearch(),
                              text: StringsAssetsConstants.search,
                            ),
                            SizedBox(height: 10.h),
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
                                      return TripCardComponent(
                                        tripData: controller.tripsList()[index],
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
      ),
    );
  }
}
