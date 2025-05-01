import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../color_item.dart';

class GroupExtrasItem extends StatelessWidget {
  final Extras extras;
  final Function() onTap;
  final bool isSelected;

  const GroupExtrasItem({
    super.key,
    required this.extras,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 21,
                    height: 21,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Style.primary : Style.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: !isSelected ? Style.textHint : Style.primary),
                    ),
                    child: const Icon(
                      Remix.check_line,
                      color: Style.white,
                      size: 16,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Text(
                      AppHelpers.getNameColor(extras.value),
                      style: Style.interRegular(
                        size: 16,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  if (extras.group?.type == ExtrasType.color.name)
                    ColorItem(extras: extras)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
