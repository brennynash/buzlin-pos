import 'package:admin_desktop/domain/models/data/help_data.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpItem extends StatelessWidget {
  final Datum? helpData;

  const HelpItem({super.key, required this.helpData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppHelpers.showAlertDialog(
          context: context,
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width/2,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  18.verticalSpace,
                  Text(
                    helpData?.translation?.question ?? "",
                    style: Style.interSemi(size: 18.sp),
                  ),
                  14.verticalSpace,
                  Text(
                    helpData?.translation?.answer ?? "",
                    style: Style.interRegular(
                        size: 16.sp, color: Style.textColor),
                  ),
                  24.verticalSpace
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.r),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Style.white, borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    helpData?.translation?.question ?? "",
                    style: Style.interNormal(size: 16.sp),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Style.textColor,
                )
              ],
            ),
            10.verticalSpace,
            Text(
              helpData?.translation?.answer ?? "",
              style:
              Style.interRegular(size: 14.sp, color: Style.textColor),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
