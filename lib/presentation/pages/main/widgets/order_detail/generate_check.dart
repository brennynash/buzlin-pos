import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../styles/style.dart';
import 'print_page.dart';

class GenerateCheckPage extends StatelessWidget {
  final OrderData? orderData;

  const GenerateCheckPage({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: REdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(AppHelpers.getTranslation(TrKeys.orderSummary),
                style: Style.interMedium(size: 20)),
            8.verticalSpace,
            Text(
                "${AppHelpers.getTranslation(TrKeys.order)} #${AppHelpers.getTranslation(TrKeys.id)}${orderData?.id}",
                style: Style.interNormal(size: 16)),
            12.verticalSpace,
            Row(
              children: List.generate(
                  20,
                  (index) => Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.r),
                          height: 2,
                          color: Style.iconButtonBack,
                        ),
                      )),
            ),
            12.verticalSpace,
            Row(
              children: [
                SizedBox(
                  width: 120.w,
                  child: Text(AppHelpers.getTranslation(TrKeys.shopName),
                      style: Style.interRegular(size: 14)),
                ),
                Expanded(
                  child: Text(LocalStorage.getShop()?.translation?.title ?? "",
                      style: Style.interNormal(size: 14)),
                )
              ],
            ),
            8.verticalSpace,
            Row(
              children: [
                SizedBox(
                  width: 120.w,
                  child: Text(AppHelpers.getTranslation(TrKeys.client),
                      style: Style.interRegular(size: 14)),
                ),
                Expanded(
                  child: Text(
                      "${orderData?.user?.firstname ?? ""} ${orderData?.user?.lastname ?? ""}",
                      style: Style.interRegular(size: 14)),
                )
              ],
            ),
            8.verticalSpace,
            Row(
              children: [
                SizedBox(
                  width: 120.w,
                  child: Text(AppHelpers.getTranslation(TrKeys.date),
                      style: Style.interRegular(size: 14)),
                ),
                Text(TimeService.dateFormatMDYHm(orderData?.createdAt),
                    style: Style.interRegular(size: 12))
              ],
            ),
            10.verticalSpace,
            const Divider(thickness: 2),
            ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: orderData?.details?.length ?? 0,
                itemBuilder: (context, index) {
                  final stock = orderData?.details?[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${stock?.stock?.product?.translation?.title ?? ""} x ${stock?.quantity ?? ""}",
                                style: Style.interNormal(size: 14),
                              ),
                            ),
                            if (stock?.bonus ?? false)
                              Text(
                                AppHelpers.getTranslation(TrKeys.bonus),
                                style: Style.interNormal(size: 14),
                              ),
                            if (!(stock?.bonus ?? false))
                              Text(
                                AppHelpers.numberFormat(
                                    number: stock?.stock?.totalPrice),
                                style: Style.interNormal(size: 14),
                              )
                          ],
                        ),
                        10.verticalSpace,
                        Row(
                          children: List.generate(
                              20,
                              (index) => Expanded(
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        height: 2,
                                        color: Style.iconButtonBack),
                                  )),
                        )
                      ],
                    ),
                  );
                }),
            Row(
              children: List.generate(
                  20,
                  (index) => Expanded(
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 2,
                            color: Style.iconButtonBack),
                      )),
            ),
            20.verticalSpace,
            Row(
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.subtotal),
                  style: Style.interNormal(size: 14),
                ),
                const Spacer(),
                Text(
                  AppHelpers.numberFormat(number: orderData?.originPrice),
                  style: Style.interRegular(size: 14),
                )
              ],
            ),
            if ((orderData?.totalTax ?? 0) != 0)
              Column(
                children: [
                  10.verticalSpace,
                  Row(
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.tax),
                        style: Style.interNormal(size: 14),
                      ),
                      const Spacer(),
                      Text(
                        AppHelpers.numberFormat(number: orderData?.totalTax),
                        style: Style.interRegular(size: 14),
                      )
                    ],
                  ),
                ],
              ),
            if ((orderData?.serviceFee ?? 0) != 0)
              Column(
                children: [
                  10.verticalSpace,
                  Row(
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.serviceFee),
                        style: Style.interNormal(size: 14),
                      ),
                      const Spacer(),
                      Text(
                        AppHelpers.numberFormat(number: orderData?.serviceFee),
                        style: Style.interRegular(size: 14),
                      )
                    ],
                  ),
                ],
              ),
            if ((orderData?.deliveryFee ?? 0) != 0)
              Column(
                children: [
                  10.verticalSpace,
                  Row(
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.deliveryFee),
                        style: Style.interNormal(size: 14),
                      ),
                      const Spacer(),
                      Text(
                        AppHelpers.numberFormat(number: orderData?.deliveryFee),
                        style: Style.interRegular(size: 14),
                      )
                    ],
                  ),
                ],
              ),
            if ((orderData?.totalDiscount ?? 0) != 0)
              Column(
                children: [
                  10.verticalSpace,
                  Row(
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.discount),
                        style: Style.interNormal(size: 14),
                      ),
                      const Spacer(),
                      Text(
                        "-${AppHelpers.numberFormat(number: orderData?.totalDiscount)}",
                        style: Style.interRegular(size: 14),
                      )
                    ],
                  ),
                ],
              ),
            if ((orderData?.coupon?.price ?? 0) != 0)
              Column(
                children: [
                  10.verticalSpace,
                  Row(
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.coupon),
                        style: Style.interNormal(size: 14),
                      ),
                      const Spacer(),
                      Text(
                          "-${AppHelpers.numberFormat(number: orderData?.coupon?.price)}",
                          style: Style.interRegular(size: 14))
                    ],
                  ),
                ],
              ),
            10.verticalSpace,
            Row(
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.totalPrice),
                  style: Style.interMedium(size: 14),
                ),
                const Spacer(),
                Text(
                  AppHelpers.numberFormat(number: orderData?.totalPrice),
                  style: Style.interRegular(size: 14),
                )
              ],
            ),
            10.verticalSpace,
            Row(
              children: List.generate(
                20,
                (index) => Expanded(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.r),
                      height: 2,
                      color: Style.iconButtonBack),
                ),
              ),
            ),
            26.verticalSpace,
            Text(
              AppHelpers.getTranslation(TrKeys.thankYou).toUpperCase(),
              style: Style.interNormal(),
            ),
            24.verticalSpace,
            LoginButton(
                title: AppHelpers.getTranslation(TrKeys.print),
                onPressed: () async {
                  if (context.mounted) {
                    AppHelpers.showAlertDialog(
                        context: context,
                        child: PrintPage(orderData: orderData));
                  }
                })
          ],
        ),
      ),
    );
  }
}
