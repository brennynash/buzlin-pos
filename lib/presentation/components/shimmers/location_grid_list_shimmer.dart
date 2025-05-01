import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_desktop/presentation/styles/style.dart';
import '../components.dart';

class LocationGridListShimmer extends StatelessWidget {
  final int count;

  const LocationGridListShimmer({super.key, this.count = 5});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: REdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8.r,
        crossAxisCount: count,
        mainAxisSpacing: 12.r,
        crossAxisSpacing: 8.r,
        mainAxisExtent: 68.r,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Style.bg,
            border: Border.all(color: Style.icon),
            borderRadius: BorderRadius.circular(6.r),
          ),
          height: 80.r,
          width: 100,
          child: const Center(
              child: Loading(
            size: 18,
          )),
        );
      },
    );
  }
}
