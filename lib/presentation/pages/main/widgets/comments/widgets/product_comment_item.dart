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

class CommentItem extends StatelessWidget {
  final CommentsData commentsData;
  final int spacing;
  final int index;
  final CommentsState state;
  final CommentsNotifier notifier;

  const CommentItem({
    super.key,
    required this.commentsData,
    this.spacing = 1,
    required this.index,
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2.5,
                child: Row(
                  children: [
                    CommonImage(
                      width: 48,
                      height: 48,
                      url: commentsData.product?.img,
                      errorRadius: 0,
                      fit: BoxFit.cover,
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            commentsData.product?.translation?.title ??
                                AppHelpers.getTranslation(TrKeys.unKnow),
                            style: Style.interNormal(
                              size: 16,
                              color: Style.black,
                              letterSpacing: -0.3,
                            ),
                          ),
                          4.verticalSpace,
                          Text(
                            commentsData.product?.translation?.description ??
                                AppHelpers.getTranslation(TrKeys.unKnow),
                            style: Style.interRegular(
                              size: 14,
                              color: Style.textColor,
                              letterSpacing: -0.3,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    12.horizontalSpace,
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonImage(
                      width: 44,
                      height: 44,
                      url: commentsData.user?.img,
                      errorRadius: 0,
                      radius: 22,
                      fit: BoxFit.cover,
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              '${commentsData.user?.firstname ?? AppHelpers.getTranslation(TrKeys.unKnow)} ${commentsData.user?.lastname ?? ''}',
                              style: Style.interNormal(
                                size: 14,
                                color: Style.black,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          8.horizontalSpace,
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              TimeService.dateFormatForOrder(
                                  commentsData.updatedAt),
                              style: Style.interRegular(
                                size: 14,
                                color: Style.textColor,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          8.horizontalSpace,
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
                            '${commentsData.rating?.toDouble() ?? ''}',
                            style: Style.interNormal(
                              size: 16,
                              color: Style.black,
                              letterSpacing: -0.3,
                            ),
                          )
                        ],
                      ),
                    ),
                    12.horizontalSpace,
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                  onTap: () => notifier.changeSelectProductComment(index),
                  child: state.selectedProductComment == index
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
          (state.selectedProductComment == index)
              ? Column(
                  children: [
                    16.verticalSpace,
                    Text(
                      state.productComments[index].comment ??
                          AppHelpers.getTranslation(TrKeys.unKnow),
                      style: Style.interMedium(size: 16.sp, color: Style.black),
                    ),
                    12.verticalSpace,
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
