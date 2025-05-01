import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class EditGroupExtrasModal extends ConsumerStatefulWidget {
  final int groupIndex;

  const EditGroupExtrasModal({
    super.key,
    required this.groupIndex,
  });

  @override
  ConsumerState<EditGroupExtrasModal> createState() =>
      _EditGroupsExtrasModalState();
}

class _EditGroupsExtrasModalState extends ConsumerState<EditGroupExtrasModal> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(editFoodStocksProvider.notifier).fetchGroupExtras(
            context,
            groupIndex: widget.groupIndex,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppHelpers.getTranslation(TrKeys.extras),
          ),
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(editFoodStocksProvider);
              final event = ref.read(editFoodStocksProvider.notifier);
              return state.isLoading
                  ? const Loading()
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shrinkWrap: true,
                      itemCount: state.activeGroupExtras.length,
                      itemBuilder: (context, index) => GroupExtrasItem(
                          extras: state.activeGroupExtras[index],
                          onTap: () => event.setActiveExtrasIndex(
                                itemIndex: index,
                                groupIndex: widget.groupIndex,
                              ),
                          isSelected: (state.selectGroups.values.any(
                              (element) => element.any((element) =>
                                  element?.id ==
                                  state.activeGroupExtras[index].id)))),
                    );
            },
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
