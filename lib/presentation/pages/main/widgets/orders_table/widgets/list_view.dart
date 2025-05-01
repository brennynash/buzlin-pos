import 'package:admin_desktop/application/order_table/order_table_notifier.dart';
import 'package:admin_desktop/presentation/assets.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:lottie/lottie.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/application/order_table/order_table_state.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../components/custom_checkbox.dart';
import 'custom_popup_item.dart';

part 'list_item.dart';

part 'list_main_item.dart';

part 'list_top_bar.dart';

// ignore: must_be_immutable
class ListViewMode extends ConsumerWidget {
  List<OrderData> listAccepts;
  List<OrderData> listNew;
  List<OrderData> listOnAWay;
  List<OrderData> listReady;
  List<OrderData> listDelivered;
  List<OrderData> listCanceled;

  ListViewMode({
    super.key,
    required this.listAccepts,
    required this.listNew,
    required this.listOnAWay,
    required this.listReady,
    required this.listDelivered,
    required this.listCanceled,
  });

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.read(orderTableProvider.notifier);
    final state = ref.watch(orderTableProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 64,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ListTopBar(
                    title: TrKeys.newKey,
                    count: ref.watch(newOrdersProvider).totalCount,
                    onRefresh: () {
                      ref
                          .read(newOrdersProvider.notifier)
                          .fetchNewOrders(isRefresh: true);
                    },
                    isLoading: ref.watch(newOrdersProvider).isLoading,
                    isActive: state.selectTabIndex == 0,
                    onTap: () => notifier.changeTabIndex(0),
                  ),
                  8.horizontalSpace,
                  ListTopBar(
                    title: TrKeys.accepted,
                    count: ref.watch(acceptedOrdersProvider).totalCount,
                    onRefresh: () {
                      ref
                          .read(acceptedOrdersProvider.notifier)
                          .fetchAcceptedOrders(isRefresh: true);
                    },
                    isLoading: ref.watch(acceptedOrdersProvider).isLoading,
                    isActive: state.selectTabIndex == 1,
                    onTap: () => notifier.changeTabIndex(1),
                  ),
                  8.horizontalSpace,
                  ListTopBar(
                    title: TrKeys.ready,
                    count: ref.watch(readyOrdersProvider).totalCount,
                    onRefresh: () {
                      ref
                          .read(readyOrdersProvider.notifier)
                          .fetchReadyOrders(isRefresh: true);
                    },
                    isLoading: ref.watch(readyOrdersProvider).isLoading,
                    isActive: state.selectTabIndex == 2,
                    onTap: () => notifier.changeTabIndex(2),
                  ),
                  8.horizontalSpace,
                  ListTopBar(
                    title: TrKeys.onAWay,
                    count: ref.watch(onAWayOrdersProvider).totalCount,
                    onRefresh: () {
                      ref
                          .read(onAWayOrdersProvider.notifier)
                          .fetchOnAWayOrders(isRefresh: true);
                    },
                    isLoading: ref.watch(onAWayOrdersProvider).isLoading,
                    isActive: state.selectTabIndex == 3,
                    onTap: () => notifier.changeTabIndex(3),
                  ),
                  8.horizontalSpace,
                  ListTopBar(
                    title: TrKeys.delivered,
                    count: ref.watch(deliveredOrdersProvider).totalCount,
                    onRefresh: () {
                      ref
                          .read(deliveredOrdersProvider.notifier)
                          .fetchDeliveredOrders(isRefresh: true);
                    },
                    isLoading: ref.watch(deliveredOrdersProvider).isLoading,
                    isActive: state.selectTabIndex == 4,
                    onTap: () => notifier.changeTabIndex(4),
                  ),
                  8.horizontalSpace,
                  ListTopBar(
                    title: TrKeys.canceled,
                    count: ref.watch(canceledOrdersProvider).totalCount,
                    onRefresh: () {
                      ref
                          .read(canceledOrdersProvider.notifier)
                          .fetchCanceledOrders(isRefresh: true);
                    },
                    isLoading: ref.watch(canceledOrdersProvider).isLoading,
                    isActive: state.selectTabIndex == 5,
                    onTap: () => notifier.changeTabIndex(5),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: state.selectTabIndex == 0
                ? ListMainItem(
                    state: state,
                    notifier: notifier,
                    orderList: listNew,
                    hasMore: ref.watch(newOrdersProvider).hasMore,
                    onViewMore: () {
                      ref.read(newOrdersProvider.notifier).fetchNewOrders();
                    },
                    isLoading: ref.watch(newOrdersProvider).isLoading,
                    mainNotifier: ref.read(mainProvider.notifier),
                  )
                : state.selectTabIndex == 1
                    ? ListMainItem(
                        state: state,
                        notifier: notifier,
                        orderList: listAccepts,
                        hasMore: ref.watch(acceptedOrdersProvider).hasMore,
                        onViewMore: () {
                          ref
                              .read(acceptedOrdersProvider.notifier)
                              .fetchAcceptedOrders();
                        },
                        isLoading: ref.watch(acceptedOrdersProvider).isLoading,
                        mainNotifier: ref.read(mainProvider.notifier),
                      )
                    : state.selectTabIndex == 2
                        ? ListMainItem(
                            state: state,
                            notifier: notifier,
                            orderList: listReady,
                            hasMore: ref.watch(readyOrdersProvider).hasMore,
                            onViewMore: () {
                              ref
                                  .read(readyOrdersProvider.notifier)
                                  .fetchReadyOrders();
                            },
                            isLoading: ref.watch(readyOrdersProvider).isLoading,
                            mainNotifier: ref.read(mainProvider.notifier),
                          )
                        : state.selectTabIndex == 3
                            ? ListMainItem(
                                state: state,
                                notifier: notifier,
                                orderList: listOnAWay,
                                hasMore:
                                    ref.watch(onAWayOrdersProvider).hasMore,
                                onViewMore: () {
                                  ref
                                      .read(onAWayOrdersProvider.notifier)
                                      .fetchOnAWayOrders();
                                },
                                isLoading:
                                    ref.watch(onAWayOrdersProvider).isLoading,
                                mainNotifier: ref.read(mainProvider.notifier),
                              )
                            : state.selectTabIndex == 4
                                ? ListMainItem(
                                    state: state,
                                    notifier: notifier,
                                    orderList: listDelivered,
                                    hasMore: ref
                                        .watch(deliveredOrdersProvider)
                                        .hasMore,
                                    onViewMore: () {
                                      ref
                                          .read(
                                              deliveredOrdersProvider.notifier)
                                          .fetchDeliveredOrders();
                                    },
                                    isLoading: ref
                                        .read(deliveredOrdersProvider)
                                        .isLoading,
                                    mainNotifier:
                                        ref.read(mainProvider.notifier),
                                  )
                                : ListMainItem(
                                    state: state,
                                    notifier: notifier,
                                    orderList: listCanceled,
                                    hasMore: ref
                                        .watch(canceledOrdersProvider)
                                        .hasMore,
                                    onViewMore: () {
                                      ref
                                          .read(canceledOrdersProvider.notifier)
                                          .fetchCanceledOrders();
                                    },
                                    isLoading: ref
                                        .read(canceledOrdersProvider)
                                        .isLoading,
                                    mainNotifier:
                                        ref.read(mainProvider.notifier),
                                  ),
          ),
        ],
      ),
    );
  }
}
