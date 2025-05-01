import 'package:admin_desktop/presentation/components/buttons/view_more_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/transactions/wallet_provider.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'transaction_items.dart';

class TransactionListItem extends ConsumerWidget {
  final bool hasMore;
  final bool isLoading;
  final VoidCallback onViewMore;

  const TransactionListItem({
    super.key,
    required this.hasMore,
    required this.onViewMore,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(walletProvider);
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
            color: Style.white,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            child: Row(
              children: [
                8.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 18,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.id),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 8,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.sender),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 7,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.phone),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 7,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.wallet),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: constraints.maxWidth / 5,
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.createdDate),
                    style: Style.interNormal(size: 16),
                  ),
                ),
                8.horizontalSpace,
                Text(
                  AppHelpers.getTranslation(TrKeys.note),
                  style: Style.interNormal(size: 16),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const Divider(height: 2),
          Expanded(
            child: state.transactions.isNotEmpty || isLoading
                ? ListView(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.transactions.length,
                          itemBuilder: (context, index) {
                            return TransactionItem(
                              transactionData: state.transactions[index],
                              onSelect: () {},
                              isSelect: false,
                              onActive: (check) {},
                              isLoading: false,
                              constraints: constraints,
                            );
                          }),
                      if (isLoading)
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 72,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1),
                                      color: Style.shimmerBase,
                                    ),
                                  ),
                                  const Divider(height: 2, color: Style.white),
                                ],
                              );
                            }),
                      24.verticalSpace,
                      if (hasMore)
                        Padding(
                          padding: REdgeInsets.symmetric(horizontal: 16),
                          child: ViewMoreButton(onTap: onViewMore),
                        ),
                      24.verticalSpace,
                    ],
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 200),
                      child: Text(
                        AppHelpers.getTranslation(TrKeys.cannotBeEmpty),
                      ),
                    ),
                  ),
          ),
        ],
      );
    });
  }
}
