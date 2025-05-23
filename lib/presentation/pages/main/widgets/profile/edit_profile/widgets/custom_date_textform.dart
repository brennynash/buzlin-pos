import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:intl/intl.dart';

class CustomDateFormField extends StatelessWidget {
  final String? text;
  final TextEditingController? controller;

  const CustomDateFormField({super.key, this.text, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text ?? '',
          style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Style.iconColor,
              fontWeight: FontWeight.w500),
        ),
        4.verticalSpace,
        TextFormField(
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1970),
                    lastDate: DateTime.now())
                .then((value) {
              controller?.text =
                  DateFormat('yyy-MM-dd').format(value ?? DateTime.now());
            });
          },
          readOnly: true,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: Style.black,
            letterSpacing: -14 * 0.01,
          ),
          cursorWidth: 1,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Remix.arrow_down_s_line,
                color: Style.black,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                'assets/svg/calendar.svg',
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Style.borderColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Style.borderColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Style.borderColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }
}
