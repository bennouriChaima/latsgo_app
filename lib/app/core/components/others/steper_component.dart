import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_app/app/core/constants/strings_assets_constants.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';

class StepperComponent extends StatelessWidget {
  const StepperComponent({Key? key, required this.currentStep}) : super(key: key);

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return AnotherStepper(
      activeBarColor: MainColors.primaryColor,
      activeIndex: currentStep,
      barThickness: 5,
      inActiveBarColor: MainColors.disableColor(context)!,
      inverted: true,
      stepperList: [
        StepperData(
          subtitle: StepperText(
            '',
            textStyle: const TextStyle(
              height: 0.4,
            ),
          ),
          title: StepperText(
            StringsAssetsConstants.personnelInformations,
            textStyle: TextStyles.smallBodyTextStyle(context).copyWith(
              color: currentStep >= 0 ? MainColors.textColor(context) : MainColors.disableColor(context),
            ),
          ),
          iconWidget: Container(
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: currentStep >= 0 ? MainColors.primaryColor : MainColors.disableColor(context),
            ),
          ),
        ),
        StepperData(
          subtitle: StepperText(
            '',
            textStyle: const TextStyle(
              height: 0.4,
            ),
          ),
          title: StepperText(
            StringsAssetsConstants.carInformations,
            textStyle:TextStyles.smallBodyTextStyle(context).copyWith(
              color: currentStep >= 1 ? MainColors.textColor(context) : MainColors.disableColor(context),
            ),
          ),
          iconWidget: Container(
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: currentStep >= 1 ? MainColors.primaryColor : MainColors.disableColor(context),
            ),
          ),
        ),
      ],
      stepperDirection: Axis.horizontal,
      iconWidth: 22.r, // Height that will be applied to all the stepper icons
      iconHeight: 22.r, // Width that will be applied to all the stepper icons
    );
  }
}
