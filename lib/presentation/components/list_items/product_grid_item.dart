import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/domain/models/models.dart';
import '../components.dart';
import 'get_color_list.dart';

class ProductGridItem extends StatelessWidget {
  final ProductData product;
  final Function() onTap;
  final bool isReplaceOrder;

  ProductGridItem({
    super.key,
    required this.product,
    required this.onTap,
    this.isReplaceOrder = false,
  });

  final List<Extras> listExtra = [];

  void setColorList() {
    product.stocks?.forEach((stocks) {
      stocks.extras?.forEach((extra) {
        if (extra.group?.type == "color") {
          if (listExtra.isEmpty) {
            listExtra.add(extra);
            return;
          }
          for (var element in listExtra) {
            if (element.value == extra.value) {
              return;
            }
          }
          listExtra.add(extra);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setColorList();
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Style.white,
        ),
        constraints: BoxConstraints(
          maxWidth: 227.r,
          maxHeight: 246.r,
        ),
        padding: REdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        topLeft: Radius.circular(10.r),
                      ),
                      child: Stack(
                        children: [
                          CommonImage(
                            url: product.img,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            radius: 0,
                          ),
                          ColorListWidget(listExtra),
                        ],
                      ))),
            ),
            16.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.translation?.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -14 * 0.02,
                      color: Style.black,
                    ),
                  ),
                  6.verticalSpace,
                  if (!isReplaceOrder)
                    ProductPriceWidget(
                      product: product,
                      stock: (product.stocks?.isNotEmpty ?? false)
                          ? product.stocks?.first
                          : null,
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
