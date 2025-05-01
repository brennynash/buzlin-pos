import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class ColorExtras extends ConsumerWidget {
  final int groupIndex;
  final List<UiExtra> uiExtras;
  final Function(UiExtra) onUpdate;
  final String type;

  const ColorExtras({
    super.key,
    required this.groupIndex,
    required this.type,
    required this.uiExtras,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(addProductProvider);
    final notifier = ref.read(addProductProvider.notifier);
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Style.colorGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("$type "),
              AppHelpers.checkIfHex(state.colorExtra?.value)
                  ? Container(
                      // margin: EdgeInsets.only(right: 6),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Color(
                          int.parse(
                              '0xFF${state.colorExtra?.value.substring(1, 7) ?? uiExtras[groupIndex].value.substring(1, 7)}'),
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                    )
                  : const SizedBox.shrink(),
              const Spacer(),
              GestureDetector(
                  onTap: notifier.setColorExtraOpened,
                  child: state.isColorExtrasOpened
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
          if (state.isColorExtrasOpened)
            Wrap(
              spacing: 8.r,
              runSpacing: 10.r,
              children: uiExtras
                  .map(
                    (uiExtra) => AppHelpers.checkIfHex(uiExtra.value)
                        ? Material(
                            shape: CircleBorder(
                                side: BorderSide(
                              color: uiExtra.value.substring(1, 7) == "ffffff"
                                  ? Style.black
                                  : Style.transparent,
                            )),
                            color: Color(int.parse(
                                '0xFF${uiExtra.value.substring(1, 7)}')),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(32.r),
                              onTap: () {
                                if (uiExtra.isSelected) {
                                  return;
                                }
                                onUpdate(uiExtra);
                              },
                              child: uiExtra.isSelected
                                  ? Container(
                                      width: 40.r,
                                      height: 40.r,
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Remix.check_double_line,
                                        color: uiExtra.value.substring(1, 7) ==
                                                "ffffff"
                                            ? Style.black
                                            : Style.white,
                                        size: 18.r,
                                      ),
                                    )
                                  : SizedBox(width: 40.r, height: 40.r),
                            ),
                          )
                        : Material(
                            shape: const CircleBorder(),
                            color: Style.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8.r),
                              onTap: () {
                                if (uiExtra.isSelected) {
                                  return;
                                }
                                onUpdate(uiExtra);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: uiExtra.isSelected
                                          ? Style.primary
                                          : Style.black.withOpacity(0.1),
                                      width: 1.5.r),
                                ),
                                padding: REdgeInsets.all(12),
                                child: Text(
                                  uiExtra.value,
                                  style: Style.interNormal(
                                    size: 14,
                                    color: Style.black,
                                    letterSpacing: -14 * 0.01,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  )
                  .toList(),
            )
        ],
      ),
    );
  }
}
