// ignore_for_file: unrelated_type_equality_checks
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'widgets/document.dart';
import 'widgets/products.dart';
import 'widgets/status_screen.dart';
import 'widgets/tracking_information.dart';
import 'widgets/user_information.dart';

class OrderDetailPage extends ConsumerStatefulWidget {
  final OrderData order;

  const OrderDetailPage({super.key, required this.order});

  @override
  ConsumerState<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends ConsumerState<OrderDetailPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(orderDetailsProvider);
      ref.read(orderDetailsProvider.notifier)
        ..fetchOrderDetails(order: widget.order)
        ..fetchUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderDetailsProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Style.mainBack,
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                CustomBackButton(
                    onTap: () =>
                        ref.read(mainProvider.notifier).setOrder(null)),
                const Spacer(),
                InvoiceDownload(orderData: state.order),
                16.horizontalSpace,
                if (LocalStorage.getShop()?.deliveryType == 2)
                  ConfirmButton(
                    title: AppHelpers.getTranslation(TrKeys.statusChanged),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return _changeStatusDialog(state, context);
                          });
                    },
                    height: 52,
                  )
              ],
            ),
            16.verticalSpace,
            StatusScreen(
                orderDataStatus: state.order?.status ?? "",
                shop: LocalStorage.getShop() ?? ShopData()),
            16.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      DocumentScreen(order: state.order),
                      24.verticalSpace,
                      ProductsScreen(orderData: state.order)
                    ],
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      UserInformation(order: state.order),
                      // 16.verticalSpace,
                      // DeliverymanScreen(
                      //   orderData: state.order,
                      //   selectUser: state.selectedUser,
                      //   onChanged: (v) => ref
                      //       .read(orderDetailsProvider.notifier)
                      //       .setUsersQuery(context, v),
                      //   setDeliveryman: () => ref
                      //       .read(orderDetailsProvider.notifier)
                      //       .setDeliveryMan(context),
                      // ),
                      16.verticalSpace,
                      TrackingInformation(order: state.order),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AlertDialog _changeStatusDialog(
      OrderDetailsState state, BuildContext context) {
    return AlertDialog(
      content: PopupMenuButton<String>(
        itemBuilder: (context) {
          return [
            PopupMenuItem<String>(
              value: AppHelpers.getOrderStatusText(
                  AppHelpers.getOrderStatus(state.order?.status)),
              child: Text(
                AppHelpers.getTranslation(AppHelpers.getOrderStatusText(
                    AppHelpers.getOrderStatus(state.order?.status))),
                style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Style.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            PopupMenuItem<String>(
              value: AppHelpers.getOrderStatusText(AppHelpers.getOrderStatus(
                  state.order?.status,
                  isNextStatus: true)),
              child: Text(
                AppHelpers.getTranslation(AppHelpers.getOrderStatusText(
                    AppHelpers.getOrderStatus(state.order?.status,
                        isNextStatus: true))),
                style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Style.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            PopupMenuItem<String>(
              value: AppHelpers.getTranslation(TrKeys.cancel),
              child: Text(
                AppHelpers.getTranslation(TrKeys.cancel),
                style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Style.black,
                    fontWeight: FontWeight.w500),
              ),
            )
          ];
        },
        onSelected: (s) {
          ref.read(orderDetailsProvider.notifier).changeStatus(s);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        color: Style.white,
        elevation: 10,
        child: Consumer(builder: (context, ref, child) {
          return SelectFromButton(
            title: AppHelpers.getTranslation(AppHelpers.getOrderStatusText(
                AppHelpers.getOrderStatus(
                    ref.watch(orderDetailsProvider).status.isEmpty
                        ? ref.watch(orderDetailsProvider).order?.status
                        : ref.watch(orderDetailsProvider).status))),
          );
        }),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.r),
          child: SizedBox(
            width: 150.w,
            child: ConfirmButton(
                title: AppHelpers.getTranslation(TrKeys.save),
                onTap: () {
                  ref.watch(orderDetailsProvider).status.isEmpty
                      ? null
                      : ref
                          .read(orderDetailsProvider.notifier)
                          .updateOrderStatus(
                              status: AppHelpers.getOrderStatus(
                                  ref.watch(orderDetailsProvider).status));
                  context.maybePop();
                }),
          ),
        ),
      ],
    );
  }
}
