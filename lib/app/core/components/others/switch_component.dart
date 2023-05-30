import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:urban_app/app/core/styles/colors.dart';

class SwitchComponent extends StatelessWidget {
  const SwitchComponent({Key? key, required this.enable, required this.onChange}) : super(key: key);

  final bool enable;
  final Function(bool value) onChange;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      activeColor: MainColors.primaryColor,
      inactiveColor: MainColors.disableColor(context)!,
      height: 22.r,
      width: 38.r,
      valueFontSize: 20.0.r,
      toggleSize: 20.r,
      value: enable,
      borderRadius: 30.0,
      padding: 2.r,
      onToggle: (value) => onChange(value),
    );
  }
}
