import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class TimeInformation extends StatelessWidget {
  final OrderData? orderData;

  const TimeInformation({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Style.borderColor),
      ),
      padding: EdgeInsets.all(24.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${AppHelpers.getTranslation(TrKeys.createdDate)}: ${TimeService.dateFormat(orderData?.createdAt)}",
                style: GoogleFonts.inter(fontSize: 20.sp),
              ),
              16.verticalSpace,
              Text(
                "${AppHelpers.getTranslation(TrKeys.deliveryDate)}: ${orderData?.deliveryDate}",
                style: GoogleFonts.inter(fontSize: 20.sp),
              ),
              16.verticalSpace,
              Text(
                "${AppHelpers.getTranslation(TrKeys.paymentStatus)}: ${orderData?.transaction?.status ?? ""}",
                style: GoogleFonts.inter(fontSize: 20.sp),
              ),
              16.verticalSpace,
              SizedBox(
                width: 300.r,
                child: Text(
                  "${AppHelpers.getTranslation(TrKeys.address)}: ${orderData?.myAddress?.location?.address ?? ""}",
                  style: GoogleFonts.inter(fontSize: 20.sp),
                ),
              )
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${AppHelpers.getTranslation(TrKeys.status)}: ${orderData?.status}",
                style: GoogleFonts.inter(fontSize: 20.sp),
              ),
              16.verticalSpace,
              Text(
                "${AppHelpers.getTranslation(TrKeys.deliveryType)}: ${orderData?.deliveryType}",
                style: GoogleFonts.inter(fontSize: 20.sp),
              ),
              16.verticalSpace,
              Text(
                "${AppHelpers.getTranslation(TrKeys.paymentType)}: ${orderData?.transaction?.paymentSystem?.tag ?? ""}",
                style: GoogleFonts.inter(fontSize: 20.sp),
              )
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
