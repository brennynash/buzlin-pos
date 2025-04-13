import 'package:admin_desktop/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../../components/header_item.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../../../comments/widgets/no_item.dart';
import 'add_looks/add_looks_page.dart';
import 'edit_looks/edit_looks_page.dart';
import 'widgets/looks_item.dart';

class LooksPage extends ConsumerStatefulWidget {
  const LooksPage({super.key});

  @override
  ConsumerState<LooksPage> createState() => _LooksPageState();
}

class _LooksPageState extends ConsumerState<LooksPage> {
  late RefreshController refreshController;

  @override
  void initState() {
    refreshController = RefreshController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(looksProvider.notifier)
          .fetchLooks(context: context, isRefresh: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bg,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const HeaderItem(title: TrKeys.looks),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(looksProvider);
                final notifier = ref.read(looksProvider.notifier);
                return state.isLoading
                    ? const Center(child: Loading())
                    : SmartRefresher(
                        controller: refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh: () => notifier.fetchLooks(
                          context: context,
                          isRefresh: true,
                          controller: refreshController,
                        ),
                        onLoading: () => notifier.fetchLooks(
                          context: context,
                          controller: refreshController,
                        ),
                        child: state.looks.isEmpty
                            ? const NoItem(title: TrKeys.noLooks)
                            : AnimationLimiter(
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(
                                    top: 16,
                                    bottom: 56,
                                    left: 12,
                                    right: 12,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: state.looks.length,
                                  itemBuilder: (context, index) =>
                                      AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: AppConstants.animationDuration,
                                    child: ScaleAnimation(
                                      scale: 0.5,
                                      child: FadeInAnimation(
                                        child: LooksItem(
                                          look: state.looks[index],
                                          spacing: 10,
                                          onTap: () {
                                            refreshController.resetNoData();
                                            ref
                                                .read(
                                                    editLooksProvider.notifier)
                                                .setDetails(
                                                  state.looks[index],
                                                );
                                            AppHelpers.showAlertDialog(
                                                backgroundColor: Style.bg,
                                                context: context,
                                                child: SizedBox(
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height /
                                                          1.5,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width /
                                                          2,
                                                  child: EditLooksPage(
                                                      state.looks[index].id ??
                                                          0),
                                                ));
                                          },
                                          onDelete: () {
                                            ref
                                                .read(looksProvider.notifier)
                                                .deleteDiscount(
                                                  context,
                                                  state.looks[index].id,
                                                );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppHelpers.showAlertDialog(
              context: context,
              child: SizedBox(
                height: 0.67.sh,
                width: 0.5.sw,
                child: const AddLooksPage(),
              ));
          //notifier.addTextField();
        },
        backgroundColor: Style.primary,
        child: const Icon(Remix.add_fill),
      ),
    );
  }
}
