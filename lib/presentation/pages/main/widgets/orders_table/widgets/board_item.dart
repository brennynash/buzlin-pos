// ignore_for_file: non_constant_identifier_names
import 'package:admin_desktop/application/main/main_notifier.dart';
import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'drag_item.dart';

BoardItem({
  required List<OrderData> list,
  required BuildContext context,
  required bool hasMore,
  required bool isLoading,
  required VoidCallback onViewMore,
  required MainNotifier mainNotifier,
}) {
  return list.isNotEmpty || isLoading
      ? [
          ...list.map((OrderData item) {
            return DragAndDropItem(
              canDrag: LocalStorage.getShop()?.deliveryType == 2,
              child: DragItem(
                orderData: item,
                mainNotifier: mainNotifier,
              ),
              feedbackWidget: DragItem(
                orderData: item,
                isDrag: true,
                mainNotifier: mainNotifier,
              ),
            );
          }),
          if (isLoading)
            for (int i = 0; i < 3; i++)
              DragAndDropItem(
                canDrag: false,
                child: Container(
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Style.shimmerBase,
                  ),
                  margin: const EdgeInsets.all(6),
                  child: const SizedBox(
                    width: double.infinity,
                  ),
                ),
              ),
          (hasMore
              ? DragAndDropItem(
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Style.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => onViewMore(),
                      child: Container(
                        margin:
                            const EdgeInsets.only(right: 8, left: 8, top: 8),
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Style.black.withOpacity(0.17),
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppHelpers.getTranslation(TrKeys.viewMore),
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Style.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : DragAndDropItem(child: const SizedBox())),
          DragAndDropItem(
            canDrag: false,
            child: const SizedBox(height: 100),
          ),
        ]
      : [
          DragAndDropItem(
            canDrag: false,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 200),
                child: Text(
                  AppHelpers.getTranslation(TrKeys.emptyOrders),
                ),
              ),
            ),
          ),
        ];
}
