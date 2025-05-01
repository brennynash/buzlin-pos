import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';
import '../add/riverpod/create_service_category_provider.dart';
import '../edit/riverpod/edit_service_category_provider.dart';
import '../riverpod/service_categories_provider.dart';

part 'category_list_item.dart';

part 'list_main_item.dart';

class CategoryListView extends ConsumerWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(serviceCategoriesProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        children: [
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ConfirmButton(
                title: TrKeys.addCategory,
                onTap: () {
                  ref.read(createServiceCategoryProvider.notifier).clear();
                  ref.read(servicesProvider.notifier).changeState(1);
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
              ref
                  .read(serviceCategoriesProvider.notifier)
                  .fetchCategories(context: context);
            },
            isLoading: state.isLoading,
          ))
        ],
      ),
    );
  }
}
