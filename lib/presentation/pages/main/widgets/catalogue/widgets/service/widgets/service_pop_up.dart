import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

class ServicePopUp extends ConsumerWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ServicePopUp({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return _CustomPopupItem(
          onEdit: onEdit,
          onDelete: onDelete,
        );
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
      padding: const EdgeInsets.all(0),
      tooltip: "",
      splashRadius: 4,
      iconSize: 24,
      icon: const Icon(Remix.more_fill),
      itemBuilder: (c) {
        return [
          _buildPopupMenuItem(
            title: AppHelpers.getTranslation(TrKeys.edit),
            iconData: Remix.edit_2_line,
            onTap: () {
              Navigator.pop(c);
              onEdit();
            },
          ),
          // _buildPopupMenuItem(
          //   title: AppHelpers.getTranslation(TrKeys.delete),
          //   iconData: Remix.delete_bin_3_line,
          //   iconColor: Style.red,
          //   onTap: () {
          //     Navigator.pop(c);
          //     onDelete();
          //   },
          // ),
        ];
      },
    );
  }

  PopupMenuItem _buildPopupMenuItem({
    required String title,
    required IconData iconData,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return PopupMenuItem(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            2.horizontalSpace,
            Icon(iconData, size: 21, color: iconColor ?? Style.black),
            8.horizontalSpace,
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: iconColor ?? Style.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
