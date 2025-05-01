import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../styles/style.dart';
import '../product/widgets/view_mode.dart';
import 'widgets/product_comments_list.dart';
import 'widgets/shop_comments_list.dart';

class CommentsPage extends ConsumerStatefulWidget {
  const CommentsPage({super.key});

  @override
  ConsumerState<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends ConsumerState<CommentsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(commentsProvider.notifier)
        ..fetchProductComments(isRefresh: true)
        ..fetchShopComments();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(commentsProvider.notifier);
    final state = ref.watch(commentsProvider);
    return CustomScaffold(
        body: (colors) => state.isLoading
            ? const Center(
                child: Loading(),
              )
            : Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.r, horizontal: 16.r),
                    decoration: const BoxDecoration(color: Style.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppHelpers.getTranslation(TrKeys.comments),
                              style: Style.interMedium(size: 20),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                ViewMode(
                                  title: AppHelpers.getTranslation(TrKeys.shop),
                                  isActive: state.stateIndex == 0,
                                  isLeft: true,
                                  onTap: () => notifier.changeState(0),
                                ),
                                ViewMode(
                                  title:
                                      AppHelpers.getTranslation(TrKeys.product),
                                  isActive: state.stateIndex == 1,
                                  isRight: true,
                                  onTap: () => notifier.changeState(1),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: state.stateIndex == 1
                          ? ProductCommentsList(
                              commentsState: state,
                              notifier: notifier,
                            )
                          : ShopCommentsList(
                              commentsState: state,
                              notifier: notifier,
                            )),
                ],
              ));
  }
}
