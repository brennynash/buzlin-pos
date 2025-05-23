import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import '../../../../../../../../../domain/models/data/subscriptions_data.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';

class SubscriptionsItem extends StatelessWidget {
  final SubscriptionData subscription;
  final VoidCallback purchase;

  const SubscriptionsItem(
      {super.key, required this.subscription, required this.purchase});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Style.white,
          ),
          padding: const EdgeInsets.symmetric(vertical: 32),
          margin: const EdgeInsets.only(bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                subscription.title ?? "",
                style: Style.interNormal(size: 14),
              ),
              Text(
                AppHelpers.numberFormat(number: subscription.price),
                style: Style.interSemi(size: 18),
              ),
              12.verticalSpace,
              Text(
                "${subscription.month ?? 0} ${TrKeys.month}",
                style: Style.interNormal(size: 14),
              ),
              Text(
                "${AppHelpers.getTranslation(TrKeys.product)}: ${subscription.productLimit ?? 0}",
                style: Style.interNormal(size: 14),
              ),
              Text(
                "${AppHelpers.getTranslation(TrKeys.order)}: ${subscription.orderLimit ?? 0}",
                style: Style.interNormal(size: 14),
              ),
              if (subscription.withReport == true)
                Text(
                  "+ ${AppHelpers.getTranslation(TrKeys.withReport)}",
                  style: Style.interRegular(size: 12, color: Style.green),
                ),
              16.verticalSpace,
              CustomButton(
                bgColor: Style.primary,
                textColor: Style.white,
                title: TrKeys.purchase,
                onTap: purchase,
              )
            ],
          ),
        ),
        Positioned(
            right: 8.r,
            top: 8.r,
            child: CircleButton(
              size: 30,
              iconSize: 16,
              icon: Remix.question_mark,
              onTap: () {
                AppHelpers.openDialog(
                    context: context,
                    title:
                        "${AppHelpers.getTranslation(TrKeys.subscriptionIncludes)}, "
                        "\n${AppHelpers.getTranslation(TrKeys.productCount)}: ${subscription.productLimit ?? 0}, "
                        "\n${AppHelpers.getTranslation(TrKeys.orderCount)}: ${subscription.orderLimit ?? 0}, "
                        "\n${AppHelpers.getTranslation(TrKeys.duration)}: ${subscription.month} ${AppHelpers.getTranslation(TrKeys.month)}");
              },
            )),
      ],
    );
  }
}
