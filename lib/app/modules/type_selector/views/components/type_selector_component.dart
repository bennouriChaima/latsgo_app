import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:urban_app/app/core/constants/icons_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';

class TypeSelectorComponent extends StatelessWidget {
  const TypeSelectorComponent({Key? key, required this.title, required this.onSelect, required this.isSelected})
      : super(key: key);

  final String title;
  final Function onSelect;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.all(10.r),
            width: double.infinity,
            height: 70.h,
            decoration: BoxDecoration(
                color: !isSelected ? MainColors.backgroundColor(context) : MainColors.primaryColor,
                border: Border.all(color: !isSelected ? MainColors.primaryColor : MainColors.transparentColor),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 20.h),
                    spreadRadius: 0,
                    color: MainColors.shadowColor(context)!,
                    blurRadius: 30.r,
                  ),
                ]),
            child: Center(
              child: Text(
                title,
                style: TextStyles.mediumBodyTextStyle(context).copyWith(
                  color: isSelected ? MainColors.whiteColor : MainColors.primaryColor,
                ),
              ),
            ),
          ),
          if (isSelected)
            SizedBox(
              width: double.infinity,
              height: 70.h + 20.r,
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
      ),
    );
  }
}
