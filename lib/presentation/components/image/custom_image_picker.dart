import 'dart:io';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../components.dart';
import '../helper/blur_wrap.dart';

class CustomImagePicker extends StatelessWidget {
  final String? imageFilePath;
  final String? imageUrl;
  final String? preview;
  final Function(String) onImageChange;
  final Function() onDelete;
  final bool isAdding;
  final double width;
  final double height;

  const CustomImagePicker({
    super.key,
    required this.onImageChange,
    required this.onDelete,
    this.imageFilePath,
    this.imageUrl,
    this.isAdding = false,
    this.width = double.infinity,
    this.height = 172,
    this.preview,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.r,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          ButtonEffectAnimation(
            onTap: () async {
              XFile? file;
              try {
                file =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
              } catch (ex) {
                debugPrint('===> trying to select image $ex');
              }
              if (file != null) {
                onImageChange(file.path);
              }
            },
            child: SizedBox(
              width: width.r,
              height: height.r,
              child: imageFilePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.file(
                        File(imageFilePath!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : CommonImage(
                      url: imageUrl,
                      preview: preview,
                      width: double.infinity,
                      radius: 16,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            top: 12.h,
            right: 16.w,
            child: Row(
              children: [
                ButtonEffectAnimation(
                  child: GestureDetector(
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
                      radius: BorderRadius.circular(18.r),
                      child: Container(
                        height: 36.r,
                        width: 36.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Style.white.withOpacity(0.15),
                        ),
                        child: Icon(
                          Remix.image_add_fill,
                          color: (!isAdding &&
                                  imageUrl == null &&
                                  imageFilePath == null)
                              ? Style.black
                              : Style.white,
                          size: 18.r,
                        ),
                      ),
                    ),
                  ),
                ),
                10.horizontalSpace,
                if (imageFilePath != null)
                  ButtonEffectAnimation(
                    child: GestureDetector(
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
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
