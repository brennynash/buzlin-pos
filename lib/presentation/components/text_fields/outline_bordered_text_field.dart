import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

import 'package:admin_desktop/infrastructure/services/utils.dart';

class OutlinedBorderTextField extends StatelessWidget {
  final String? label;
  final double radius;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscure;
  final TextEditingController? textController;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted;
  final TextInputType? inputType;
  final String? initialText;
  final String? descriptionText;
  final String? hintText;
  final bool readOnly;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final double? verticalPadding;
  final double? labelSize;
  final Color? color;
  final double borderWidth;
  final int? maxLength;
  final int? maxLine;
  final int? minLine;
  final bool? isDate;
  final Color? border;
  final TextStyle? style;
  final String? Function(String?)? validator;

  const OutlinedBorderTextField({
    super.key,
    required this.label,
    this.suffixIcon,
    this.prefixIcon,
    this.obscure,
    this.onChanged,
    this.textController,
    this.inputType,
    this.initialText,
    this.descriptionText,
    this.readOnly = false,
    this.textCapitalization,
    this.onFieldSubmitted,
    this.onTap,
    this.verticalPadding,
    this.labelSize,
    this.maxLength,
    this.isDate,
    this.color,
    this.style,
    this.border,
    this.validator,
    this.textInputAction,
    this.inputFormatters,
    this.maxLine,
    this.minLine,
    this.hintText,
    this.radius = 14,
    this.borderWidth = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Column(
            children: [
              Text(
                AppHelpers.getTranslation(label ?? ''),
                // style: Style.interSemi(color: Style.black),
              ),
              4.verticalSpace,
            ],
          ),
        TextFormField(
          validator: validator,
          maxLength: maxLength,
          minLines: minLine,
          onTap: onTap,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          obscureText: !(obscure ?? true),
          obscuringCharacter: '*',
          controller: textController,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: labelSize ?? 16,
            color: Style.black,
            letterSpacing: -14 * 0.01,
          ),
          cursorWidth: 1,
          maxLines: maxLine,
          cursorColor: Style.black,
          keyboardType: inputType,
          initialValue: initialText,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: hintText,
            counterText: '',
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              maxWidth: 56,
              minWidth: 36,
            ),
            labelStyle: style,
            prefix: prefixIcon,
            contentPadding: REdgeInsets.symmetric(
              horizontal: 16,
              vertical: verticalPadding ?? 10,
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
        if (descriptionText != null)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              4.verticalSpace,
              Text(
                descriptionText!,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.3,
                  fontSize: 12.sp,
                  color: Style.black,
                ),
              ),
            ],
          )
      ],
    );
  }
}
