import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:urban_app/app/core/constants/icons_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';

import '../../../../models/notification_model.dart';

class NotificationCardComponent extends StatelessWidget {
  const NotificationCardComponent({Key? key, this.notificationData}) : super(key: key);

  final NotificationModel? notificationData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!,
            blurRadius: 20.r,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 15.r),
      child: Row(
        children: [
          Container(
            height: 60.r,
            width: 60.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000.r),
              color: MainColors.primaryColor,
            ),
            child: Center(
              child: SvgPicture.asset(
                IconsAssetsConstants.notificationIcon,
                color: MainColors.whiteColor,
              ),
            ),
          ),
          SizedBox(width: 15.r),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${notificationData?.title}',
                        style: TextStyles.mediumBodyTextStyle(context).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${notificationData?.body}',
                        style: TextStyles.smallBodyTextStyle(context),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        '${notificationData?.date?.substring(0, 16)}',
                        style: TextStyles.smallBodyTextStyle(context).copyWith(
                          color: MainColors.textColor(context)?.withOpacity(0.6),
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
