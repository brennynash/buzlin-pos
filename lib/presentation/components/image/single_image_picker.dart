import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../components.dart';
import '../helper/blur_wrap.dart';

class SingleImagePicker extends StatelessWidget {
  final bool isEdit;
  final String? imageFilePath;
  final String? imageUrl;
  final Function(String) onImageChange;
  final Function() onDelete;
  final bool isAdding;
  final double? height;
  final double? width;

  const SingleImagePicker({
    super.key,
    required this.onImageChange,
    required this.onDelete,
    this.imageFilePath,
    this.imageUrl,
    this.isEdit = false,
    this.isAdding = true,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).height / 8;
    return GestureDetector(
      onDoubleTap: () {
        // context.pushRoute();
      },
      child: Container(
        height: height ?? size + 16,
        width: width ?? size,
        padding: REdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: (isAdding && imageFilePath == null)
            ? ButtonEffectAnimation(
                onTap: () async => AppHelpers.getPhotoGallery(onImageChange),
                child: DottedBorder(
                  dashPattern: const [8],
                  color: Style.primary,
                  strokeWidth: 2.6,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(14.r),
                  child: Center(
                    child: Icon(
                      Remix.upload_cloud_2_line,
                      color: Style.primary,
                      size: 28.r,
                    ),
                  ),
                ),
              )
            : Stack(
                children: [
                  CommonImage(
                    height: height ?? size + 16,
                    width: width ?? size,
                    url: imageUrl,
                    radius: 16,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: imageFilePath != null
                        ? ButtonEffectAnimation(
                            onTap: onDelete,
                            child: BlurWrap(
                              radius: BorderRadius.circular(20.r),
                              child: Container(
                                height: 36.r,
                                width: 36.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Style.white.withOpacity(0.15),
                                ),
                                child: Icon(
                                  Remix.delete_bin_fill,
                                  color: Style.white,
                                  size: 18.r,
                                ),
                              ),
                            ),
                          )
                        : isEdit
                            ? ButtonEffectAnimation(
                                onTap: () async =>
                                    AppHelpers.getPhotoGallery(onImageChange),
                                child: BlurWrap(
                                  radius: BorderRadius.circular(20.r),
                                  child: Container(
                                    height: 36.r,
                                    width: 36.r,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Style.white.withOpacity(0.15),
                                    ),
                                    child: Icon(
                                      Remix.add_fill,
                                      color: Style.white,
                                      size: 18.r,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                  ),
                ],
              ),
      ),
    );
  }
}
