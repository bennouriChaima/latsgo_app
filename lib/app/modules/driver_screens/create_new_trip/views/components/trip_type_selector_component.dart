import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:urban_app/app/core/constants/icons_assets_constants.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';

class TripTypeSelectorComponent extends StatelessWidget {
  const TripTypeSelectorComponent({Key? key, required this.type, required this.onSelect}) : super(key: key);

  final String type;
  final Function(String type) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.h,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        border: Border.all(
          color: MainColors.disableColor(context)!,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onSelect('round'),
              child: AnimatedContainer(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: type == 'round' ? MainColors.primaryColor : MainColors.primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                duration: const Duration(milliseconds: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconsAssetsConstants.roundIcon,
                      width: 15.r,
                      color: type == 'round' ? MainColors.whiteColor : MainColors.primaryColor,
                    ),
                    SizedBox(width: 10.r),
                    Text(
                      StringsAssetsConstants.round,
                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                        color: type == 'round' ? MainColors.whiteColor : MainColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 8.r),
          Expanded(
            child: GestureDetector(
              onTap: () => onSelect('oneWay'),
              child: AnimatedContainer(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: type == 'oneWay' ? MainColors.primaryColor : MainColors.primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                duration: const Duration(milliseconds: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconsAssetsConstants.oneWayIcon,
                      width: 15.r,
                      color: type == 'oneWay' ? MainColors.whiteColor : MainColors.primaryColor,
                    ),
                    SizedBox(width: 10.r),
                    Text(
                      StringsAssetsConstants.oneWay,
                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                        color: type == 'oneWay' ? MainColors.whiteColor : MainColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
