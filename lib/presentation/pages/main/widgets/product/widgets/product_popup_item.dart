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

class ProductPopup extends ConsumerWidget {
  final ProductData productData;
  final int? index;
  final bool isResponsive;

  const ProductPopup({
    super.key,
    required this.productData,
    this.index,
    this.isResponsive = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    return _CustomPopupItem(
      onEdit: () {
        ref.read(editFoodDetailsProvider.notifier).setFoodDetails(productData);
        ref.read(productProvider.notifier).changeState(2);
      },
      onDelete: () {
         context.maybePop();
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  titlePadding: const EdgeInsets.all(16),
                  actionsPadding: const EdgeInsets.all(16),
                  title: Text(
                    AppHelpers.getTranslation(TrKeys.deleteProduct),
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: Style.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  actions: [
                    SizedBox(
                      width: 112.r,
                      child: ConfirmButton(
                          paddingSize: 0,
                          title: AppHelpers.getTranslation(TrKeys.no),
                          onTap: () => Navigator.pop(context)),
                    ),
                    SizedBox(
                      width: 112.r,
                      child: ConfirmButton(
                          paddingSize: 0,
                          title: AppHelpers.getTranslation(TrKeys.yes),
                          onTap: () {
                            ref
                                .read(productProvider.notifier)
                                .deleteProduct(context, productData.id);

                             context.maybePop();
                          }),
                    ),
                  ],
                ));
      },
    );
  }
}

class _CustomPopupItem extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CustomPopupItem({
    required this.onEdit,
    required this.onDelete,
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
          _buildPopupMenuItem(
            title: AppHelpers.getTranslation(TrKeys.edit),
            iconData: Remix.pencil_line,
            onTap: () {
              Navigator.pop(c);
              onEdit();
            },
          ),
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
