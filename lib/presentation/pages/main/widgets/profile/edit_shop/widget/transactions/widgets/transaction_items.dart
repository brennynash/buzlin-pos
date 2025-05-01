import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class TransactionItem extends ConsumerWidget {
  final TransactionModel transactionData;
  final VoidCallback onSelect;
  final Function(bool?) onActive;
  final bool isSelect;
  final bool isLoading;
  final BoxConstraints constraints;

  const TransactionItem({
    super.key,
    required this.transactionData,
    required this.onSelect,
    required this.isSelect,
    required this.onActive,
    required this.isLoading,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: isSelect ? Style.mainBack : Style.white,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: Row(
            children: [
              SizedBox(
                width: constraints.maxWidth / 18,
                child: Text(
                  "${transactionData.id ?? 0}",
                  style: Style.interNormal(
                    size: 16,
                    color: Style.brandTitleDivider,
                  ),
                ),
              ),
              16.horizontalSpace,
              SizedBox(
                width: constraints.maxWidth / 8,
                child: Text(
                  AppHelpers.getTranslation(
                      transactionData.user?.firstname ?? "--"),
                  style: Style.interNormal(
                    size: 16,
                    color: Style.brandTitleDivider,
                  ),
                ),
              ),
              8.horizontalSpace,
              SizedBox(
                width: constraints.maxWidth / 7,
                child: Text(
                  AppHelpers.getTranslation(
                      transactionData.user?.phone ?? "--"),
                  style: Style.interNormal(
                    size: 16,
                    color: Style.brandTitleDivider,
                  ),
                ),
              ),
              8.horizontalSpace,
              SizedBox(
                  width: constraints.maxWidth / 7,
                  child: Text(
                    transactionData.type == "withdraw"
                        ? "-${AppHelpers.numberFormat(number: transactionData.price)}"
                        : AppHelpers.numberFormat(
                            number: transactionData.price),
                    style: Style.interRegular(),
                  )),
              8.horizontalSpace,
              SizedBox(
                width: constraints.maxWidth / 5,
                child: Text(
                  TimeService.dateFormatMDYHm(transactionData.createdAt),
                  style: Style.interNormal(
                    size: 16,
                    color: Style.brandTitleDivider,
                  ),
                ),
              ),
              8.horizontalSpace,
              Expanded(
                child: Text(
                  AppHelpers.getTranslation(transactionData.note ?? "--"),
                  style: Style.interNormal(
                    size: 16,
                    color: Style.brandTitleDivider,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Divider(height: 2.r),
      ],
    );
  }
}
