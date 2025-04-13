import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'product_table.dart';

class ProductsScreen extends StatelessWidget {
  final OrderData? orderData;

  const ProductsScreen({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Style.borderColor),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppHelpers.getTranslation(TrKeys.compositionOrder),
            style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          18.verticalSpace,
          ProductTable(
              detail: orderData?.details, status: orderData?.status ?? "Fail"),
        ],
      ),
    );
  }
}
