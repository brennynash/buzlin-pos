import 'package:admin_desktop/application/comments/comments_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/application/comments/comments_notifier.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../styles/style.dart';

class ShopCommentsItem extends StatelessWidget {
  final ShopCommentsData shopCommentsData;
  final int spacing;
  final int index;
  final CommentsState state;
  final CommentsNotifier notifier;

  const ShopCommentsItem({
    super.key,
    required this.shopCommentsData,
    this.spacing = 1,
    required this.index,
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2,
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      margin: EdgeInsets.only(bottom: spacing.r),
      padding: REdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CommonImage(
                      width: 36,
                      height: 36,
                      url: shopCommentsData.user?.img,
                      errorRadius: 0,
                      radius: 18,
                      fit: BoxFit.cover,
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 50.r,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                '${shopCommentsData.user?.firstname ?? ""} ${shopCommentsData.user?.lastname ?? ''}',
                                style: Style.interNormal(
                                  size: 14,
                                  color: Style.black,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  TimeService.dateFormatForOrder(shopCommentsData.updatedAt),
                  style: Style.interRegular(
                    size: 12,
                    color: Style.textColor,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              Expanded(
                  child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      color: Style.colorGrey,
                    ),
                    height: 6.r,
                    width: 6.r,
                  ),
                  8.horizontalSpace,
                  Icon(
                    Remix.star_smile_fill,
                    color: Style.starColor,
                    size: 20.r,
                  ),
                  8.horizontalSpace,
                  Text(
                    '${shopCommentsData.rating?.toDouble() ?? ""}',
                    style: Style.interNormal(
                      size: 16,
                      color: Style.black,
                      letterSpacing: -0.3,
                    ),
                  )
                ],
              )),
              12.horizontalSpace,
            ],
          ),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                  onTap: () => notifier.changeSelectShopComment(index),
                  child: state.selectedShopComment == index
                      ? Icon(
                          Remix.arrow_up_s_line,
                          size: 30.r,
                        )
                      : Icon(
                          Remix.arrow_down_s_line,
                          size: 30.r,
                        )),
              10.horizontalSpace,
            ],
          ),
          (state.selectedShopComment == index)
              ? Column(
                  children: [
                    16.verticalSpace,
                    Text(
                      state.shopComments[index].comment ?? "",
                      style: Style.interMedium(size: 16.sp, color: Style.black),
                    ),
                    12.verticalSpace,
                  ],
                )
              : const SizedBox.shrink()
          // Text(
          //   shopCommentsData.comment ?? '',
          //   style: Style.interRegular(
          //     size: 14,
          //     color: Style.textColor,
          //     letterSpacing: -0.3,
          //   ),
          // ),
        ],
      ),
    );
  }
}
