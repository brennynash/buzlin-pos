part of 'list_view.dart';

class ListItem extends StatelessWidget {
  final OrderData orderData;
  final VoidCallback onSelect;
  final bool isSelect;
  final MainNotifier mainNotifier;

  const ListItem({
    super.key,
    required this.orderData,
    required this.onSelect,
    required this.isSelect,
    required this.mainNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => mainNotifier.setOrder(orderData),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: isSelect ? Style.mainBack : Style.white,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: Row(
              children: [
                CustomCheckbox(isActive: isSelect, onTap: onSelect),
                8.horizontalSpace,
                SizedBox(
                  width: 56.w,
                  child: Text(
                    orderData.id.toString(),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Style.brandTitleDivider,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: 140.w,
                  child: Text(
                    orderData.user?.firstname ?? "--",
                    maxLines: 1,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Style.brandTitleDivider,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: 120.w,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            color: AppHelpers.getStatusColor(orderData.status)
                                .withOpacity(0.25),
                            borderRadius: BorderRadius.circular(100)),
                        child: Text(
                          AppHelpers.getTranslation(orderData.status ?? "--"),
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: AppHelpers.getStatusColor(orderData.status),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: 120.w,
                  child: Text(
                    orderData.deliveryman?.firstname ?? "--",
                    maxLines: 1,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Style.brandTitleDivider,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: 100.w,
                  child: Text(
                    AppHelpers.numberFormat(
                      number: orderData.totalPrice,
                      symbol: orderData.currency?.symbol,
                      isOrder: true,
                    ),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Style.brandTitleDivider,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                8.horizontalSpace,
                SizedBox(
                  width: 120.w,
                  child: Text(
                    TimeService.dateFormatMDHm(
                        orderData.createdAt ?? DateTime.now()),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Style.brandTitleDivider,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                8.horizontalSpace,
                Expanded(
                  child: Text(
                    TimeService.dateFormat(orderData.deliveryDate),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Style.brandTitleDivider,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                CustomPopup(
                  isLocation: orderData.deliveryType == TrKeys.delivery,
                  orderData: orderData,
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 2),
      ],
    );
  }
}
