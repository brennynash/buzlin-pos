import 'package:admin_desktop/application/create/gallery/create_product_gallery_notifier.dart';
import 'package:admin_desktop/application/create/gallery/create_product_gallery_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/create/stocks/create_food_stocks_state.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../styles/style.dart';

class CreateProductGalleryBody extends StatefulWidget {
  final CreateProductGalleryState state;
  final CreateProductGalleryNotifier notifier;
  final CreateFoodStocksState stockState;

  const CreateProductGalleryBody(
      {super.key,
      required this.state,
      required this.notifier,
      required this.stockState});

  @override
  State<CreateProductGalleryBody> createState() =>
      _CreateProductGalleryBodyState();
}

class _CreateProductGalleryBodyState extends State<CreateProductGalleryBody> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.notifier.initial(widget.stockState.updatedStocks);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .7,
            child: ListView.builder(
                padding: REdgeInsets.symmetric(vertical: 16),
                itemCount: widget.state.extras.length,
                itemBuilder: (context, index) {
                  final key = widget.state.extras[index].stockId.toString();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            ColorItem(
                              extras: (widget.state.extras[index]),
                            ),
                            6.horizontalSpace,
                            Text(
                              "(${widget.state.extras[index].value ?? " "})",
                              style: Style.interNormal(),
                            ),
                          ],
                        ),
                      ),
                      DraggableImagePicker(
                        isExtras: true,
                        onDelete: (p) =>
                            widget.notifier.deleteImage(path: p, key: key),
                        imageUrls: widget.state.listOfUrls[key],
                        listOfImages: widget.state.images[key],
                        onImageChange: (p) =>
                            widget.notifier.setImageFile(path: p, key: key),
                      ),
                    ],
                  );
                }),
          ),
          Row(
            children: [
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  bgColor: Style.primary,
                  textColor: Style.white,
                  title: AppHelpers.getTranslation(TrKeys.save),
                  isLoading: widget.state.isSaving,
                  onTap: () {
                    widget.notifier.updateGallery(context, updated: () {
                      context.maybePop();
                    });
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
