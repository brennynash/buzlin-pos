import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';
import '../../looks/widgets/product_list_item.dart';

class MultiSelectionWidget extends ConsumerStatefulWidget {
  const MultiSelectionWidget({super.key});

  @override
  ConsumerState<MultiSelectionWidget> createState() =>
      _MultiSelectionWidgetState();
}

class _MultiSelectionWidgetState extends ConsumerState<MultiSelectionWidget> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (ref.watch(mainProvider).products.isEmpty) {
          ref.read(mainProvider.notifier).fetchProducts(isRefresh: true);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mainProvider);
    final notifier = ref.read(mainProvider.notifier);
    final adsNotifier = ref.read(createAdsProvider.notifier);
    final adsState = ref.watch(createAdsProvider);
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: state.isProductsLoading
                ? const Loading()
                : SmartRefresher(
                    controller: _refreshController,
                    enablePullUp: true,
                    onRefresh: () => notifier.fetchProducts(isRefresh: true),
                    onLoading: () => notifier.fetchProducts(),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.products.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ProductListItem(
                          product: state.products[index],
                          isSelected: adsState.products.any((element) =>
                              element.id == state.products[index].id),
                          onTap: () {
                            adsNotifier.setProducts(state.products[index]);
                          },
                        );
                      },
                    ),
                  ),
          ),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  bgColor: Style.primary,
                  textColor: Style.white,
                  // height: 54,
                  isLoading: adsState.isLoading,
                  title: AppHelpers.getTranslation(TrKeys.assign),
                  onTap: () {
                    adsNotifier.assignAds(context);
                  },
                ),
              ),
            ],
          ),
          24.verticalSpace,
        ],
      ),
    );
  }
}
