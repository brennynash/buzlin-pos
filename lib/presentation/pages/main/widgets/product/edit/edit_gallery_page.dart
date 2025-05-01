import 'package:admin_desktop/application/edit_product/details/edit_food_details_provider.dart';
import 'package:admin_desktop/application/edit_product/stocks/edit_food_stocks_provider.dart';
import 'package:admin_desktop/application/product/product_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/application/edit_product/gallery/edit_product_gallery_provider.dart';
import '../../../../../styles/style.dart';
import '../../comments/widgets/no_item.dart';

class EditProductGalleryPage extends ConsumerStatefulWidget {
  const EditProductGalleryPage({super.key});

  @override
  ConsumerState<EditProductGalleryPage> createState() =>
      _EditProductGalleryPageState();
}

class _EditProductGalleryPageState
    extends ConsumerState<EditProductGalleryPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(editProductGalleryProvider.notifier).initial(
        ref.watch(editFoodDetailsProvider).product?.stocks ??  ref.watch(editFoodStocksProvider).stocks,
        ref.watch(editFoodDetailsProvider).product?.stocks,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(editProductGalleryProvider.notifier);
    final state = ref.watch(editProductGalleryProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (state.extras.isEmpty) const NoItem(title: TrKeys.noGallery),
        ListView.builder(
            shrinkWrap: true,
            padding: REdgeInsets.symmetric(vertical: 16),
            itemCount: state.extras.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final key = state.extras[index].stockId.toString();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        ColorItem(extras: (state.extras[index])),
                        6.horizontalSpace,
                        Text(
                          "(${AppHelpers.getNameColor(state.extras[index].value)})",
                          style: Style.interNormal(),
                        ),
                      ],
                    ),
                  ),
                  DraggableImagePicker(
                    isExtras: true,
                    onDelete: (p) => notifier.deleteImage(path: p, key: key),
                    imageUrls: state.listOfUrls[key],
                    listOfImages: state.images[key],
                    onImageChange: (p) =>
                        notifier.setImageFile(path: p, key: key),
                  ),
                ],
              );
            }),
        if (state.extras.isNotEmpty)
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              textColor: Style.white,
              bgColor: Style.primary,
              title: AppHelpers.getTranslation(TrKeys.save),
              isLoading: state.isSaving,
              onTap: () {
                notifier.updateGallery(context, updated: () {
                  context.maybePop();
                  ref.read(productProvider.notifier).changeState(0);
                });
              },
            ),
          ),
        24.verticalSpace,
      ],
    );
  }
}
