import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../domain/models/models.dart';
import '../../../../../../../components/components.dart';
import '../../../../product/category/widgets/food_category_item.dart';
import '../../../../services/widgets/category/riverpod/service_categories_provider.dart';

class ServiceCategoriesModal extends ConsumerStatefulWidget {
  final ValueChanged<CategoryData> onChange;

  const ServiceCategoriesModal({super.key, required this.onChange});

  @override
  ConsumerState<ServiceCategoriesModal> createState() =>
      _MultiSelectionWidgetState();
}

class _MultiSelectionWidgetState extends ConsumerState<ServiceCategoriesModal> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (ref.watch(serviceCategoriesProvider).categories.isEmpty) {
          ref
              .read(serviceCategoriesProvider.notifier)
              .fetchCategories(context: context, isRefresh: true);
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
    final state = ref.watch(serviceCategoriesProvider);
    // final notifier = ref.read(serviceCategoriesProvider.notifier);
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: state.isLoading
                ? const Loading()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.categories.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FoodCategoryItem(
                        category: state.categories[index],
                        onSelect: (category) {},
                        onChange: (category) {
                          widget.onChange(category);
                        },
                      );
                    },
                  ),
          ),
          24.verticalSpace,
        ],
      ),
    );
  }
}
