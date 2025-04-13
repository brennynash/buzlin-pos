
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/presentation/components/buttons/custom_refresher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../application/product/product_notifier.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

part 'category_list_item.dart';

part 'list_main_item.dart';

class CategoryListView extends ConsumerStatefulWidget {
  const CategoryListView({super.key});

  @override
  ConsumerState<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends ConsumerState<CategoryListView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(foodCategoriesProvider);
    final notifier = ref.read(foodCategoriesProvider.notifier);
    return CustomScaffold(
      body: (s) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Column(
          children: [
            _appBar(),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ConfirmButton(
                  title: TrKeys.addCategory,
                  onTap: () {
                    ref.read(createCategoryProvider.notifier).clear();
                    ref.read(productProvider.notifier).changeState(6);
                  },
                ),
                16.horizontalSpace,
              ],
            ),
            8.verticalSpace,
            Expanded(
                child: ListMainItem(
              hasMore: false,
              onViewMore: () {
                notifier.fetchCategories(context: context);
              },
              isLoading: state.isLoading,
              notifier: notifier,
              state: state,
              editCategoryNotifier: ref.read(editCategoryProvider.notifier),
              editCategoryParentNotifier:
                  ref.read(editCategoryParentProvider.notifier),
              productNotifier: ref.read(productProvider.notifier),
            ))
          ],
        ),
      ),
    );
  }

  _appBar() {
    final notifier = ref.read(foodCategoriesProvider.notifier);
    final state = ref.watch(foodCategoriesProvider);
    return Container(
      padding: REdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppHelpers.getTranslation(TrKeys.categories),
                  style: Style.interMedium(size: 20),
                ),
              ),
              CustomRefresher(
                onTap: () {
                  notifier.initialFetchCategories();
                },
                isLoading: state.isLoading,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
