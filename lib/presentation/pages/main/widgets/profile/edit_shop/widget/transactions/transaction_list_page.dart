import 'package:admin_desktop/application/profile/profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/application/transactions/wallet_provider.dart';
import 'fill_wallet_screen.dart';
import 'send_price_screen.dart';
import 'widgets/transaction_list.dart';

class TransactionListPage extends StatefulWidget {
  final WidgetRef ref;

  const TransactionListPage({super.key, required this.ref});

  @override
  State<TransactionListPage> createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.ref
          .read(walletProvider.notifier)
          .fetchTransactions(context: context, isRefresh: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileNotifier = widget.ref.read(profileProvider.notifier);
    final notifier = widget.ref.read(walletProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        8.verticalSpace,
        Row(
          children: [
            CustomBackButton(onTap: () => profileNotifier.changeIndex(0)),
            const Spacer(),
            CustomButton(
                title: AppHelpers.getTranslation(TrKeys.send),
                onTap: () {
                  AppHelpers.showAlertDialog(
                    context: context,
                    child: SizedBox(
                        height: MediaQuery.sizeOf(context).height / 2,
                        width: MediaQuery.sizeOf(context).width / 3,
                        child: const SendPriceScreen()),
                  );
                }),
            8.horizontalSpace,
            CustomButton(
                title: AppHelpers.getTranslation(TrKeys.add),
                onTap: () {
                  AppHelpers.showAlertDialog(
                    context: context,
                    child: SizedBox(
                        height: MediaQuery.sizeOf(context).height / 2,
                        width: MediaQuery.sizeOf(context).width / 3,
                        child: const FillWalletScreen()),
                  );
                }),
            16.horizontalSpace
          ],
        ),
        8.verticalSpace,
        Expanded(
          child: TransactionListItem(
            hasMore: false,
            onViewMore: () {
              notifier.fetchTransactions(context: context);
            },
            isLoading: false,
          ),
        ),
      ],
    );
  }
}
