import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'order_status.dart';

class StatusScreen extends StatelessWidget {
  final String orderDataStatus;
  final ShopData? shop;

  const StatusScreen(
      {super.key, required this.orderDataStatus, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Style.borderColor),
      ),
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Style.editProfileCircle,
            ),
            padding: const EdgeInsets.all(8),
            child: CommonImage(
              url: shop?.logoImg,
              radius: 25,
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop?.translation?.title ?? "",
                  style: GoogleFonts.inter(fontSize: 18, color: Style.black),
                ),
                SizedBox(
                  // width: MediaQuery.sizeOf(context).width / 2 - 100.w,
                  child: Text(
                    shop?.translation?.description ?? "",
                    style: GoogleFonts.inter(fontSize: 14, color: Style.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 100,
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return OrderStatusScreen(
                status: AppHelpers.getOrderStatus(orderDataStatus),
              );
            },
          ),
        ],
      ),
    );
  }
}
