import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../components.dart';

class MasterItem extends StatelessWidget {
  final UserData master;
  final double height;
  final bool selectService;
  final VoidCallback? onTap;

  const MasterItem(
      {super.key,
      required this.master,
      this.height = 198,
      this.selectService = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap?.call();
          return;
        }
      },
      child: Container(
        width: 220.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Style.icon),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonImage(
                  url: master.img,
                  height: height,
                  width: 220,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.r, vertical: 14.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${master.firstname ?? ""} ${master.lastname ?? ""}",
                        style: Style.interNormal(size: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Text(
                            AppHelpers.getTranslation(TrKeys.startFrom),
                            style: Style.interRegular(size: 14),
                          ),
                          const Spacer(),
                          Text(
                            AppHelpers.numberFormat(
                              number: selectService
                                  ? master.serviceMaster?.totalPrice
                                  : master.serviceMaster?.price,
                            ),
                            style: Style.interSemi(size: 16),
                          ),
                        ],
                      ),
                      if (selectService)
                        Padding(
                          padding: EdgeInsets.only(top: 8.r),
                          child: Row(
                            children: [
                              Text(
                                AppHelpers.getTranslation(TrKeys.type),
                                style: Style.interRegular(size: 14),
                              ),
                              const Spacer(),
                              Text(
                                AppHelpers.getTranslation(
                                    master.serviceMaster?.type ?? ""),
                                style: Style.interNormal(size: 16),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              right: 12.r,
              top: (height - 12).r,
              child: Container(
                height: 30.r,
                width: 30.r,
                decoration: BoxDecoration(
                  color: Style.white.withOpacity(0.9),
                  border: Border.all(color: Style.icon),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    master.rAvg?.toStringAsFixed(1) ?? "0",
                    style: Style.interNormal(size: 12),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
