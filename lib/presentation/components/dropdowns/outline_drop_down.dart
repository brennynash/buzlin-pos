import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class OutlineDropDown extends StatelessWidget {
  final String? value;
  final String? hint;
  final String? label;
  final List<String> list;
  final ValueChanged<String> onChanged;
  final double radius;
  final String? Function(String?)? validator;
  final double? labelSize;
  final Color? color;
  final double borderWidth;

  const OutlineDropDown({
    super.key,
    this.value,
    required this.list,
    required this.onChanged,
    this.hint,
    this.label,
    this.radius = 16,
    this.validator,
    this.borderWidth = 0.5,
    this.labelSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 2),
            child: Column(
              children: [
                Text(
                  AppHelpers.getTranslation(label!),
                  style: Style.interNormal(color: Style.black, size: 14),
                ),
                4.verticalSpace,
              ],
            ),
          ),
        DropdownButtonFormField(
          padding: EdgeInsets.zero,
          hint: Text(
            AppHelpers.getTranslation(hint ?? ''),
            style: Style.interNormal(size: 14, color: Style.textColor),
          ),
          value: value,
          validator: validator,
          items: list.map((e) {
            return DropdownMenuItem(
                value: e, child: Text(AppHelpers.getTranslation(e)));
          }).toList(),
          onChanged: (s) => onChanged.call(s.toString()),
          elevation: 0,
          dropdownColor: Style.white,
          iconEnabledColor: Style.black,
          borderRadius: BorderRadius.circular(8.r),
          style: Style.interRegular(size: 15),
          decoration: InputDecoration(
            counterText: '',
            suffixIconConstraints: const BoxConstraints(
              maxWidth: 56,
              minWidth: 36,
            ),
            contentPadding: REdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            floatingLabelStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: labelSize ?? 14,
              color: Style.black,
              letterSpacing: -14 * 0.01,
            ),
            fillColor: color ?? Style.white,
            filled: true,
            hoverColor: Style.transparent,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.merge(
                    BorderSide(color: Style.borderColor, width: borderWidth),
                    BorderSide(color: Style.borderColor, width: borderWidth)),
                borderRadius: BorderRadius.circular(radius)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide.merge(
                    BorderSide(color: Style.borderColor, width: borderWidth),
                    BorderSide(color: Style.borderColor, width: borderWidth)),
                borderRadius: BorderRadius.circular(radius)),
            border: OutlineInputBorder(
                borderSide: BorderSide.merge(
                    BorderSide(color: Style.borderColor, width: borderWidth),
                    BorderSide(color: Style.borderColor, width: borderWidth)),
                borderRadius: BorderRadius.circular(radius)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide.merge(
                    BorderSide(color: Style.borderColor, width: borderWidth),
                    BorderSide(color: Style.borderColor, width: borderWidth)),
                borderRadius: BorderRadius.circular(radius)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.merge(
                    BorderSide(color: Style.borderColor, width: borderWidth),
                    BorderSide(color: Style.borderColor, width: borderWidth)),
                borderRadius: BorderRadius.circular(radius)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.merge(
                    BorderSide(color: Style.borderColor, width: borderWidth),
                    BorderSide(color: Style.borderColor, width: borderWidth)),
                borderRadius: BorderRadius.circular(radius)),
          ),
        ),
      ],
    );
  }
}
