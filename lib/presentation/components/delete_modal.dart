import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'buttons/custom_button.dart';

class DeleteModal extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteModal({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          40.verticalSpace,
          Text(
            '${AppHelpers.getTranslation(TrKeys.areYouSureToDelete)}?',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 18,
              color: Style.black,
              fontWeight: FontWeight.w500,
              letterSpacing: -14 * 0.02,
            ),
          ),
          36.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  title: TrKeys.cancel,
                  onTap: context.maybePop,
                  bgColor: Style.transparent,
                  borderColor: Style.black,
                  textColor: Style.textColor,
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    return CustomButton(
                      title: AppHelpers.getTranslation(TrKeys.yes),
                      //isLoading: ref.watch(discountProvider).isLoading,
                      onTap: () {
                        onDelete.call();
                         context.maybePop();
                      },
                      bgColor: Style.red,
                      borderColor: Style.red,
                    );
                  },
                ),
              ),
            ],
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
