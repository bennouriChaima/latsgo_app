import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:urban_app/app/core/constants/icons_assets_constants.dart';
import 'package:urban_app/app/core/constants/images_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';

class GenderSelectorComponent extends StatelessWidget {
  const GenderSelectorComponent({Key? key, required this.selectedGender, required this.onSelectGender})
      : super(key: key);

  final String selectedGender;
  final Function(String gender) onSelectGender;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Center(
            child: Text(
              StringsAssetsConstants.gender,
              style: TextStyles.smallLabelTextStyle(context),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: const Divider(),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 180.r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => onSelectGender(GenderTypes.male.toString().replaceAll('GenderTypes.', '')),
                  child: SelectorGenderItemComponent(
                    selectedGender: selectedGender,
                    genderType: GenderTypes.male,
                  ),
                ),
                SizedBox(width: 20.w),
                GestureDetector(
                  onTap: () => onSelectGender(GenderTypes.female.toString().replaceAll('GenderTypes.', '')),
                  child: SelectorGenderItemComponent(
                    selectedGender: selectedGender,
                    genderType: GenderTypes.female,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelectorGenderItemComponent extends StatelessWidget {
  const SelectorGenderItemComponent({Key? key, required this.selectedGender, required this.genderType})
      : super(key: key);

  final String selectedGender;
  final GenderTypes genderType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: (genderType.toString().replaceAll('GenderTypes.', '') == selectedGender) ? 160.r : 130.r,
          width: (genderType.toString().replaceAll('GenderTypes.', '') == selectedGender) ? 160.r : 130.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: (genderType.toString().replaceAll('GenderTypes.', '') == selectedGender)
                ? MainColors.primaryGradientColor
                : null,
            border: Border.all(
              color: !(genderType.toString().replaceAll('GenderTypes.', '') == selectedGender)
                  ? MainColors.disableColor(context)!
                  : MainColors.transparentColor,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              (genderType == GenderTypes.male)
                  ? ImagesAssetsConstants.maleGenderImage
                  : ImagesAssetsConstants.femaleGenderImage,
              width: (genderType.toString().replaceAll('GenderTypes.', '') == selectedGender) ? 100.r : 70.r,
            ),
          ),
        ),
        if ((genderType.toString().replaceAll('GenderTypes.', '') == selectedGender))
          SizedBox(
            width: 170.r,
            height: 170.r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 30.r,
                  width: 30.r,
                  padding: EdgeInsets.all(2.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000.r),
                    border: Border.all(
                      color: MainColors.whiteColor,
                      width: 2.r,
                    ),
                    color: MainColors.primaryColor,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      IconsAssetsConstants.checkIcon,
                      color: MainColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

enum GenderTypes {
  female,
  male,
}
