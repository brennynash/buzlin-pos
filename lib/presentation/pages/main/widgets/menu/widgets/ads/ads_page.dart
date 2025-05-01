import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../../../comments/widgets/no_item.dart';
import 'widgets/ads_item.dart';

class AdsPage extends ConsumerStatefulWidget {
  const AdsPage({super.key});

  @override
  ConsumerState<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends ConsumerState<AdsPage> {
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(adsProvider.notifier).fetchAds(isRefresh: true),
    );
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.white,
      body: Consumer(
        builder: (cont, ref, child) {
          final state = ref.watch(adsProvider);
          final notifier = ref.read(adsProvider.notifier);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HeaderItem(title: TrKeys.ads),
              Expanded(
                child: SmartRefresher(
                  controller: refreshController,
                  onRefresh: () => notifier.fetchAds(
                    context: context,
                    controller: refreshController,
                    isRefresh: true,
                  ),
                  child: state.isLoading
                      ? const Center(child: Loading())
                      : state.list.isEmpty
                          ? NoItem(
                              title: AppHelpers.getTranslation(TrKeys.noData))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.list.length,
                              padding: REdgeInsets.only(
                                  right: 16, top: 20, left: 16, bottom: 100),
                              itemBuilder: (cont, index) => AdsItem(
                                ads: state.list[index],
                                purchase: () {
                                  notifier.purchaseAds(context, index: index,
                                      updated: () {
                                    notifier.fetchAds(
                                        isRefresh: true,
                                        context: context,
                                        controller: refreshController);
                                  });
                                },
                              ),
                            ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
