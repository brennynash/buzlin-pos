import 'package:admin_desktop/app_constants.dart';
import 'package:admin_desktop/presentation/assets.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class SelectAddressPage extends StatefulWidget {
  final ValueChanged<AddressData> onSelect;
  final LocationData? location;
  final bool? isShopLocation;

  const SelectAddressPage(
      {super.key, required this.onSelect, this.location, this.isShopLocation});

  @override
  State<SelectAddressPage> createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  CameraPosition? _cameraPosition;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(selectAddressProvider);
            final event = ref.read(selectAddressProvider.notifier);
            return Stack(
              children: [
                GoogleMap(
                  tiltGesturesEnabled: false,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    bearing: 0,
                    target: LatLng(
                      widget.location?.latitude ??
                          AppHelpers.getInitialLatitude(),
                      widget.location?.longitude ??
                          AppHelpers.getInitialLongitude(),
                    ),
                    tilt: 0,
                    zoom: 17,
                  ),
                  onMapCreated: (controller) {
                    event.setMapController(controller);
                    event.gotToPlace(widget.location);
                  },
                  onCameraMoveStarted: () {
                    _animationController.repeat(
                      min: AppConstants.pinLoadingMin,
                      max: AppConstants.pinLoadingMax,
                      period: _animationController.duration! *
                          (AppConstants.pinLoadingMax -
                              AppConstants.pinLoadingMin),
                    );
                    event.setChoosing(true);
                  },
                  onCameraIdle: () {
                    event.fetchLocationName(_cameraPosition?.target);
                    // ..checkDriverZone(
                    //     context: context, location: _cameraPosition?.target);
                    _animationController.forward(
                      from: AppConstants.pinLoadingMax,
                    );
                    event.setChoosing(false);
                  },
                  onCameraMove: (cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                ),
                IgnorePointer(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 78.0,
                      ),
                      child: lottie.Lottie.asset(
                        Assets.lottiePin,
                        onLoaded: (composition) {
                          _animationController.duration = composition.duration;
                        },
                        controller: _animationController,
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    54.verticalSpace,
                    Container(
                      height: 50.r,
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      margin: REdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Style.mainBack,
                            offset: Offset(0, 2),
                            blurRadius: 2,
                            spreadRadius: 0,
                          ),
                        ],
                        color: Style.white,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Remix.search_line,
                            size: 20.r,
                            color: Style.black,
                          ),
                          12.horizontalSpace,
                          Expanded(
                            child: TextFormField(
                              controller: state.textController,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: Style.black,
                                letterSpacing: -0.5,
                              ),
                              onChanged: (value) {
                                event.setQuery(context);
                              },
                              cursorWidth: 1.r,
                              cursorColor: Style.black,
                              decoration: InputDecoration.collapsed(
                                hintText: AppHelpers.getTranslation(
                                    TrKeys.searchLocation),
                                hintStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Style.iconButtonBack,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: event.clearSearchField,
                            splashRadius: 20.r,
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Remix.close_line,
                              size: 20.r,
                              color: Style.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state.isSearching)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Style.white,
                        ),
                        margin:
                            REdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        padding:
                            REdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.searchedPlaces.length,
                            padding: EdgeInsets.only(bottom: 22.h),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  event.goToLocation(
                                      place: state.searchedPlaces[index]);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    22.verticalSpace,
                                    Text(
                                      state.searchedPlaces[index]
                                              .address?["country"] ??
                                          "",
                                    ),
                                    Text(
                                      state.searchedPlaces[index].displayName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Divider(
                                      color: Style.borderColor,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                  ],
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 150),
                  bottom: state.isChoosing ? -60.r : 32.r,
                  left: 15.r,
                  right: 15.r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopButton(
                        popSuccess: (widget.isShopLocation ?? false)
                            ? () {
                                ref
                                    .read(profileProvider.notifier)
                                    .changeIndex(2);
                              }
                            : null,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          event.goToMyLocation();
                        },
                        child: ButtonEffectAnimation(
                          child: Container(
                            width: 56.r,
                            height: 56.r,
                            decoration: BoxDecoration(
                                color: Style.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Style.black)),
                            child: const Center(
                                child: Icon(Remix.navigation_fill)),
                          ),
                        ),
                      ),
                      16.horizontalSpace,
                      SizedBox(
                        width: 200.w,
                        child: Consumer(
                          builder: (context, ref, child) {
                            return LoginButton(
                                isLoading: state.isLoading,
                                title: AppHelpers.getTranslation(
                                    TrKeys.confirmLocation),
                                onPressed: () {
                                  if (widget.isShopLocation ?? false) {
                                    ref
                                        .read(profileProvider.notifier)
                                        .changeIndex(1);
                                  } else {
                                    final rightSideState =
                                        ref.watch(rightSideProvider);
                                    if (!(state.textController?.text.contains(
                                            LocalStorage.getBags()[rightSideState
                                                            .selectedBagIndex]
                                                        .selectedAddress !=
                                                    null
                                                ? (LocalStorage.getBags()[
                                                            rightSideState
                                                                .selectedBagIndex]
                                                        .selectedAddress
                                                        ?.title ??
                                                    LocalStorage.getBags()[
                                                            rightSideState
                                                                .selectedBagIndex]
                                                        .selectedAddress
                                                        ?.address ??
                                                    "")
                                                : (LocalStorage.getBags()[
                                                            rightSideState
                                                                .selectedBagIndex]
                                                        .selectedAddress
                                                        ?.address ??
                                                    "")) ??
                                        false)) {
                                      AppHelpers.showSnackBar(
                                          context,
                                          AppHelpers.getTranslation(
                                              TrKeys.thisLocationIsWrong));
                                      return;
                                    } else {
                                      context.maybePop();
                                      widget.onSelect(
                                        AddressData(
                                          location: LocationData(
                                            longitude: _cameraPosition
                                                ?.target.longitude,
                                            latitude: _cameraPosition
                                                ?.target.latitude,
                                          ),
                                          address:
                                              state.textController?.text ?? "",
                                        ),
                                      );
                                    }
                                  }
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
