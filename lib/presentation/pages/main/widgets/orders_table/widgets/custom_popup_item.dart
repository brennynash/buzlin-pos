import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../order_detail/generate_check.dart';
import 'map_dialog.dart';

class CustomPopup extends ConsumerWidget {
  final OrderData orderData;
  final bool isLocation;
  final int? index;
  final bool isResponsive;

  const CustomPopup({
    super.key,
    required this.orderData,
    required this.isLocation,
    this.index,
    this.isResponsive = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    return _CustomPopupItem(
      onLocation: () {
        AppHelpers.showAlertDialog(
            context: context, child: MapDialog(orderData: orderData));
      },
      onEdit: () => ref.read(mainProvider.notifier).setOrder(orderData),
      onDownload: () {
        showDialog(
            context: context,
            builder: (context) {
              return LayoutBuilder(builder: (context, constraints) {
                return SimpleDialog(
                  title: SizedBox(
                    height: constraints.maxHeight * 0.7,
                    width: constraints.maxWidth * 0.4,
                    child: GenerateCheckPage(orderData: orderData),
                  ),
                );
              });
            });
      },
      onDelete: () {
         context.maybePop();
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  titlePadding: const EdgeInsets.all(16),
                  actionsPadding: const EdgeInsets.all(16),
                  title: Text(
                    AppHelpers.getTranslation(TrKeys.deleteOrder),
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: Style.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  actions: [
                    SizedBox(
                      width: 100,
                      child: ConfirmButton(
                          title: AppHelpers.getTranslation(TrKeys.no),
                          onTap: () {
                             context.maybePop();
                          }),
                    ),
                    SizedBox(
                      width: 100,
                      child: ConfirmButton(
                          title: AppHelpers.getTranslation(TrKeys.yes),
                          onTap: () {
                            if (orderData.status == 'accepted') {
                              ref
                                  .read(acceptedOrdersProvider.notifier)
                                  .deleteOrder(
                                    context,
                                    orderId: orderData.id,
                                  );
                            } else if (orderData.status == 'ready') {
                              ref
                                  .read(readyOrdersProvider.notifier)
                                  .deleteOrder(
                                    context,
                                    orderId: orderData.id,
                                  );
                            } else if (orderData.status == 'on_a_way') {
                              ref
                                  .read(onAWayOrdersProvider.notifier)
                                  .deleteOrder(
                                    context,
                                    orderId: orderData.id,
                                  );
                            } else if (orderData.status == 'delivered') {
                              ref
                                  .read(deliveredOrdersProvider.notifier)
                                  .deleteOrder(
                                    context,
                                    orderId: orderData.id,
                                  );
                            } else if (orderData.status == 'canceled') {
                              ref
                                  .read(canceledOrdersProvider.notifier)
                                  .deleteOrder(
                                    context,
                                    orderId: orderData.id,
                                  );
                            } else {
                              ref.read(newOrdersProvider.notifier).deleteOrder(
                                    context,
                                    orderId: orderData.id,
                                  );
                            }
                             context.maybePop();
                          }),
                    ),
                  ],
                ));
      },
      isLocation: isLocation,
    );
  }
}

class _CustomPopupItem extends StatelessWidget {
  final VoidCallback onLocation;
  final VoidCallback onEdit;
  final VoidCallback onDownload;
  final VoidCallback onDelete;
  final bool isLocation;

  const _CustomPopupItem({
    required this.onLocation,
    required this.onEdit,
    required this.onDownload,
    required this.onDelete,
    required this.isLocation,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: "",
      splashRadius: 40,
      iconSize: 24,
      icon: const Icon(Remix.more_fill),
      itemBuilder: (c) {
        return [
          if (isLocation)
            _buildPopupMenuItem(
              title: AppHelpers.getTranslation(TrKeys.locations),
              iconData: Remix.map_pin_range_line,
              onTap: () {
                c.maybePop();
                onLocation();
              },
            ),
          _buildPopupMenuItem(
            title: AppHelpers.getTranslation(TrKeys.open),
            iconData: Remix.folder_open_line,
            onTap: () {
              c.maybePop();
              onEdit();
            },
          ),
          _buildPopupMenuItem(
            title: AppHelpers.getTranslation(TrKeys.download),
            iconData: Remix.download_2_line,
            onTap: () {
              c.maybePop();
              onDownload();
            },
          ),
          if (LocalStorage.getUser()?.role == TrKeys.admin)
            _buildPopupMenuItem(
              title: AppHelpers.getTranslation(TrKeys.delete),
              iconData: Remix.delete_bin_line,
              onTap: () {
                c.maybePop();
                onDelete();
              },
            ),
        ];
      },
    );
  }

  PopupMenuItem _buildPopupMenuItem({
    required String title,
    required IconData iconData,
    required VoidCallback onTap,
  }) {
    return PopupMenuItem(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            2.horizontalSpace,
            Icon(iconData, size: 21),
            8.horizontalSpace,
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Style.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
