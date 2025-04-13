import 'package:admin_desktop/application/catalogue/catalogue_provider.dart';
import 'package:admin_desktop/application/masters/edit/edit_masters_provider.dart';
import 'package:admin_desktop/presentation/pages/main/widgets/orders_table/icon_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class DragItem extends ConsumerWidget {
  final UserData userData;
  final bool isDrag;

  const DragItem({super.key, required this.userData, this.isDrag = false});

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      child: Transform.rotate(
        angle: isDrag ? (3.14 * (0.03)) : 0,
        child: Container(
          foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isDrag ? Style.iconColor.withOpacity(0.3) : null),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Style.white),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonImage(
                    url: userData.img,
                    height: 42,
                    width: 42,
                    radius: 32,
                    isResponsive: false,
                  ),
                  6.horizontalSpace,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${userData.firstname ?? ""} ${userData.lastname ?? ""}',
                            maxLines: 1,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Style.black,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            AppHelpers.getTranslation(userData.role ?? ''),
                            style: GoogleFonts.inter(
                                fontSize: 14, color: Style.hint),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              6.verticalSpace,
              const Divider(height: 2),
              12.verticalSpace,
              IconTitle(
                icon: Remix.calendar_2_line,
                value: TimeService.dateFormatMDHm(userData.registeredAt),
              ),
              if (userData.phone?.isNotEmpty ?? false)
                Column(
                  children: [
                    4.verticalSpace,
                    IconTitle(
                      icon: Remix.phone_line,
                      value: userData.phone ?? '',
                    ),
                  ],
                ),
              12.verticalSpace,
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Style.borderColor),
                  ),
                  child: Row(
                    children: [
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppHelpers.getTranslation(userData.email ?? ""),
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Style.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(4),
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            border: Border.all(color: Style.black),
                            shape: BoxShape.circle),
                        child: (userData.gender) == TrKeys.female
                            ? Icon(
                                Remix.women_line,
                                size: 18.r,
                              )
                            : Icon(
                                Remix.men_line,
                                size: 18.r,
                              ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
      onTap: () {
        ref.read(editMastersProvider.notifier).changeIndex(0);
        ref.read(editMastersProvider.notifier).setMaster(userData).then((v) {
          ref.read(catalogueProvider.notifier).changeState(9);
        });
        // ref.read(mainProvider.notifier).setOrder(userData);
      },
    );
  }
}
