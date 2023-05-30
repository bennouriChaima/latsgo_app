import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';

class PrimaryButtonComponent extends StatelessWidget {
  const PrimaryButtonComponent(
      {Key? key,
      required this.onTap,
      required this.text,
      this.backgroundColor,
      this.textColor,
      this.borderColor,
      this.gradient,
      this.borderRadius,
      this.width,
      this.height,
      this.isLoading,
      this.disableShadow})
      : super(key: key);

  @required
  final Function onTap;
  final String text;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color? textColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final bool? isLoading;
  final bool? disableShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: backgroundColor == null ? gradient ?? MainColors.primaryGradientColor : null,
        color: backgroundColor,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: 1.5,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
        boxShadow: disableShadow != false
            ? [
                BoxShadow(
                  color: (MainColors.primaryColor.withOpacity(0.2)),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: Offset(0, 10.h), // changes position of shadow
                ),
              ]
            : null,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          backgroundColor: MainColors.transparentColor,
          primary: MainColors.primaryColor,
        ),
        onPressed: () => onTap(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading == true)
              LoadingAnimationWidget.inkDrop(
                color: MainColors.whiteColor,
                size: 30.r,
              ),
            if (isLoading == false || isLoading == null)
              Expanded(
                child: Center(
                    child: Row(
                  textBaseline: TextBaseline.ideographic,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: TextStyles.buttonTextStyle(context).copyWith(
                        color: textColor ?? MainColors.whiteColor,
                      ),
                    ),
                  ],
                )),
              ),
          ],
        ),
      ),
    );
  }
}
