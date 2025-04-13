import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/components/list_items/master_item.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class SelectMasterBottomSheet extends ConsumerStatefulWidget {
  final String? title;
  final int? serviceId;
  final int? masterId;
  final ValueChanged<UserData>? onSelect;

  const SelectMasterBottomSheet({
    super.key,
    required this.title,
    this.serviceId,
    this.masterId,
    this.onSelect,
  });

  @override
  ConsumerState<SelectMasterBottomSheet> createState() =>
      _SelectMasterBottomSheetState();
}

class _SelectMasterBottomSheetState
    extends ConsumerState<SelectMasterBottomSheet> {
  late RefreshController controller;

  @override
  void initState() {
    controller = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(acceptedMastersProvider.notifier).fetchMembers(
            serviceId: widget.serviceId,
            isRefresh: true,
          );
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(acceptedMastersProvider);
    final notifier = ref.read(acceptedMastersProvider.notifier);
    return KeyboardDismisser(
      child: Container(
        width: MediaQuery.sizeOf(context).width / 1.7,
        height: MediaQuery.sizeOf(context).height / 1.4,
        padding: EdgeInsets.only(
          left: 16.r,
          right: 16.r,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.verticalSpace,
            Text(
              widget.title ?? "",
              style: Style.interNormal(size: 22),
            ),
            state.isLoading
                ? Padding(
                    padding: EdgeInsets.only(top: 32.r),
                    child: const Loading(),
                  )
                : Expanded(
                    child: SmartRefresher(
                      controller: controller,
                      // scrollController: widget.controller,
                      enablePullUp: true,
                      enablePullDown: false,
                      onRefresh: () {
                        notifier.fetchMembers(
                          isRefresh: true,
                          serviceId: widget.serviceId,
                        );
                      },
                      onLoading: () {
                        notifier.fetchMembers(
                          serviceId: widget.serviceId,
                        );
                      },
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 24.r),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 284.r,
                          mainAxisSpacing: 8.r,
                          crossAxisSpacing: 8.r,
                        ),
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          return MasterItem(
                            selectService: true,
                            onTap: () {
                              if (widget.onSelect == null) {
                                ref
                                    .read(createBookingProvider.notifier)
                                    .selectMaster(
                                        serviceId: widget.serviceId,
                                        master: state.users[index]);
                                 context.maybePop();
                              } else {
                                 context.maybePop();
                                if (widget.masterId != state.users[index].id) {
                                  widget.onSelect?.call(state.users[index]);
                                }
                              }
                            },
                            height: 156,
                            master: state.users[index],
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
