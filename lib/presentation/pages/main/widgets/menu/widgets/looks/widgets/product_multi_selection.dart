import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../../../application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import 'product_list_item.dart';

class MultiSelectionWidget extends ConsumerStatefulWidget {
  final bool isEdit;

  const MultiSelectionWidget({super.key, this.isEdit = false});

  @override
  ConsumerState<MultiSelectionWidget> createState() =>
      _MultiSelectionWidgetState();
}

class _MultiSelectionWidgetState extends ConsumerState<MultiSelectionWidget> {
  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mainProvider);
    final notifier = ref.read(mainProvider.notifier);
    final addLookNotifier = ref.read(addLooksProvider.notifier);
    final editLookNotifier = ref.read(editLooksProvider.notifier);
    final addLookState = ref.watch(addLooksProvider);
    final editLookState = ref.watch(editLooksProvider);
    return Column(
      children: [
        Expanded(
          child: state.isProductsLoading
              ? const Loading()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.products.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ProductListItem(
                            product: state.products[index],
                            isSelected: widget.isEdit
                                ? editLookState.products.any((element) =>
                                    element.id == state.products[index].id)
                                : addLookState.products.any((element) =>
                                    element.id == state.products[index].id),
                            onTap: () {
                              widget.isEdit
                                  ? editLookNotifier
                                      .setLookProducts(state.products[index])
                                  : addLookNotifier
                                      .setLookProducts(state.products[index]);
                            },
                          );
                        },
                      ),
                      HasMoreButton(
                          hasMore: state.hasMore,
                          onViewMore: () {
                            notifier.fetchProducts();
                          })
                    ],
                  ),
                ),
        ),
        Row(
          children: [
            ConfirmButton(
              title: AppHelpers.getTranslation(TrKeys.save),
              onTap: () => context.maybePop(),
            ),
          ],
        ),
      ],
    );
  }
}
