import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../application/providers.dart';
import '../../../../../../../../../domain/models/models.dart';
import '../../../../../../../styles/style.dart';
import '../../../../orders_table/widgets/board_top_bar.dart';
import 'board_item.dart';

class BoardViewMode extends ConsumerStatefulWidget {
  final List<UserData> listAccepts;
  final List<UserData> listNew;
  final List<UserData> listRejected;
  final List<UserData> listCanceled;

  const BoardViewMode({
    super.key,
    required this.listAccepts,
    required this.listNew,
    required this.listRejected,
    required this.listCanceled,
  });

  @override
  ConsumerState<BoardViewMode> createState() => _BoardViewState();
}

class _BoardViewState extends ConsumerState<BoardViewMode> {
  ScrollController con = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      scrollbarOrientation: ScrollbarOrientation.bottom,
      controller: con,
      child: DragAndDropLists(
        scrollController: con,
        axis: Axis.horizontal,
        listWidth: 248.w,
        listPadding: EdgeInsets.all(12.r),
        listInnerDecoration: BoxDecoration(
          color: Style.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        listDragOnLongPress: false,
        disableScrolling: false,
        children: [
          buildList(MasterStatus.newMaster),
          buildList(MasterStatus.acceptedMaster),
          buildList(MasterStatus.cancelledMaster),
          buildList(MasterStatus.rejectedMaster),
        ],
        itemDecorationWhileDragging: const BoxDecoration(
          color: Style.transparent,
        ),
        onItemReorder: onReorderListItem,
        onListReorder: onReorderList,
      ),
    );
  }

  DragAndDropList buildList(MasterStatus masterStatus) {
    List<UserData> list;
    String header;
    bool hasMore;
    VoidCallback onViewMore;
    String count;
    bool isLoading;
    VoidCallback onRefresh;

    switch (masterStatus) {
      case MasterStatus.newMaster:
        list = widget.listNew;
        header = TrKeys.newKey;
        hasMore = ref.watch(newMastersProvider).hasMore;
        onViewMore = () => ref.read(newMastersProvider.notifier).fetchMembers();
        count = ref.watch(newMastersProvider).totalCount.toString();
        isLoading = ref.watch(newMastersProvider).isLoading;
        onRefresh = () {
          ref.read(newMastersProvider.notifier).fetchMembers(isRefresh: true);
        };
        break;
      case MasterStatus.acceptedMaster:
        list = widget.listAccepts;
        header = TrKeys.accepted;
        hasMore = ref.watch(acceptedMastersProvider).hasMore;
        onViewMore =
            () => ref.read(acceptedMastersProvider.notifier).fetchMembers();
        count = ref.watch(acceptedMastersProvider).totalCount.toString();
        isLoading = ref.watch(acceptedMastersProvider).isLoading;
        onRefresh = () {
          ref
              .read(acceptedMastersProvider.notifier)
              .fetchMembers(isRefresh: true);
        };
        break;
      case MasterStatus.cancelledMaster:
        list = widget.listCanceled;
        header = TrKeys.canceled;
        hasMore = ref.watch(cancelledMastersProvider).hasMore;
        onViewMore =
            () => ref.read(cancelledMastersProvider.notifier).fetchMembers();
        count = ref.watch(cancelledMastersProvider).totalCount.toString();
        isLoading = ref.watch(cancelledMastersProvider).isLoading;
        onRefresh = () {
          ref
              .read(cancelledMastersProvider.notifier)
              .fetchMembers(isRefresh: true);
        };
        break;
      case MasterStatus.rejectedMaster:
        list = widget.listRejected;
        header = TrKeys.rejected;
        hasMore = ref.watch(rejectedMastersProvider).hasMore;
        onViewMore =
            () => ref.read(rejectedMastersProvider.notifier).fetchMembers();
        count = ref.watch(rejectedMastersProvider).totalCount.toString();
        isLoading = ref.watch(rejectedMastersProvider).isLoading;
        onRefresh = () {
          ref
              .read(rejectedMastersProvider.notifier)
              .fetchMembers(isRefresh: true);
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
    if (newListIndex != 2 && newListIndex != oldListIndex) {

      switch (newListIndex) {
        case 0:
          {
            ref.read(newMastersProvider.notifier).addList(
                oldListIndex == 1
                    ? ref.watch(acceptedMastersProvider).users[oldItemIndex]
                    : ref.watch(rejectedMastersProvider).users[oldItemIndex],
                context);
            break;
          }
        case 1:
          {
            ref.read(acceptedMastersProvider.notifier).addList(
                oldListIndex == 0
                    ? ref.watch(newMastersProvider).users[oldItemIndex]
                    : ref.watch(rejectedMastersProvider).users[oldItemIndex],
                context);
            break;
          }
        case 2:
          {
            ref.read(cancelledMastersProvider.notifier).addList(
                oldListIndex == 0
                    ? ref.watch(newMastersProvider).users[oldItemIndex]
                    : ref.watch(acceptedMastersProvider).users[oldItemIndex],
                context);
            break;
          }
        case 3:
          {
            ref.read(rejectedMastersProvider.notifier).addList(
                oldListIndex == 0
                    ? ref.watch(newMastersProvider).users[oldItemIndex]
                    : ref.watch(acceptedMastersProvider).users[oldItemIndex],
                context);
            break;
          }
      }

      switch (oldListIndex) {
        case 0:
          {
            ref.read(newMastersProvider.notifier).removeList(oldItemIndex);
            break;
          }
        case 1:
          {
            ref.read(acceptedMastersProvider.notifier).removeList(oldItemIndex);
            break;
          }
        case 2:
          {
            ref
                .read(cancelledMastersProvider.notifier)
                .removeList(oldItemIndex);
            break;
          }
        case 3:
          {
            ref.read(rejectedMastersProvider.notifier).removeList(oldItemIndex);
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
