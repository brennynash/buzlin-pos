import 'dart:io';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class ProductImageWidget extends StatelessWidget {
  final bool isEmptyorNot;
  final bool isEmptyorNot2;
  final String image;
  final String localStoreImage;
  final String imagePath;
  final Function()? onthisTap;

  const ProductImageWidget({
    super.key,
    required this.isEmptyorNot,
    required this.image,
    required this.isEmptyorNot2,
    required this.imagePath,
    required this.localStoreImage,
    this.onthisTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 108.r,
          width: 108.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: Style.shimmerBase,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: (isEmptyorNot)
                ? CommonImage(
                    url: localStoreImage,
                    height: 108.r,
                    width: 108.r,
                    radius: 24.r)
                : isEmptyorNot2
                    ? Image.file(
                        File(imagePath),
                        width: 108.r,
                        height: 108.r,
                      )
                    : CommonImage(
                        url: image, height: 108.r, width: 108.r, radius: 24.r),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: onthisTap,
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                  color: Style.editProfileCircle,
                  borderRadius: BorderRadius.circular(16)),
              child: const Icon(
                Remix.pencil_line,
                size: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
