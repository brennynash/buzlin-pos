import 'dart:io';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/style.dart';
import 'components.dart';

class CustomEditWidget extends StatelessWidget {
  final bool isEmptyorNot;
  final bool isLoading;
  final double height;
  final double width;
  final double radius;
  final bool isEmptyorNot2;
  final String image;
  final String localStoreImage;
  final String imagePath;
  final Function()? onthisTap;

  const CustomEditWidget({
    super.key,
    this.height = 108,
    this.width = 108,
    this.radius = 100,
    this.isLoading = false,
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
        isLoading
            ? MakeShimmer(
                child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: Style.shimmerBase,
                ),
              ))
            : Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: Style.shimmerBase,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: (isEmptyorNot)
                      ? CommonImage(
                          url: localStoreImage,
                          height: height,
                          width: width,
                          radius: radius)
                      : isEmptyorNot2
                          ? Image.file(
                              File(imagePath),
                              fit: BoxFit.fitWidth,
                              width: width,
                              height: height,
                            )
                          : CommonImage(
                              url: image,
                              height: height,
                              width: width,
                              radius: radius),
                ),
              ),
        Positioned(
          right: radius != 100 ? 4 : 0,
          bottom: radius != 100 ? 4 : 0,
          child: GestureDetector(
            onTap: onthisTap,
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: const BoxDecoration(
                color: Style.editProfileCircle,
                shape: BoxShape.circle,
              ),
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
