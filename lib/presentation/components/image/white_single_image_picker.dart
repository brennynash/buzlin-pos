import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../components.dart';
import '../helper/blur_wrap.dart';

class WhiteSingleImagePicker extends StatelessWidget {
  final String? imageFilePath;
  final String? imageUrl;
  final Function(String) onImageChange;
  final Function() onDelete;
  final bool isAdding;
  final double? height;
  final double? width;

  const WhiteSingleImagePicker({
    super.key,
    required this.onImageChange,
    required this.onDelete,
    this.imageFilePath,
    this.imageUrl,
    this.isAdding = true,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width / 12;
    return GestureDetector(
      onDoubleTap: () {
        // context.pushRoute();
      },
      child: Container(
        height: height ?? size + 16,
        width: width ?? size,
        padding: REdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: (isAdding && imageFilePath == null)
            ? ButtonEffectAnimation(
                onTap: () async {
                  XFile? file;
                  try {
                    file = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                  } catch (ex) {
                    debugPrint('===> trying to select image $ex');
                  }
                  if (file != null) {
                    onImageChange(file.path);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 180.h,
                  decoration: BoxDecoration(
                    color: Style.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: REdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          XFile? file;
                          try {
                            file = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                          } catch (ex) {
                            debugPrint('===> trying to select image $ex');
                          }
                          if (file != null) {
                            onImageChange(file.path);
                          }
                        },
                        child: Icon(
                          Remix.upload_cloud_2_line,
                          color: Style.primary,
                          size: 36.r,
                        ),
                      ),
                      16.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.productPicture),
                        style: Style.interSemi(
                          size: 14,
                          color: Style.black,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        AppHelpers.getTranslation(TrKeys.recommendedSize),
                        style: Style.interRegular(
                          size: 14,
                          color: Style.black,
                          letterSpacing: -0.3,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Stack(
                children: [
                  CommonImage(
                    height: height ?? size + 16,
                    width: width ?? size,
                    fileImage:
                        imageFilePath != null ? File(imageFilePath!) : null,
                    url: imageUrl,
                    radius: 12,
                    fit: BoxFit.cover,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: imageFilePath != null
                          ? ButtonEffectAnimation(
                              onTap: onDelete,
                              child: BlurWrap(
                                radius: BorderRadius.circular(16.r),
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
                          : ButtonEffectAnimation(
                              onTap: () async {
                                XFile? file;
                                try {
                                  file = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                } catch (ex) {
                                  debugPrint('===> trying to select image $ex');
                                }
                                if (file != null) {
                                  onImageChange(file.path);
                                }
                              },
                              child: BlurWrap(
                                radius: BorderRadius.circular(16.r),
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
                            )),
                ],
              ),
      ),
    );
  }
}
