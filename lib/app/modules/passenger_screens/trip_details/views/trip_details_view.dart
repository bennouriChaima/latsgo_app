import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:urban_app/app/core/components/buttons/icon_button_component.dart';
import 'package:urban_app/app/core/components/buttons/primary_button_component.dart';
import 'package:urban_app/app/core/components/others/header_component.dart';
import 'package:urban_app/app/core/constants/icons_assets_constants.dart';
import 'package:urban_app/app/core/constants/images_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';

import '../controllers/trip_details_controller.dart';

class TripDetailsView extends GetView<TripDetailsController> {
  const TripDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderComponent(
          title: StringsAssetsConstants.tripDetails,
          isBack: true,
        ),
        body: SafeArea(
          child: SizedBox(
            child: Stack(
              children: [
                SizedBox(
                  width: 1.sw,
                  height: 0.8.sh,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng((controller.tripData().arivalPoint?.lat ?? 0) - 0.019,
                          controller.tripData().arivalPoint?.long ?? 0),
                      zoom: 13,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(controller.tripData().arivalPoint?.lat ?? 0,
                                controller.tripData().arivalPoint?.long ?? 0),
                            width: 90.r,
                            height: 90.r,
                            builder: (context) => Icon(
                              Icons.location_pin,
                              color: MainColors.primaryColor,
                              size: 60.r,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(25.r),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.r),
                        color: MainColors.backgroundColor(context),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, -10.h),
                            color: MainColors.blackColor.withOpacity(0.3),
                            blurRadius: 20.r,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60.r,
                                      width: 60.r,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: MainColors.primaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(1000.r),
                                        color: MainColors.backgroundColor(context),
                                      ),
                                      padding: EdgeInsets.all(3.r),
                                      child: SvgPicture.asset(
                                        controller.tripData().driver?.gender == 'male'
                                            ? ImagesAssetsConstants.maleGenderImage
                                            : ImagesAssetsConstants.femaleGenderImage,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${controller.tripData().driver?.firstName} ${controller.tripData().driver?.lastName}',
                                          style: TextStyles.smallBodyTextStyle(context),
                                        ),
                                        Text(
                                          '${controller.tripData().driver?.car?.brand} ${controller.tripData().driver?.car?.model}',
                                          style: TextStyles.smallBodyTextStyle(context).copyWith(
                                            color: MainColors.disableColor(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${controller.tripData().startingDate?.substring(0, 10)} ${controller.tripData().startingTime}',
                                      style: TextStyles.smallBodyTextStyle(context),
                                    ),
                                    if (controller.tripData().onlyWomen == true)
                                      Text(
                                        StringsAssetsConstants.onlyWomen,
                                        style: TextStyles.smallBodyTextStyle(context).copyWith(
                                          color: MainColors.primaryColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 15.r,
                                    width: 15.r,
                                    decoration: BoxDecoration(
                                      color: MainColors.primaryColor,
                                      borderRadius: BorderRadius.circular(1000.r),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    '${controller.tripData().staringPoint?.titleEn}',
                                    style: TextStyles.mediumBodyTextStyle(context),
                                  ),
                                ],
                              ),
                              SizedBox(width: 8.w),
                              const Expanded(
                                child: Divider(
                                  color: MainColors.primaryColor,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Row(
                                children: [
                                  Container(
                                    height: 15.r,
                                    width: 15.r,
                                    decoration: BoxDecoration(
                                      color: MainColors.primaryColor,
                                      borderRadius: BorderRadius.circular(1000.r),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    '${controller.tripData().arivalPoint?.titleEn}',
                                    style: TextStyles.mediumBodyTextStyle(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  AnimatedContainer(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                      color: MainColors.primaryColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    duration: const Duration(milliseconds: 300),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          controller.tripData().type == 'round'
                                              ? IconsAssetsConstants.roundIcon
                                              : IconsAssetsConstants.oneWayIcon,
                                          width: 15.r,
                                          color: MainColors.primaryColor,
                                        ),
                                        SizedBox(width: 10.r),
                                        Text(
                                          controller.tripData().type == 'round'
                                              ? StringsAssetsConstants.round
                                              : StringsAssetsConstants.oneWay,
                                          style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                            color: MainColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  AnimatedContainer(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                      color: MainColors.primaryColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    duration: const Duration(milliseconds: 300),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          IconsAssetsConstants.profileIcon,
                                          width: 15.r,
                                          color: MainColors.primaryColor,
                                        ),
                                        SizedBox(width: 5.r),
                                        Text(
                                          '${(controller.tripData().numberOfSeats ?? 0) - (controller.tripData().reservedSeats ?? 0)}  ${StringsAssetsConstants.passengers}',
                                          style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                            color: MainColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${controller.tripData().price} ${StringsAssetsConstants.currency}',
                                style: TextStyles.largeBodyTextStyle(context).copyWith(
                                  color: MainColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return PrimaryButtonComponent(
                                    text: StringsAssetsConstants.book,
                                    onTap: () => controller.booking(),
                                    isLoading: controller.isLoadingBooking(),
                                  );
                                }),
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButtonComponent(
                                        iconLink: IconsAssetsConstants.addIcon,
                                        onTap: () => controller.addNumberOfSeats(),
                                        backgroundColor: MainColors.primaryColor,
                                        iconColor: MainColors.whiteColor,
                                      ),
                                      Obx(() {
                                        return Text(
                                          '${controller.numberOfSeats()}',
                                          style: TextStyles.mediumLabelTextStyle(context),
                                        );
                                      }),
                                      IconButtonComponent(
                                        iconLink: IconsAssetsConstants.minusIcon,
                                        onTap: () => controller.minusNumberOfSeats(),
                                        backgroundColor: MainColors.primaryColor.withOpacity(0.2),
                                        iconColor: MainColors.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
