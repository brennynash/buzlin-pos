import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import 'package:admin_desktop/presentation/styles/style.dart';

class DeliveryZonePage extends ConsumerStatefulWidget {
  const DeliveryZonePage({super.key});

  @override
  ConsumerState<DeliveryZonePage> createState() => _DeliveryZonePageState();
}

class _DeliveryZonePageState extends ConsumerState<DeliveryZonePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(deliveryZoneProvider.notifier).fetchDeliveryZone(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.white,
      resizeToAvoidBottomInset: false,
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(deliveryZoneProvider);
          final event = ref.read(deliveryZoneProvider.notifier);
          return Stack(
            children: [
              state.isLoading
                  ? Container(
                      color: Style.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Style.black,
                          strokeWidth: 4.r,
                        ),
                      ),
                    )
                  : GoogleMap(
                      tiltGesturesEnabled: false,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      polygons: state.polygon,
                      onTap: event.addTappedPoint,
                      initialCameraPosition: CameraPosition(
                        bearing: 0,
                        target: LatLng(
                          state.polygon.isNotEmpty
                              ? state.polygon.first.points.first.latitude
                              : AppHelpers.getInitialLatitude(),
                          state.polygon.isNotEmpty
                              ? state.polygon.first.points.first.longitude
                              : AppHelpers.getInitialLongitude(),
                        ),
                        tilt: 0,
                        zoom: 11,
                      ),
                    ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 150),
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
                child: Row(
                  children: [
                    PopButton(
                      popSuccess: () =>
                          ref.read(profileProvider.notifier).changeIndex(1),
                    ),
                    const Spacer(),
                    if (state.tappedPoints.length >= 3)
                      Expanded(
                        child: ConfirmButton(
                          title: AppHelpers.getTranslation(TrKeys.save),
                          isLoading: state.isSaving,
                          onTap: () async {
                            await event.updateDeliveryZone();
                            ref.read(profileProvider.notifier).changeIndex(1);
                          },
                        ),
                      ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
