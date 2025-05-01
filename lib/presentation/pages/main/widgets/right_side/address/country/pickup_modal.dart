import 'package:admin_desktop/domain/models/models.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../../components/helper/blur_wrap.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class PickUpModal extends StatefulWidget {
  const PickUpModal(
      {super.key, required this.deliveryPoint, required this.onTap});

  final DeliveryPointsData deliveryPoint;
  final ValueChanged<DeliveryPointsData> onTap;

  @override
  State<PickUpModal> createState() => _PickUpModalState();
}

class _PickUpModalState extends State<PickUpModal> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      // isLtr: LocalStorage.getLangLtr(),
      child: BlurWrap(
        radius: BorderRadius.only(
          topRight: Radius.circular(24.r),
          topLeft: Radius.circular(24.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            // color: Style.primary,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24.r),
              topLeft: Radius.circular(24.r),
            ),
          ),
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CommonImage(
                    height: 36,
                    width: 36,
                    radius: 18,
                    url: widget.deliveryPoint.img,
                    fit: BoxFit.cover,
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Text(
                      widget.deliveryPoint.translation?.title ?? "",
                      style: Style.interSemi(size: 16, letterSpacing: -0.3),
                    ),
                  ),
                  Icon(Icons.local_shipping, size: 21.r),
                  4.horizontalSpace,
                  Text(
                    AppHelpers.numberFormat(number: widget.deliveryPoint.price),
                    style: Style.interSemi(size: 16, letterSpacing: -0.3),
                  ),
                ],
              ),
              8.verticalSpace,
              Text(
                widget.deliveryPoint.address?.address ?? "",
                style: Style.interRegular(color: Style.hint, size: 16),
              ),
              8.verticalSpace,
              Row(
                children: [
                  const Icon(
                    Remix.shirt_line,
                    color: Style.black,
                  ),
                  6.horizontalSpace,
                  Text(
                    "${widget.deliveryPoint.fittingRooms ?? 0} ${AppHelpers.getTranslation(TrKeys.fittingRooms)}",
                    style: Style.interSemi(size: 16, letterSpacing: -0.3),
                  ),
                ],
              ),
              24.verticalSpace,
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.deliveryPoint.workingDays?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            widget.deliveryPoint.workingDays?[index].day
                                    ?.toUpperCase() ??
                                "",
                            style: Style.interNormal(color: Style.black),
                          ),
                          const Spacer(),
                          Text(
                            "${widget.deliveryPoint.workingDays?[index].from} - ${widget.deliveryPoint.workingDays?[index].to}",
                            style: Style.interNormal(color: Style.black),
                          ),
                        ],
                      ),
                    );
                  }),
              36.verticalSpace,
              CustomButton(
                  title: AppHelpers.getTranslation(TrKeys.save),
                  bgColor: Style.primary,
                  textColor: Style.white,
                  onTap: () {
                    widget.onTap(widget.deliveryPoint);
                    context.maybePop();
                     context.maybePop();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
