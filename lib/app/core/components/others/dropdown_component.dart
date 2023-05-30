import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:urban_app/app/core/styles/text_styles.dart';
import 'package:urban_app/app/models/util_model.dart';

class DropDownComponent extends StatelessWidget {
  List<UtilModel> dataList;
  UtilModel? selectedUtil;
  String label;
  double? width;
  bool isLabelOutside;
  Function(UtilModel) changeSelectedItem;
  FocusNode? focusNode;
  FocusNode? nextNode;
  String? error;
  Function(UtilModel? value)? validate;
  String? hint;
  Color? backgroundColor;

  DropDownComponent({
    super.key,
    required this.dataList,
    this.selectedUtil,
    required this.label,
    required this.focusNode,
    required this.changeSelectedItem,
    this.width,
    this.nextNode,
    this.error,
    this.isLabelOutside = false,
    this.validate,
    this.hint,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          isLabelOutside
              ? Container(
                  width: width ?? 1.sw * 0.8,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          label,
                          style: TextStyles.mediumBodyTextStyle(context),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
          Container(
            width: width ?? 1.sw * 0.8,
            decoration: BoxDecoration(
              color: backgroundColor ?? MainColors.inputColor(context),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 12),
              child: DropdownButtonFormField<UtilModel>(
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorStyle: TextStyles.smallBodyTextStyle(context).copyWith(
                    color: MainColors.errorColor(context)!,
                  ),
                ),
                validator: (value) => validate!(value),
                isExpanded: true,
                focusNode: focusNode,
                value: selectedUtil,
                items: dataList.map((UtilModel util) {
                  // print('id of stuff ${value.id}');
                  // FocusScope.of(context).requestFocus(FocusNode());
                  return DropdownMenuItem<UtilModel>(
                    value: util,
                    child: Text(
                      Get.locale?.languageCode == 'ar' ? '${util.titleEn}' : '${util.titleEn}',
                      textAlign: TextAlign.center,
                      style: TextStyles.mediumBodyTextStyle(context),
                    ),
                  );
                }).toList(),
                hint: Text(
                    selectedUtil != null
                        ? Get.locale?.languageCode == 'ar'
                            ? '${selectedUtil?.titleEn}'
                            : '${selectedUtil?.titleEn}'
                        : hint ?? '',
                    style: selectedUtil == null
                        ? TextStyles.mediumBodyTextStyle(context).copyWith(
                            color: MainColors.disableColor(context),
                          )
                        : TextStyles.mediumBodyTextStyle(context)),
                onChanged: (value) {
                  if (nextNode == null) {
                    FocusScope.of(context).requestFocus(nextNode);
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                  changeSelectedItem(value!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
