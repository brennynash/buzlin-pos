import 'package:admin_desktop/app_constants.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/application/right_side/right_side_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:admin_desktop/domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'pickup_points_state.dart';

class PickupPointsNotifier extends StateNotifier<PickupPointsState> {
  final AddressRepository _addressRepository;

  PickupPointsNotifier(this._addressRepository)
      : super(const PickupPointsState());
  int page = 0;

  changePickup(int index) {
    state = state.copyWith(pickupIndex: index);
  }

  fetchPoints({
    required BuildContext context,
    required int? countyId,
    required int? regionId,
    bool? isRefresh,
    RefreshController? controller,
    required RightSideNotifier rightSideNotifier,
  }) async {
    if (isRefresh ?? false) {
      page = 0;
      state = state.copyWith(deliveryPoints: [], isLoading: true);
    }
    final res = await _addressRepository.getDeliveryPoints(
        page: ++page, countryId: countyId ?? 0, cityId: regionId);
    res.when(success: (data) async {

      final ImageCropperForMarker image = ImageCropperForMarker();
      Set<Marker> list = {};
      final icon = await image.resizeAndCircle(null, 120);
      for (int i = 0; i < (data.data?.length ?? 0); i++) {
        list.add(
          Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(
              data.data?[i].location?.latitude ?? AppConstants.demoLatitude,
              data.data?[i].location?.longitude ?? AppConstants.demoLongitude,
            ),
            icon: icon,
          ),
        );
      }
      state = state.copyWith(markers: list);
      List<DeliveryPointsData> points = List.from(state.deliveryPoints);
      points.addAll(data.data ?? []);
      state = state.copyWith(isLoading: false, deliveryPoints: points);
      if(data.data != null){
        if(data.data?.first != null){
          rightSideNotifier.setDeliveryPoint(data.data?.first);
          rightSideNotifier.fetchCarts();
        }else{
          rightSideNotifier.setDeliveryPrice(0);
          rightSideNotifier.fetchCarts();
        }
      }


      if (isRefresh ?? false) {
        controller?.refreshCompleted();
        return;
      } else if (data.data?.isEmpty ?? true) {
        controller?.loadNoData();
        return;
      }
      controller?.loadComplete();
      return;
    },
        failure: (failure, status) {
      state = state.copyWith(isLoading: false);
      AppHelpers.showSnackBar(context, status.toString());
    });
  }

  DeliveryPointsData checkPoint(LatLng latLng) {
    for (int i = 0; i < state.deliveryPoints.length; i++) {
      if (state.deliveryPoints[i].location?.latitude == latLng.latitude &&
          state.deliveryPoints[i].location?.longitude == latLng.longitude) {
        return state.deliveryPoints[i];
      }
    }
    return DeliveryPointsData();
  }
}
