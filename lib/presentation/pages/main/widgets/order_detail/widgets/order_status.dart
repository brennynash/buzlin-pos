import 'package:admin_desktop/presentation/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../styles/style.dart';
import 'dialog_status.dart';
import 'order_status_item.dart';

class OrderStatusScreen extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusScreen({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.editProfileCircle,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          12.horizontalSpace,
          Column(
            children: [
              Text(
                  AppHelpers.getTranslation(
                      AppHelpers.getOrderStatusText(status)),
                  style: Style.interNormal(size: 16)),
            ],
          ),
          36.horizontalSpace,
          status == OrderStatus.canceled
              ? Row(
                  children: [
                    OrderStatusItem(
                      icon: Icon(
                        Icons.done_all,
                        size: 24.r,
                      ),
                      bgColor: Style.red,
                      isActive: true,
                      isProgress: false,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 6.h,
                      width: 12.w,
                      decoration: const BoxDecoration(
                        color: Style.red,
                      ),
                    ),
                    OrderStatusItem(
                      icon: Icon(
                        Icons.restaurant_rounded,
                        size: 24.r,
                        color: Style.black,
                      ),
                      bgColor: Style.red,
                      isActive: true,
                      isProgress: false,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 6.r,
                      width: 12.r,
                      decoration: const BoxDecoration(
                        color: Style.red,
                      ),
                    ),
                    OrderStatusItem(
                      icon: SvgPicture.asset(
                        Assets.svgDelivery2,
                        width: 26.r,
                      ),
                      bgColor: Style.red,
                      isActive: true,
                      isProgress: false,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 6.r,
                      width: 12.r,
                      decoration: const BoxDecoration(
                        color: Style.red,
                      ),
                    ),
                    OrderStatusItem(
                      icon: Icon(
                        Icons.flag,
                        size: 24.r,
                      ),
                      bgColor: Style.red,
                      isActive: true,
                      isProgress: false,
                    ),
                  ],
                )
              : status == OrderStatus.delivered
                  ? Row(
                      children: [
                        OrderStatusItem(
                          icon: Icon(
                            Icons.done_all,
                            size: 24.r,
                            color: Style.white,
                          ),
                          bgColor: Style.primary,
                          isActive: true,
                          isProgress: false,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: 6.h,
                          width: 12.w,
                          decoration: const BoxDecoration(
                            color: Style.primary,
                          ),
                        ),
                        OrderStatusItem(
                          icon: Icon(
                            Icons.restaurant_rounded,
                            size: 24.r,
                            color: Style.white,
                          ),
                          bgColor: Style.primary,
                          isActive: true,
                          isProgress: false,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: 6.r,
                          width: 12.r,
                          decoration: const BoxDecoration(
                            color: Style.primary,
                          ),
                        ),
                        OrderStatusItem(
                          icon: SvgPicture.asset(
                            Assets.svgDelivery2,
                            width: 26.r,
                          ),
                          bgColor: Style.primary,
                          isActive: true,
                          isProgress: false,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: 6.r,
                          width: 12.r,
                          decoration: const BoxDecoration(
                            color: Style.primary,
                          ),
                        ),
                        OrderStatusItem(
                          icon: Icon(
                            Icons.flag,
                            size: 24.r,
                            color: Style.white,
                          ),
                          bgColor: Style.primary,
                          isActive: true,
                          isProgress: false,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        OrderStatusItem(
                          icon: Icon(
                            Icons.done_all,
                            size: 24.r,
                            color: status != OrderStatus.newOrder
                                ? Style.white
                                : Style.black,
                          ),
                          isActive: status != OrderStatus.newOrder,
                          isProgress: status == OrderStatus.newOrder,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: 6.r,
                          width: 12.r,
                          decoration: BoxDecoration(
                            color: status != OrderStatus.newOrder
                                ? Style.primary
                                : Style.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (LocalStorage.getUser()?.role == TrKeys.admin) {
                              AppHelpers.showAlertDialog(
                                  context: context,
                                  child: const DialogStatus(
                                      orderStatus: OrderStatus.ready));
                            }
                          },
                          child: ButtonEffectAnimation(
                            child: OrderStatusItem(
                              icon: Icon(
                                Icons.restaurant_rounded,
                                size: 24.r,
                                color: status == OrderStatus.ready ||
                                        status == OrderStatus.onAWay
                                    ? Style.white
                                    : Style.black,
                              ),
                              isActive: status == OrderStatus.ready ||
                                  status == OrderStatus.onAWay,
                              isProgress: status == OrderStatus.accepted,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: 6.r,
                          width: 12.r,
                          decoration: BoxDecoration(
                            color: status == OrderStatus.ready ||
                                    status == OrderStatus.onAWay
                                ? Style.primary
                                : Style.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (LocalStorage.getUser()?.role == TrKeys.admin) {
                              AppHelpers.showAlertDialog(
                                  context: context,
                                  child: const DialogStatus(
                                      orderStatus: OrderStatus.onAWay));
                            }
                          },
                          child: ButtonEffectAnimation(
                            child: OrderStatusItem(
                              icon: SvgPicture.asset(
                                status == OrderStatus.onAWay
                                    ? Assets.svgDelivery2
                                    : Assets.svgDelivery,
                                width: 26.r,
                              ),
                              isActive: status == OrderStatus.onAWay,
                              isProgress: status == OrderStatus.ready ||
                                  status == OrderStatus.delivered,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: 6.r,
                          width: 12.r,
                          decoration: BoxDecoration(
                            color: status == OrderStatus.onAWay
                                ? Style.primary
                                : Style.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (LocalStorage.getUser()?.role == TrKeys.admin) {
                              AppHelpers.showAlertDialog(
                                  context: context,
                                  child: const DialogStatus(
                                      orderStatus: OrderStatus.delivered));
                            }
                          },
                          child: ButtonEffectAnimation(
                            child: OrderStatusItem(
                              icon: Icon(
                                Icons.flag,
                                size: 24.r,
                              ),
                              isActive: false,
                              isProgress: false,
                            ),
                          ),
                        ),
                      ],
                    )
        ],
      ),
    );
  }
}
