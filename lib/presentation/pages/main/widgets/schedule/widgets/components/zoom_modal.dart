import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_desktop/application/bookings/booking_provider.dart';
import 'package:admin_desktop/application/bookings/zoom/zoom_provider.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class ZoomModal extends ConsumerStatefulWidget {
  const ZoomModal({super.key});

  @override
  ConsumerState<ZoomModal> createState() => _ZoomModalState();
}

class _ZoomModalState extends ConsumerState<ZoomModal> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(zoomProvider.notifier)
          .changeZoom(ref.read(bookingProvider).calendarZoom);
    });
    super.initState();
  }

  List<String> sizeList = [
    TrKeys.small,
    TrKeys.normal,
    TrKeys.large,
  ];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(zoomProvider);
    final notifier = ref.read(zoomProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          value: state.calendarZoom,
          max: 2.6,
          divisions: 2,
          min: 1.8,
          onChanged: notifier.changeZoom,
        ),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              sizeList.length,
              (i) => Text(AppHelpers.getTranslation(sizeList[i])),
            ),
          ),
        ),
        32.verticalSpace,
        CustomButton(
            title: TrKeys.save,
            onTap: () {
              ref
                  .read(bookingProvider.notifier)
                  .changeZoom(i: state.calendarZoom);
               context.maybePop();
            }),
      ],
    );
  }
}
