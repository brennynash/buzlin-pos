import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../order_detail/order_detail.dart';
import '../product/widgets/view_mode.dart';
import 'widgets/board_view.dart';
import 'widgets/list_view.dart';
import 'widgets/start_end_date.dart';

class OrdersTablesPage extends ConsumerStatefulWidget {
  const OrdersTablesPage({super.key});

  @override
  ConsumerState<OrdersTablesPage> createState() => _OrdersTablesState();
}

class _OrdersTablesState extends ConsumerState<OrdersTablesPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newOrdersProvider.notifier).fetchNewOrders(isRefresh: true);
      ref
          .read(acceptedOrdersProvider.notifier)
          .fetchAcceptedOrders(isRefresh: true);
      if (LocalStorage.getUser()?.role != TrKeys.waiter) {
        ref
            .read(onAWayOrdersProvider.notifier)
            .fetchOnAWayOrders(isRefresh: true);
      }
      ref.read(readyOrdersProvider.notifier).fetchReadyOrders(isRefresh: true);
      ref
          .read(deliveredOrdersProvider.notifier)
          .fetchDeliveredOrders(isRefresh: true);
      ref
          .read(canceledOrdersProvider.notifier)
          .fetchCanceledOrders(isRefresh: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listAccepts = ref.watch(acceptedOrdersProvider).orders;
    final listNew = ref.watch(newOrdersProvider).orders;
    final listOnAWay = ref.watch(onAWayOrdersProvider).orders;
    final listReady = ref.watch(readyOrdersProvider).orders;
    final listDelivered = ref.watch(deliveredOrdersProvider).orders;
    final listCancel = ref.watch(canceledOrdersProvider).orders;
    final notifier = ref.read(orderTableProvider.notifier);
    final state = ref.watch(orderTableProvider);
    final stateMain = ref.watch(mainProvider);

    return CustomScaffold(
        body: (colors) => stateMain.selectedOrder != null
            ? OrderDetailPage(order: stateMain.selectedOrder ?? OrderData())
            : SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: state.showFilter ? 20.r : 10.r,
                          horizontal: 16.r),
                      decoration: const BoxDecoration(color: Style.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(AppHelpers.getTranslation(TrKeys.order),
                                  style: GoogleFonts.inter(
                                    color: Style.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  )),
                              const Spacer(),
                              IconButton(
                                  onPressed: () => notifier.changeFilter(),
                                  icon: state.showFilter
                                      ? const Icon(Remix.arrow_up_s_line)
                                      : const Icon(Remix.arrow_down_s_line))
                            ],
                          ),
                          Visibility(
                              visible: state.showFilter,
                              child: Column(
                                children: [
                                  16.verticalSpace,
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          ref
                                              .read(orderTableProvider.notifier)
                                              .setTime(null, null);
                                          ref
                                              .read(newOrdersProvider.notifier)
                                              .fetchNewOrders(isRefresh: true);
                                          ref
                                              .read(acceptedOrdersProvider
                                                  .notifier)
                                              .fetchAcceptedOrders(
                                                  isRefresh: true);
                                          if (LocalStorage.getUser()?.role !=
                                              TrKeys.waiter) {
                                            ref
                                                .read(onAWayOrdersProvider
                                                    .notifier)
                                                .fetchOnAWayOrders(
                                                    isRefresh: true);
                                          }
                                          ref
                                              .read(
                                                  readyOrdersProvider.notifier)
                                              .fetchReadyOrders(
                                                  isRefresh: true);
                                          ref
                                              .read(deliveredOrdersProvider
                                                  .notifier)
                                              .fetchDeliveredOrders(
                                                  isRefresh: true);
                                          ref
                                              .read(canceledOrdersProvider
                                                  .notifier)
                                              .fetchCanceledOrders(
                                                  isRefresh: true);
                                        },
                                        child: ButtonEffectAnimation(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Style.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  border: Border.all(
                                                      color: Style
                                                          .unselectedBottomBarBack)),
                                              padding: EdgeInsets.all(8.r),
                                              child: const Icon(
                                                  Remix.restart_line)),
                                        ),
                                      ),
                                      16.horizontalSpace,
                                      StartEndDate(
                                        start: state.start,
                                        end: state.end,
                                        filterScreen: const FilterScreen(
                                          isOrder: true,
                                        ),
                                      ),
                                      const Spacer(),
                                      ViewMode(
                                        title: AppHelpers.getTranslation(
                                            TrKeys.board),
                                        isActive: !state.isListView,
                                        icon: Remix.dashboard_line,
                                        isLeft: true,
                                        onTap: () => notifier.changeViewMode(0),
                                      ),
                                      ViewMode(
                                        title: AppHelpers.getTranslation(
                                            TrKeys.list),
                                        isActive: state.isListView,
                                        isRight: true,
                                        icon: Remix.menu_fill,
                                        onTap: () => notifier.changeViewMode(1),
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: !state.isListView
                          ? BoardViewMode(
                              listAccepts: listAccepts,
                              listNew: listNew,
                              listOnAWay: listOnAWay,
                              listReady: listReady,
                              listCanceled: listCancel,
                              listDelivered: listDelivered,
                            )
                          : ListViewMode(
                              listAccepts: listAccepts,
                              listNew: listNew,
                              listOnAWay: listOnAWay,
                              listReady: listReady,
                              listCanceled: listCancel,
                              listDelivered: listDelivered,
                            ),
                    ),
                  ],
                ),
              ));
  }
}
