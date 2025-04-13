import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class CreateFoodEditExtrasModal extends ConsumerStatefulWidget {
  final int groupIndex;
  final Group group;

  const CreateFoodEditExtrasModal({
    super.key,
    required this.groupIndex,
    required this.group,
  });

  @override
  ConsumerState<CreateFoodEditExtrasModal> createState() =>
      _CreateFoodEditExtrasModalState();
}

class _CreateFoodEditExtrasModalState
    extends ConsumerState<CreateFoodEditExtrasModal> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(createFoodStocksProvider.notifier).fetchGroupExtras(
            context,
            groupIndex: widget.groupIndex,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(createFoodStocksProvider);
                final event = ref.read(createFoodStocksProvider.notifier);
                return state.isLoading
                    ? Padding(
                        padding: REdgeInsets.symmetric(vertical: 48),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 4.r,
                            color: Style.primary,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: REdgeInsets.symmetric(vertical: 20),
                        shrinkWrap: true,
                        itemCount: state.activeGroupExtras.length,
                        itemBuilder: (context, index) {
                          return GroupExtrasItem(
                            extras: state.activeGroupExtras[index],
                            onTap: () => event.setActiveExtrasIndex(
                              itemIndex: index,
                              groupIndex: widget.groupIndex,
                            ),
                            isSelected: (state.selectGroups.values.any(
                                (element) => element.any((element) =>
                                    element?.id ==
                                    state.activeGroupExtras[index].id))),
                          );
                        },
                      );
              },
            ),
            12.verticalSpace,
          ],
        ),
      ),
    );
  }
}
