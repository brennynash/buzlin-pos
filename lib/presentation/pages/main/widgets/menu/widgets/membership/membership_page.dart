import 'package:admin_desktop/presentation/pages/main/widgets/menu/widgets/membership/add/add_membership_page.dart';
import 'package:admin_desktop/presentation/pages/main/widgets/menu/widgets/membership/edit/edit_membership_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../../components/delete_modal.dart';
import '../../../comments/widgets/no_item.dart';
import 'widget/membership_item.dart';

class MembershipPage extends ConsumerStatefulWidget {
  const MembershipPage({super.key});

  @override
  ConsumerState<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends ConsumerState<MembershipPage> {
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(membershipProvider.notifier)
          .fetchMemberships(isRefresh: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          LocalStorage.getLangLtr() ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(membershipProvider);
            final notifier = ref.read(membershipProvider.notifier);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.membership),
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
                  child: state.isLoading
                      ? const Center(child: Loading())
                      : state.list.isEmpty
                          ? NoItem(
                              title:
                                  AppHelpers.getTranslation(TrKeys.membership))
                          : ListView(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.list.length,
                                  padding: REdgeInsets.all(12),
                                  itemBuilder: (context, index) {
                                    return MembershipItem(
                                      membership: state.list[index],
                                      onEdit: () {
                                        AppHelpers.showAlertDialog(
                                            context: context,
                                            backgroundColor: Style.bg,
                                            child: SizedBox(
                                              height: 0.67.sh,
                                              width: 0.5.sw,
                                              child: EditMembershipPage(
                                                membership: state.list[index],
                                              ),
                                            ));
                                      },
                                      onDelete: () {
                                        AppHelpers.showAlertDialog(
                                          context: context,
                                          child: DeleteModal(
                                            onDelete: () {
                                              notifier.deleteMembership(
                                                context,
                                                state.list[index].id,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                if(state.hasMore)
                                ViewMoreButton(
                                    onTap: () {
                                      notifier.fetchMemberships(
                                        context: context);
                                    })
                              ],
                            ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AppHelpers.showAlertDialog(
                context: context,
                backgroundColor: Style.bg,
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height / 1.5,
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: const AddMembershipPage(),
                ));
            //notifier.addTextField();
          },
          backgroundColor: Style.primary,
          child: const Icon(Remix.add_fill),
        ),
      ),
    );
  }
}
