import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../comments/widgets/no_item.dart';
import 'widget/user_membership_item.dart';
import 'package:flutter/material.dart';

class UserMembershipPage extends ConsumerStatefulWidget {
  const UserMembershipPage({super.key});

  @override
  ConsumerState<UserMembershipPage> createState() => _UserMembershipPageState();
}

class _UserMembershipPageState extends ConsumerState<UserMembershipPage> {
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(userMembershipProvider.notifier)
          .fetchMemberships(isRefresh: true),
    );
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          LocalStorage.getLangLtr() ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(userMembershipProvider);
            final notifier = ref.read(userMembershipProvider.notifier);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.userMembership),
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Style.black),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                           context.maybePop();
                        },
                        icon: const Icon(Remix.close_fill))
                  ],
                ),
                Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    onRefresh: () => notifier.fetchMemberships(
                      context: context,
                      controller: refreshController,
                      isRefresh: true,
                    ),
                    enablePullDown: true,
                    enablePullUp: true,
                    child: state.isLoading
                        ? const Center(child: Loading())
                        : state.list.isEmpty
                            ? NoItem(
                                title: AppHelpers.getTranslation(
                                    TrKeys.noSubCategoryItems),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.list.length,
                                padding: REdgeInsets.all(12),
                                itemBuilder: (context, index) {
                                  return UserMembershipItem(
                                    membership: state.list[index],
                                  );
                                },
                              ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
