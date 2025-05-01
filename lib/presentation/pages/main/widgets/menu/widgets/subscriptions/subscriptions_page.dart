import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../components/loading_grid.dart';
import '../../../../../../components/no_data_info.dart';
import 'widgets/have_subscription.dart';
import 'widgets/payment_dialog.dart';
import 'widgets/subscriptions_item.dart';

class SubscriptionsPage extends ConsumerStatefulWidget {
  const SubscriptionsPage({super.key});

  @override
  ConsumerState<SubscriptionsPage> createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends ConsumerState<SubscriptionsPage> {
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(subscriptionProvider.notifier)
          .fetchSubscriptions(isRefresh: true),
    );
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(subscriptionProvider);
          final notifier = ref.read(subscriptionProvider.notifier);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HeaderItem(title: TrKeys.subscriptions),
              Expanded(
                child: SmartRefresher(
                  controller: refreshController,
                  onRefresh: () => notifier.fetchSubscriptions(
                    context: context,
                    controller: refreshController,
                    isRefresh: true,
                  ),
                  child: state.isLoading
                      ? LoadingGrid(
                          verticalPadding: 12,
                          itemBorderRadius: 12,
                          horizontalPadding: 12,
                          crossAxisCount: 3,
                          itemHeight:
                              ((MediaQuery.sizeOf(context).height - 200.h) ~/
                                  2))
                      : SingleChildScrollView(
                          padding: REdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            children: [
                              if (LocalStorage.getShop()?.subscription != null)
                                const HaveSubscription(),
                              state.list.isEmpty
                                  ? NoDataInfo(
                                      title: AppHelpers.getTranslation(
                                          TrKeys.noData))
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: state.list.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 8.r,
                                              mainAxisSpacing: 4.r,
                                              crossAxisCount: 3,
                                              mainAxisExtent:
                                                  ((MediaQuery.sizeOf(context)
                                                              .height -
                                                          200.h) /
                                                      2)),
                                      padding: const EdgeInsets.all(12),
                                      itemBuilder: (context, index) =>
                                          SubscriptionsItem(
                                        subscription: state.list[index],
                                        purchase: () {
                                          if (LocalStorage.getShop()
                                                  ?.subscription ==
                                              null) {
                                            notifier.fetchPayments(
                                                context: context);
                                            notifier.selectPayment(
                                                index: index);
                                            AppHelpers.showAlertDialog(
                                                context: context,
                                                child: const PaymentDialog());
                                          } else {
                                            AppHelpers.errorSnackBar(context,
                                                text:
                                                    TrKeys.youHaveSubscription);
                                          }
                                        },
                                      ),
                                    ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
