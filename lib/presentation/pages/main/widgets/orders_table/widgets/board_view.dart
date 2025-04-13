// ignore_for_file: must_be_immutable
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../styles/style.dart';
import '../../../../../theme/theme/theme.dart';
import 'board_item.dart';
import 'board_top_bar.dart';

class BoardViewMode extends ConsumerStatefulWidget {
  List<OrderData> listAccepts;
  List<OrderData> listNew;
  List<OrderData> listOnAWay;
  List<OrderData> listReady;
  List<OrderData> listDelivered;
  List<OrderData> listCanceled;

  BoardViewMode({
    super.key,
    required this.listAccepts,
    required this.listNew,
    required this.listOnAWay,
    required this.listReady,
    required this.listDelivered,
    required this.listCanceled,
  });

  @override
  ConsumerState<BoardViewMode> createState() => _BoardViewState();
}

class _BoardViewState extends ConsumerState<BoardViewMode> {
  ScrollController con = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: (CustomColorSet colors) {
        return Column(
          children: [
            Expanded(
              child: Scrollbar(
                scrollbarOrientation: ScrollbarOrientation.bottom,
                controller: con,
                child: DragAndDropLists(
                  scrollController: con,
                  axis: Axis.horizontal,
                  listWidth: 235,
                  listPadding: EdgeInsets.all(12.r),
                  listInnerDecoration: BoxDecoration(
                    color: Style.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  listDragOnLongPress: false,
                  disableScrolling: false,
                  children: [
                    buildList(OrderStatus.newOrder),
                    buildList(OrderStatus.accepted),
                    buildList(OrderStatus.ready),
                    buildList(OrderStatus.onAWay),
                    buildList(OrderStatus.delivered),
                    buildList(OrderStatus.canceled),
                  ],
                  itemDecorationWhileDragging: const BoxDecoration(
                    color: Style.transparent,
                  ),
                  onItemReorder: onReorderListItem,
                  onListReorder: onReorderList,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  DragAndDropList buildList(OrderStatus orderStatus) {
    List<OrderData> list;
    String header;
    bool hasMore;
    VoidCallback onViewMore;
    String count;
    bool isLoading;
    VoidCallback onRefresh;

    switch (orderStatus) {
      case OrderStatus.newOrder:
        list = widget.listNew;
        header = TrKeys.newKey;
        hasMore = ref.watch(newOrdersProvider).hasMore;
        onViewMore =
            () => ref.read(newOrdersProvider.notifier).fetchNewOrders();
        count = ref.watch(newOrdersProvider).totalCount.toString();
        isLoading = ref.watch(newOrdersProvider).isLoading;
        onRefresh = () {
          ref.read(newOrdersProvider.notifier).fetchNewOrders(isRefresh: true);
        };
        break;
      case OrderStatus.accepted:
        list = widget.listAccepts;
        header = TrKeys.accepted;
        hasMore = ref.watch(acceptedOrdersProvider).hasMore;
        onViewMore = () =>
            ref.read(acceptedOrdersProvider.notifier).fetchAcceptedOrders();
        count = ref.watch(acceptedOrdersProvider).totalCount.toString();
        isLoading = ref.watch(acceptedOrdersProvider).isLoading;
        onRefresh = () {
          ref
              .read(acceptedOrdersProvider.notifier)
              .fetchAcceptedOrders(isRefresh: true);
        };
        break;
      case OrderStatus.ready:
        list = widget.listReady;
        header = TrKeys.ready;
        hasMore = ref.watch(readyOrdersProvider).hasMore;
        onViewMore =
            () => ref.read(readyOrdersProvider.notifier).fetchReadyOrders();
        count = ref.watch(readyOrdersProvider).totalCount.toString();
        isLoading = ref.watch(readyOrdersProvider).isLoading;
        onRefresh = () {
          ref
              .read(readyOrdersProvider.notifier)
              .fetchReadyOrders(isRefresh: true);
        };
        break;
      case OrderStatus.onAWay:
        list = widget.listOnAWay;
        header = TrKeys.onAWay;
        hasMore = ref.watch(onAWayOrdersProvider).hasMore;
        onViewMore =
            () => ref.read(onAWayOrdersProvider.notifier).fetchOnAWayOrders();
        count = ref.watch(onAWayOrdersProvider).totalCount.toString();
        isLoading = ref.watch(onAWayOrdersProvider).isLoading;
        onRefresh = () {
          ref
              .read(onAWayOrdersProvider.notifier)
              .fetchOnAWayOrders(isRefresh: true);
        };

        break;
      case OrderStatus.delivered:
        list = widget.listDelivered;
        header = TrKeys.delivered;
        hasMore = ref.watch(deliveredOrdersProvider).hasMore;
        onViewMore = () {
          ref.read(deliveredOrdersProvider.notifier).fetchDeliveredOrders();
        };
        count = ref.watch(deliveredOrdersProvider).totalCount.toString();
        isLoading = ref.watch(deliveredOrdersProvider).isLoading;
        onRefresh = () {
          ref
              .read(deliveredOrdersProvider.notifier)
              .fetchDeliveredOrders(isRefresh: true);
        };

        break;
      case OrderStatus.canceled:
        list = widget.listCanceled;
        header = TrKeys.canceled;
        hasMore = ref.watch(canceledOrdersProvider).hasMore;
        onViewMore = () {
          ref.read(canceledOrdersProvider.notifier).fetchCanceledOrders();
        };
        count = ref.watch(canceledOrdersProvider).totalCount.toString();
        isLoading = ref.watch(canceledOrdersProvider).isLoading;
        onRefresh = () {
          ref
              .read(canceledOrdersProvider.notifier)
              .fetchCanceledOrders(isRefresh: true);
        };
        break;

      default:
        list = [];
        header = '';
        hasMore = false;
        onViewMore = () {};
        count = "0";
        isLoading = false;
        onRefresh = () {};
        break;
    }

    return DragAndDropList(
      canDrag: false,
      decoration: const BoxDecoration(color: Style.mainBack),
      header: BoardTopBar(
        title: header,
        count: count,
        onTap: onRefresh,
        isLoading: isLoading,
      ),
      children: BoardItem(
        mainNotifier: ref.read(mainProvider.notifier),
        list: list,
        context: context,
        hasMore: hasMore,
        onViewMore: onViewMore,
        isLoading: isLoading,
      ),
    );
  }

  void onReorderListItem(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) {
    if (newListIndex > oldListIndex) {
      switch (newListIndex) {
        case 1:
          {
            ref.read(acceptedOrdersProvider.notifier).addList(
                ref.watch(newOrdersProvider).orders[oldItemIndex], context);

            break;
          }
        case 2:
          {
            ref.read(readyOrdersProvider.notifier).addList(
                oldListIndex == 0
                    ? ref.watch(newOrdersProvider).orders[oldItemIndex]
                    : ref.watch(acceptedOrdersProvider).orders[oldItemIndex],
                context);
            break;
          }
        case 3:
          {
            ref.read(onAWayOrdersProvider.notifier).addList(
                oldListIndex == 0
                    ? ref.watch(newOrdersProvider).orders[oldItemIndex]
                    : oldListIndex == 1
                        ? ref.watch(acceptedOrdersProvider).orders[oldItemIndex]
                        : ref.watch(readyOrdersProvider).orders[oldItemIndex],
                context);
            break;
          }

        case 4:
          {
            ref.read(deliveredOrdersProvider.notifier).addList(
                oldListIndex == 0
                    ? ref.watch(newOrdersProvider).orders[oldItemIndex]
                    : oldListIndex == 1
                        ? ref.watch(acceptedOrdersProvider).orders[oldItemIndex]
                        : oldListIndex == 2
                            ? ref
                                .watch(readyOrdersProvider)
                                .orders[oldItemIndex]
                            : ref
                                .watch(onAWayOrdersProvider)
                                .orders[oldItemIndex],
                context);
            break;
          }
        case 5:
          {
            ref.read(canceledOrdersProvider.notifier).addList(
                oldListIndex == 0
                    ? ref.watch(newOrdersProvider).orders[oldItemIndex]
                    : oldListIndex == 1
                        ? ref.watch(acceptedOrdersProvider).orders[oldItemIndex]
                        : oldListIndex == 2
                            ? ref
                                .watch(readyOrdersProvider)
                                .orders[oldItemIndex]
                            : oldListIndex == 3
                                ? ref
                                    .watch(onAWayOrdersProvider)
                                    .orders[oldItemIndex]
                                : ref
                                    .watch(deliveredOrdersProvider)
                                    .orders[oldItemIndex],
                context);
            break;
          }
      }

      switch (oldListIndex) {
        case 0:
          {
            ref.read(newOrdersProvider.notifier).removeList(oldItemIndex);
            break;
          }
        case 1:
          {
            ref.read(acceptedOrdersProvider.notifier).removeList(oldItemIndex);
            break;
          }
        case 2:
          {
            ref.read(readyOrdersProvider.notifier).removeList(oldItemIndex);
            break;
          }
        case 3:
          {
            if (LocalStorage.getUser()?.role != TrKeys.waiter) {
              ref.read(onAWayOrdersProvider.notifier).removeList(oldItemIndex);
            } else {
              ref
                  .read(deliveredOrdersProvider.notifier)
                  .removeList(oldItemIndex);
            }
            break;
          }
        case 4:
          {
            if (LocalStorage.getUser()?.role != TrKeys.waiter) {
              ref
                  .read(deliveredOrdersProvider.notifier)
                  .removeList(oldItemIndex);
            }
            break;
          }
      }
    }
  }

  void onReorderList(
    int oldListIndex,
    int newListIndex,
  ) {}
}
