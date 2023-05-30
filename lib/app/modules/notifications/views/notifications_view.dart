import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:urban_app/app/core/components/others/header_component.dart';
import 'package:urban_app/app/core/constants/animations_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';
import 'package:urban_app/app/modules/notifications/views/components/notification_card_component.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        isBack: true,
        title: StringsAssetsConstants.notifications,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(() {
              return (controller.isLoadingGetNotifications())
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
                  : (controller.notificationsList.isEmpty)
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
                            return NotificationCardComponent(
                              notificationData: controller.notificationsList[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 15.h);
                          },
                          itemCount: controller.notificationsList.length,
                        );
            }),
          ),
        ),
      ),
    );
  }
}
