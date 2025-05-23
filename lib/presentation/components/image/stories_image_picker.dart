import 'dart:io';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_desktop/presentation/styles/style.dart';
import '../components.dart';
import '../helper/blur_wrap.dart';

class StoriesImagePicker extends StatelessWidget {
  final List<String?>? listOfImages;
  final List<String?>? imageUrls;
  final Function(String) onDelete;
  final Function(String) onImageChange;
  final bool isCreating;
  final bool isExtras;

  const StoriesImagePicker({
    super.key,
    this.listOfImages,
    required this.onDelete,
    this.imageUrls,
    required this.onImageChange,
    this.isCreating = false,
    this.isExtras = false,
  });

  @override
  Widget build(BuildContext context) {
    return _editExtrasImage(context);
  }

  _editExtrasImage(BuildContext context) {
    int itemCount = (listOfImages?.length ?? 0) + (imageUrls?.length ?? 0);
    return Column(
      children: [
        SizedBox(
          height: 130.r,
          child: ListView.builder(
              padding: REdgeInsets.symmetric(horizontal: 16),
              itemCount: itemCount + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: REdgeInsets.only(right: 12),
                  height: 130,
                  width: 116,
                  child: itemCount == index
                      ? SingleImagePicker(
                          width: 116,
                          height: 130,
                          onImageChange: onImageChange,
                          onDelete: () {},
                        )
                      : Stack(
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: CommonImage(
                                fileImage: (imageUrls?.length ?? 0) > index
                                    ? null
                                    : File(listOfImages?[
                                            index - (imageUrls?.length ?? 0)] ??
                                        ""),
                                url: (imageUrls?.length ?? 0) > index
                                    ? imageUrls![index]
                                    : null,
                                radius: 12,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: REdgeInsets.all(6),
                                child: ButtonEffectAnimation(
                                  onTap: () {
                                    String path;
                                    try {
                                      path = imageUrls?[index] ?? "";
                                    } catch (e) {
                                      path = listOfImages?[(index -
                                              (imageUrls?.length ?? 0))] ??
                                          "";
                                    }
                                    onDelete(path);
                                  },
                                  child: BlurWrap(
                                    blur: 8,
                                    radius: BorderRadius.circular(20.r),
                                    child: Container(
                                      height: 32.r,
                                      width: 32.r,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Style.white.withOpacity(0.15),
                                      ),
                                      child: Icon(
                                        Remix.delete_bin_fill,
                                        color: Style.white,
                                        size: 16.r,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              }),
        )
      ],
    );
  }
}
