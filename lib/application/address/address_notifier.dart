import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'address_state.dart';

class AddressNotifier extends StateNotifier<AddressState> {
  final AddressRepository _addressRepository;

  AddressNotifier(this._addressRepository) : super(const AddressState());
  int page = 0;
  int countryPage = 0;

  fetchCountry({
    required BuildContext context,
    bool? isRefresh,
  }) async {
    if (isRefresh ?? false) {
      countryPage = 0;
      state = state.copyWith(hasMoreCountry: true, countries: [], isCountryLoading: true);
    }
    if (!state.hasMoreCountry) {
      return;
    }
    if(countryPage == 0){
      final res = await _addressRepository.getCountry(page: ++countryPage);
      res.when(success: (data) {
        List<CountryData> list = List.from(state.countries);
        list.addAll(data.data ?? []);
        state = state.copyWith(isCountryLoading: false, countries: list);

        if ((data.data?.length ?? 0) < 40) {
          state = state.copyWith(hasMoreCountry: false);
        }
      }, failure: (failure, status) {
        state = state.copyWith(isCountryLoading: false);
        AppHelpers.showSnackBar(context, status.toString());
      });
    }
    else{
      state = state.copyWith(isCountryLoading: true);
      final res =
       await _addressRepository.getCountry(page: ++countryPage);
      res.when(success: (data) {

        List<CountryData> list = List.from(state.countries);
        list.addAll(data.data ?? []);
        state = state.copyWith(isCountryLoading: false, countries: list);
        if ((data.data?.length ?? 0) < 40) {
          state = state.copyWith(hasMoreCountry: false);
        }
      }, failure: (failure, status) {
        state = state.copyWith(isCountryLoading: false);
        AppHelpers.showSnackBar(context, status.toString());
      });
    }

  }

  searchCountry({
    required BuildContext context,
    String? search,
  }) async {
    final res = await _addressRepository.searchCountry(search: search ?? "");
    res.when(success: (data) {
      state = state.copyWith(countries: data.data ?? []);
    }, failure: (failure, status) {
      AppHelpers.showSnackBar(context, status.toString());
    });
  }

  fetchCity(
      {required BuildContext context,
      bool? isRefresh,
      }) async {
    if (isRefresh ?? false) {
      page = 0;
      state = state.copyWith(hasMore: true, cities: [], isCityLoading: true);
    }
    if (!state.hasMore) {
      return;
    }
    if(page == 0){
      state = state.copyWith(isCityLoading: true, cities: []);
      final res =
      await _addressRepository.getCity(page: ++page, countyId: state.countryId);
      res.when(success: (data) {
        List<CityData> list = List.from(state.cities);
        list.addAll(data.data ?? []);
        state = state.copyWith(isCityLoading: false, cities: list);
        if ((data.data?.length ?? 0) < 40) {
          state = state.copyWith(hasMore: false);
        }
      }, failure: (failure, status) {
        state = state.copyWith(isCityLoading: false);
        AppHelpers.showSnackBar(context, status.toString());
      });
    }else{
      state = state.copyWith(isCityLoading: true);
      final res =
      await _addressRepository.getCity(page: ++page, countyId: state.countryId);
      res.when(success: (data) {
        List<CityData> list = List.from(state.cities);
        list.addAll(data.data ?? []);
        state = state.copyWith(isCityLoading: false, cities: list);
        if ((data.data?.length ?? 0) < 40) {
          state = state.copyWith(hasMore: false);
        }
      }, failure: (failure, status) {
        state = state.copyWith(isCityLoading: false);
        AppHelpers.showSnackBar(context, status.toString());
      });
    }
  }
  setCountryId(int countryId){
    state = state.copyWith(countryId: countryId);
  }
  searchCity({
    required BuildContext context,
    required int countyId,
    String? search,
  }) async {
    final res = await _addressRepository.searchCity(
        search: search ?? "", countyId: countyId);
    res.when(success: (data) {
      state = state.copyWith(cities: data.data ?? []);
    }, failure: (failure, status) {
      AppHelpers.showSnackBar(context, status.toString());
    });
  }
}
