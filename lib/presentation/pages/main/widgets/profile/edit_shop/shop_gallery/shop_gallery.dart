import 'package:admin_desktop/application/shop_gallery/shop_galleries_state.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/shop_gallery/shop_galleries_notifier.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class ShopGallery extends StatefulWidget {
  final ShopGalleriesState state;
  final ShopGalleriesNotifier notifier;

  const ShopGallery({super.key, required this.state, required this.notifier});

  @override
  State<ShopGallery> createState() => _ShopGalleryState();
}

class _ShopGalleryState extends State<ShopGallery> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.notifier.fetchShopGalleries();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 16, right: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
          ),
        ),
        padding: REdgeInsets.all(16),
        child: Stack(
          children: [
            widget.state.isLoading
                ? const Loading()
                : MultiImagePicker(
                    onDelete: widget.notifier.deleteImage,
                    imageUrls: widget.state.listOfUrls,
                    listOfImages: widget.state.images,
                    onImageChange: widget.notifier.setImageFile,
                    onUpload: widget.notifier.setUploadImage,
                    isShopGallery: true,
                  ),
            Positioned(
                bottom: 16,
                child: SizedBox(
                  width: 250.r,
                  child: LoginButton(
                      isLoading: widget.state.isUpdating,
                      title: TrKeys.save,
                      onPressed: () {
                        widget.notifier.setGalleries(context);
                      }),
                ))
          ],
        ),
      ),
    );
  }
}
