import 'package:admin_desktop/application/brand/add/add_brand_notifier.dart';
import 'package:admin_desktop/application/brand/brand_notifier.dart';
import 'package:admin_desktop/application/product/product_notifier.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/brand/brand_state.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/application/providers.dart';

part 'brand_list_item.dart';

part 'list_main_item.dart';

class BrandListView extends ConsumerStatefulWidget {
  const BrandListView({super.key});

  @override
  ConsumerState<BrandListView> createState() => _BrandListViewState();
}

class _BrandListViewState extends ConsumerState<BrandListView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(brandProvider);
    final notifier = ref.read(brandProvider.notifier);
    return CustomScaffold(
      body:(s)=> Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            16.verticalSpace,
            Expanded(
                child: ListMainItem(
              hasMore: state.hasMore,
              onViewMore: () => notifier.fetchAllBrands(context: context),
              isLoading: state.isLoading,
              notifier: notifier,
              state: state,
              productNotifier: ref.read(productProvider.notifier),
              addBrandNotifier: ref.read(addBrandProvider.notifier),
            ))
          ],
        ),
      ),
    );
  }
}
