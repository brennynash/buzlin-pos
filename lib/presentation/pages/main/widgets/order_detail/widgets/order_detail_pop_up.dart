import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'edit_stock_id_dialog.dart';
import 'replace_product_dialog.dart';

class OrderDetailPopup extends ConsumerWidget {
  final Stocks stocks;

  const OrderDetailPopup({
    super.key,
    required this.stocks,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return _CustomPopupItem(
          onReplaceProduct: () {
            ref.read(orderDetailsProvider.notifier).setOldStock(stocks);
            AppHelpers.showAlertDialog(
                context: context,
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height / 1.5,
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: EditStockIdDialog(
                    stock: stocks,
                  ),
                ),
                backgroundColor: Style.bg);
          },
          onShowReplaced: () {
             context.maybePop();
            AppHelpers.showAlertDialog(
                context: context,
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height / 2.5,
                  width: MediaQuery.sizeOf(context).width / 4,
                  child: ReplaceProductDialog(
                    stocks: stocks,
                  ),
                ),
                backgroundColor: Style.bg);
          },
          showReplace: stocks.replaceStock != null,
        );
      },
    );
  }
}

class _CustomPopupItem extends StatelessWidget {
  final VoidCallback onReplaceProduct;
  final VoidCallback onShowReplaced;
  final bool showReplace;

  const _CustomPopupItem({
    required this.onReplaceProduct,
    required this.onShowReplaced,
    required this.showReplace,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: const EdgeInsets.all(0),
      tooltip: "",
      splashRadius: 40,
      iconSize: 24,
      icon: const Icon(Remix.more_fill),
      itemBuilder: (c) {
        return [
          _buildPopupMenuItem(
            title: AppHelpers.getTranslation(TrKeys.editStock),
            iconData: Remix.swap_box_line,
            onTap: () {
              // c.maybePop();
              Navigator.pop(c);
              onReplaceProduct.call();
            },
          ),
          if (showReplace)
            _buildPopupMenuItem(
              title: AppHelpers.getTranslation(TrKeys.replacedProduct),
              iconData: Remix.eye_line,
              onTap: () {
                c.maybePop();
                onShowReplaced();
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
