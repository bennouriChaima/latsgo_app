import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/constants/icons_assets_constants.dart';
import 'package:urban_app/app/core/constants/images_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';
import 'package:urban_app/app/models/trip_model.dart';
import 'package:urban_app/app/modules/user_controller.dart';
import 'package:urban_app/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../../core/components/buttons/primary_button_component.dart';

class TripCardComponent extends StatelessWidget {
  const TripCardComponent(
      {Key? key, required this.tripData, this.showReservations, this.onAccept, this.onReject, this.showStatus})
      : super(key: key);

  final TripModel tripData;
  final bool? showReservations;
  final Function(String tripId, String reservationId, String status)? onAccept;
  final Function(String tripId, String reservationId, String status)? onReject;
  final bool? showStatus;

  @override
  Widget build(BuildContext context) {
    String? status;
    String? reservationStatus;
    if (showStatus == true) {
      reservationStatus = tripData
              .reservations?[tripData.reservations
                      ?.indexWhere((element) => element.passenger?.id == Get.find<UserController>().user()?.id) ??
                  0]
              .status ??
          'pending';
      status = reservationStatus == 'pending'
          ? StringsAssetsConstants.pending
          : reservationStatus == 'completed'
              ? StringsAssetsConstants.completed
              : reservationStatus == 'rejected'
                  ? StringsAssetsConstants.rejected
                  : reservationStatus == 'canceled'
                      ? StringsAssetsConstants.canceled
                      : StringsAssetsConstants.accepted;
    }

    return GestureDetector(
      onTap: () {
        if (showReservations != true && showStatus != true) {
          Get.toNamed(Routes.PASSENGER_TRIP_DETAILS, arguments: [
            {'trip': tripData}
          ]);
        }
      },
      child: Container(
        padding: EdgeInsets.all(15.r),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: MainColors.primaryColor, width: 2.r),
          color: MainColors.backgroundColor(context),
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
                          tripData.driver?.gender == 'male'
                              ? ImagesAssetsConstants.maleGenderImage
                              : ImagesAssetsConstants.femaleGenderImage,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${tripData.driver?.firstName} ${tripData.driver?.lastName}',
                            style: TextStyles.smallBodyTextStyle(context),
                          ),
                          Text(
                            '${tripData.driver?.car?.brand} ${tripData.driver?.car?.model}',
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
                        '${tripData.startingDate?.substring(0, 10)} ${tripData.startingTime}',
                        style: TextStyles.smallBodyTextStyle(context),
                      ),
                      if (tripData.onlyWomen == true)
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
                      '${tripData.staringPoint?.titleEn}',
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
                      '${tripData.arivalPoint?.titleEn}',
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
                    if (showStatus != true)
                      AnimatedContainer(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: MainColors.primaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        duration: const Duration(milliseconds: 300),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              tripData.type == 'round'
                                  ? IconsAssetsConstants.roundIcon
                                  : IconsAssetsConstants.oneWayIcon,
                              width: 15.r,
                              color: MainColors.primaryColor,
                            ),
                            SizedBox(width: 10.r),
                            Text(
                              tripData.type == 'round' ? StringsAssetsConstants.round : StringsAssetsConstants.oneWay,
                              style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                color: MainColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (showStatus != true) SizedBox(width: 8.w),
                    if (showStatus != true)
                      AnimatedContainer(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
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
                            SizedBox(width: 10.r),
                            Text(
                              '${(tripData.numberOfSeats ?? 0) - (tripData.reservedSeats ?? 0)}  ${StringsAssetsConstants.passengers}',
                              style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                color: MainColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (showStatus == true)
                      AnimatedContainer(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: MainColors.primaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        duration: const Duration(milliseconds: 300),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${StringsAssetsConstants.numberOfSeats}: ${tripData.reservations?[tripData.reservations?.indexWhere((element) => element.passenger?.id == Get.find<UserController>().user()?.id) ?? 0].reservedSeats}',
                              style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                color: MainColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (showStatus == true) SizedBox(width: 8.w),
                    if (showStatus == true)
                      AnimatedContainer(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: reservationStatus == 'pending'
                              ? MainColors.warningColor(context)?.withOpacity(0.3)
                              : reservationStatus == 'accepted'
                                  ? MainColors.infoColor(context)?.withOpacity(0.3)
                                  : reservationStatus == 'completed'
                                      ? MainColors.successColor(context)?.withOpacity(0.3)
                                      : MainColors.errorColor(context)?.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        duration: const Duration(milliseconds: 300),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$status',
                              style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                  color: reservationStatus == 'pending'
                                      ? MainColors.warningColor(context)
                                      : reservationStatus == 'accepted'
                                          ? MainColors.infoColor(context)
                                          : reservationStatus == 'completed'
                                              ? MainColors.successColor(context)
                                              : MainColors.errorColor(context)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Text(
                  '${tripData.price} ${StringsAssetsConstants.currency}',
                  style: TextStyles.largeBodyTextStyle(context).copyWith(
                    color: MainColors.primaryColor,
                  ),
                ),
              ],
            ),
            if (showReservations == true)
              ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 15.h),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return (tripData.reservations?[index].status != 'rejected')
                      ? Container(
                          padding: EdgeInsets.all(15.r),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: MainColors.primaryColor, width: 2.r),
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
                                          height: 40.r,
                                          width: 40.r,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: MainColors.primaryColor,
                                            ),
                                            borderRadius: BorderRadius.circular(1000.r),
                                            color: MainColors.backgroundColor(context),
                                          ),
                                          padding: EdgeInsets.all(3.r),
                                          child: SvgPicture.asset(
                                            tripData.reservations?[index].passenger?.gender == 'male'
                                                ? ImagesAssetsConstants.maleGenderImage
                                                : ImagesAssetsConstants.femaleGenderImage,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${tripData.reservations?[index].passenger?.firstName} ${tripData.reservations?[index].passenger?.lastName} (${tripData.reservations?[index].totalPrice} ${StringsAssetsConstants.currency})',
                                                  style: TextStyles.smallBodyTextStyle(context),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '${tripData.reservations?[index].date?.substring(0, 16)}',
                                              style: TextStyles.smallBodyTextStyle(context).copyWith(
                                                color: MainColors.disableColor(context),
                                              ),
                                            ),
                                            Text(
                                              '${(tripData.reservations?[index].reservedSeats ?? 0)}  ${StringsAssetsConstants.passengers}',
                                              style: TextStyles.smallBodyTextStyle(context).copyWith(
                                                color: MainColors.primaryColor.withOpacity(0.7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimaryButtonComponent(
                                      onTap: () =>
                                          UrlLauncher.launch("tel://${tripData.reservations?[index].passenger?.phone}"),
                                      text: StringsAssetsConstants.call,
                                      backgroundColor: MainColors.infoColor(context),
                                    ),
                                  ),
                                  if (tripData.reservations?[index].status == 'pending') SizedBox(width: 6.w),
                                  if (tripData.reservations?[index].status == 'pending')
                                    Expanded(
                                      child: PrimaryButtonComponent(
                                        onTap: () =>
                                            onAccept!(tripData.id!, tripData.reservations![index].id!, 'accepted'),
                                        text: StringsAssetsConstants.accept,
                                        backgroundColor: MainColors.successColor(context),
                                      ),
                                    ),
                                  if (tripData.reservations?[index].status == 'pending') SizedBox(width: 6.w),
                                  if (tripData.reservations?[index].status == 'pending')
                                    Expanded(
                                      child: PrimaryButtonComponent(
                                        onTap: () =>
                                            onReject!(tripData.id!, tripData.reservations![index].id!, 'rejected'),
                                        text: StringsAssetsConstants.reject,
                                        backgroundColor: MainColors.errorColor(context),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : const SizedBox();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10.h,
                  );
                },
                itemCount: tripData.reservations?.length ?? 0,
              ),
          ],
        ),
      ),
    );
  }
}
