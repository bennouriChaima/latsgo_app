import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/constants/images_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';
import 'package:urban_app/app/modules/user_controller.dart';
import 'package:urban_app/app/routes/app_pages.dart';

class UserAvatarComponent extends StatelessWidget {
  const UserAvatarComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.PROFILE),
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
                Get.find<UserController>().user()?.gender == 'male'
                    ? ImagesAssetsConstants.maleGenderImage
                    : ImagesAssetsConstants.femaleGenderImage,
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringsAssetsConstants.welcomeBack,
                  style: TextStyles.smallBodyTextStyle(context).copyWith(
                    color: MainColors.disableColor(context),
                  ),
                ),
                Text('${Get.find<UserController>().user()?.firstName} ${Get.find<UserController>().user()?.lastName}',
                    style: TextStyles.smallBodyTextStyle(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
