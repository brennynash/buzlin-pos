import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../styles/style.dart';
import 'app_bar_item.dart';

class DetailAppBar extends StatelessWidget {
  final OrderData? orderData;

  const DetailAppBar({super.key, required this.orderData});

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppbarItem(
            title: AppHelpers.getTranslation(TrKeys.deliveryDate),
            icon: Remix.calendar_line,
            desc: TimeService.dateFormat(orderData?.deliveryDate),
          ),
          AppbarItem(
            title: AppHelpers.getTranslation(TrKeys.totalPrice),
            icon: Remix.bank_card_line,
            desc: AppHelpers.numberFormat(number: orderData?.totalPrice),
          ),
          AppbarItem(
              title: AppHelpers.getTranslation(TrKeys.messages),
              icon: Remix.message_2_line,
              desc: TimeService.dateFormat(orderData?.deliveryDate)),
          AppbarItem(
              title: AppHelpers.getTranslation(TrKeys.products),
              icon: Remix.shopping_cart_line,
              desc: "${orderData?.details?.length ?? 0}"),
        ],
      ),
    );
  }
}
