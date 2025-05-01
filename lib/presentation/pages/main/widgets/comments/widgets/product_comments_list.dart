import 'package:admin_desktop/application/comments/comments_state.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:admin_desktop/application/comments/comments_notifier.dart';
import '../../../../../components/buttons/view_more_button.dart';
import 'no_item.dart';
import 'product_comment_item.dart';

class ProductCommentsList extends StatelessWidget {
  final CommentsState commentsState;
  final CommentsNotifier notifier;

  const ProductCommentsList({
    super.key,
    required this.commentsState,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return commentsState.productComments.isEmpty
        ? const NoItem(title: TrKeys.noComments)
        : ListView(
            children: [
              AnimationLimiter(
                child: ListView.separated(
                  padding: REdgeInsets.only(
                    top: 16,
                    bottom: 32,
                    left: 12,
                    right: 12,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: commentsState.productComments.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: ScaleAnimation(
                        scale: 0.5,
                        child: FadeInAnimation(
                          child: Column(
                            children: [
                              CommentItem(
                                index: index,
                                commentsData:
                                    commentsState.productComments[index],
                                state: commentsState,
                                notifier: notifier,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return 10.verticalSpace;
                  },
                ),
              ),
              commentsState.hasMoreProductComment &&
                      commentsState.productComments.isNotEmpty
                  ? Padding(
                      padding: REdgeInsets.symmetric(horizontal: 15),
                      child: ViewMoreButton(
                        onTap: () {
                          notifier.fetchProductComments(context: context);
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
  }
}
