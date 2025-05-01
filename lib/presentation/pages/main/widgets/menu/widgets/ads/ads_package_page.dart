import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../../components/no_data_info.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'widgets/ads_package_item.dart';
import 'widgets/product_multi_selection.dart';

class AdsPackagePage extends ConsumerStatefulWidget {
  const AdsPackagePage({super.key});

  @override
  ConsumerState<AdsPackagePage> createState() => _AdsPackagePageState();
}

class _AdsPackagePageState extends ConsumerState<AdsPackagePage> {
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(adsPackageProvider.notifier).fetchAds(isRefresh: true),
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
        builder: (context, ref, child) {
          final state = ref.watch(adsPackageProvider);
          final notifier = ref.read(adsPackageProvider.notifier);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HeaderItem(title: TrKeys.adPackages),
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
                          ? NoDataInfo(
                              title: AppHelpers.getTranslation(TrKeys.noData))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.list.length,
                              padding: REdgeInsets.only(
                                  right: 16, top: 20, left: 16, bottom: 100),
                              itemBuilder: (context, index) => AdsPackagesItem(
                                ads: state.list[index],
                                assign: () {
                                  ref
                                      .read(createAdsProvider.notifier)
                                      .setPackage(state.list[index]);
                                  AppHelpers.showAlertDialog(
                                    context: context,
                                    child: SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                1.5,
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                2,
                                        child: const MultiSelectionWidget()),
                                  );
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
