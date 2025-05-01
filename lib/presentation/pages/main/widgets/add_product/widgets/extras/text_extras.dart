import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'size_item.dart';

class TextExtras extends ConsumerWidget {
  final int groupIndex;
  final List<UiExtra> uiExtras;
  final Function(UiExtra) onUpdate;
  final String type;

  const TextExtras({
    super.key,
    required this.groupIndex,
    required this.uiExtras,
    required this.onUpdate,
    required this.type,
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.read(addProductProvider);
    final notifier = ref.read(addProductProvider.notifier);
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Style.colorGrey),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "$type : ${state.textExtra?.value ?? uiExtras[groupIndex].value}"),
              const Spacer(),
              GestureDetector(
                  onTap: notifier.setTextExtraOpened,
                  child: state.isTextExtrasOpened
                      ? Icon(
                          Remix.arrow_up_s_line,
                          size: 30.r,
                        )
                      : Icon(
                          Remix.arrow_down_s_line,
                          size: 30.r,
                        )),
              10.horizontalSpace,
            ],
          ),
          if (state.isTextExtrasOpened)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: uiExtras.length,
              itemBuilder: (BuildContext context, int index) {
                return SizeItem(
                  onTap: () {
                    if (uiExtras[index].isSelected) {
                      return;
                    }
                    onUpdate(uiExtras[index]);
                  },
                  isActive: uiExtras[index].isSelected,
                  title: uiExtras[index].value,
                );
              },
            ),
        ],
      ),
    );
  }
}
