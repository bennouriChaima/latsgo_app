import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:urban_app/app/core/constants/images_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';

class UserAvatarComponent extends StatelessWidget {
  const UserAvatarComponent({Key? key, required this.gender}) : super(key: key);

  final String gender;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.r,
      width: 140.r,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1000.r),
        child: Container(
          color: MainColors.whiteColor,
          padding: EdgeInsets.all(10.r),
          child: SvgPicture.asset(
            gender == 'male' ? ImagesAssetsConstants.maleGenderImage : ImagesAssetsConstants.femaleGenderImage,
          ),
        ),
      ),
    );
  }
}
