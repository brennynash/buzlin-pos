import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class DeliverymanScreen extends StatelessWidget {
  final OrderData? orderData;
  final UserData? selectUser;
  final ValueChanged? onChanged;
  final VoidCallback setDeliveryman;

  const DeliverymanScreen(
      {super.key,
      required this.orderData,
      this.selectUser,
      this.onChanged,
      required this.setDeliveryman});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Style.borderColor),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.deliveryman),
                style: GoogleFonts.inter(
                    fontSize: 24, fontWeight: FontWeight.w700),
              ),
              (LocalStorage.getUser()?.role == TrKeys.admin) &&
                      (orderData?.status == TrKeys.ready) &&
                      (orderData?.deliveryType != TrKeys.pickup) &&
                      (orderData?.deliveryman == null)
                  ? ConfirmButton(
                      title:
                          "${AppHelpers.getTranslation(TrKeys.add)} ${AppHelpers.getTranslation(TrKeys.deliveryman)}",
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (contextt) {
                              return AlertDialog(
                                content: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: Style.unselectedBottomBarBack,
                                      width: 1.r,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  height: 56.r,
                                  padding: EdgeInsets.only(left: 8.r),
                                  child: CustomDropdown(
                                    key: UniqueKey(),
                                    hintText: AppHelpers.getTranslation(
                                        TrKeys.selectDeliveryman),
                                    searchHintText: AppHelpers.getTranslation(
                                        TrKeys.search),
                                    dropDownType: DropDownType.categories,
                                    onChanged: onChanged,
                                    initialUser: selectUser,
                                  ),
                                ),
                                actions: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 16.r),
                                    child: SizedBox(
                                      width: 150.w,
                                      child: ConfirmButton(
                                          title: AppHelpers.getTranslation(
                                              TrKeys.save),
                                          onTap: () {
                                            selectUser == null
                                                ? null
                                                : setDeliveryman();
                                            context.maybePop();
                                          }),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      height: 48.r,
                    )
                  : const SizedBox.shrink()
            ],
          ),
          16.verticalSpace,
          orderData?.deliveryType == TrKeys.pickup
              ? Text(
                  AppHelpers.getTranslation(TrKeys.typePickup),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                  ),
                )
              : orderData?.deliveryman != null
                  ? Row(
                      children: [
                        CommonImage(
                          url: orderData?.deliveryman?.img,
                          width: 60.r,
                          height: 60.r,
                          radius: 30.r,
                        ),
                        16.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${orderData?.deliveryman?.firstname ?? ""} ${orderData?.deliveryman?.lastname ?? ""}",
                                style: GoogleFonts.inter(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              4.verticalSpace,
                              Text(
                                AppHelpers.getTranslation(
                                    orderData?.deliveryman?.role ?? ""),
                                style: GoogleFonts.inter(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: orderData?.deliveryman?.phone ?? "",
                            );
                            await launchUrl(launchUri);
                          },
                          child: ButtonEffectAnimation(
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Style.black, shape: BoxShape.circle),
                              padding: EdgeInsets.all(10.r),
                              child: const Icon(
                                Remix.phone_fill,
                                color: Style.white,
                              ),
                            ),
                          ),
                        ),
                        8.horizontalSpace,
                        InkWell(
                          onTap: () async {
                            final Uri launchUri = Uri(
                              scheme: 'sms',
                              path: orderData?.deliveryman?.phone ?? "",
                            );
                            await launchUrl(launchUri);
                          },
                          child: ButtonEffectAnimation(
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Style.black, shape: BoxShape.circle),
                              padding: EdgeInsets.all(10.r),
                              child: const Icon(
                                Remix.chat_1_fill,
                                color: Style.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : orderData?.status != "ready"
                      ? Text(
                          AppHelpers.getTranslation(TrKeys.statusReady),
                          style: GoogleFonts.inter(
                            fontSize: 16,
                          ),
                        )
                      : Text(
                          AppHelpers.getTranslation(TrKeys.notAssigned),
                          style: GoogleFonts.inter(
                            fontSize: 16,
                          ),
                        )
        ],
      ),
    );
  }
}
