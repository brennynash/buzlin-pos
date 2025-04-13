import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class ShopInformation extends StatelessWidget {
  final ShopData? shop;

  const ShopInformation({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Style.borderColor),
      ),
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${AppHelpers.getTranslation(TrKeys.shop)}/${AppHelpers.getTranslation(TrKeys.restaurant)} ${AppHelpers.getTranslation(TrKeys.information)}",
            style:
                GoogleFonts.inter(fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
          16.verticalSpace,
          Row(
            children: [
              CommonImage(
                url: shop?.logoImg ?? "",
                width: 100,
                height: 100,
              ),
              16.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop?.translation?.title ?? "",
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      const Icon(Remix.phone_fill),
                      8.horizontalSpace,
                      Text(
                        shop?.phone ?? "",
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      const Icon(Remix.money_dollar_circle_fill),
                      8.horizontalSpace,
                      Text(
                        AppHelpers.numberFormat(number: shop?.tax),
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      const Icon(Remix.map_2_line),
                      8.horizontalSpace,
                      SizedBox(
                        width: 200.w,
                        child: Text(
                          shop?.translation?.address ?? "",
                          style: GoogleFonts.inter(
                            fontSize: 20.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
