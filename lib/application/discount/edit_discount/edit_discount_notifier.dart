import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'edit_discount_state.dart';

class EditDiscountNotifier extends StateNotifier<EditDiscountState> {
  final DiscountsRepository _discountRepository;
  final SettingsRepository _settingsRepository;

  EditDiscountNotifier(this._discountRepository, this._settingsRepository)
      : super(EditDiscountState(dateController: TextEditingController()));

  void changeActive(bool? active) {
    state = state.copyWith(active: !state.active);
  }

  void clear() {
    state = state.copyWith(
        active: false,
        stocks: [],
        price: 0,
        imageFile: null,
        startDate: null,
        endDate: null);
    state.dateController?.clear();
  }

  void setPrice(String value) {
    state = state.copyWith(price: int.parse(value));
  }

  void setDate(List<DateTime?> list) {
    if (list.isNotEmpty) {
      final startDate = TimeService.dateFormat(list.first!);
      final endDate = TimeService.dateFormat(list.last!);
      state.dateController?.text = '$startDate - $endDate';
      state = state.copyWith(startDate: list.first, endDate: list.last);
    }
  }

  void setActiveIndex(String? value) {
    if (state.type == value || value == null) {
      return;
    }
    state = state.copyWith(type: value);
  }

  void setDiscountProducts(Stocks stockData) {
    if (state.stocks.any((element) => element.id == stockData.id)) {
      deleteFromAddedProducts(stockData.id);
      return;
    }
    List<Stocks> temp = List.from(state.stocks);
    temp.add(stockData);
    state = state.copyWith(stocks: temp);
  }

  void deleteFromAddedProducts(int? id) {
    List<Stocks> temp = List.from(state.stocks);
    temp.removeWhere((element) => element.id == id);
    state = state.copyWith(stocks: temp);
  }

  void setImageFile(String? file) {
    state = state.copyWith(imageFile: file);
  }

  Future<void> fetchDiscountDetails(
      {required BuildContext context, required int id}) async {
    state = state.copyWith(isLoading: true);
    final res = await _discountRepository.getDiscountDetails(id: id);
    res.when(success: (data) {
      List<Stocks> list = [];
      list.addAll(data.data.stocks ?? []);
      state = state.copyWith(isLoading: false, stocks: list);
    }, failure: (failure, status) {
      state = state.copyWith(isLoading: false);
      AppHelpers.showSnackBar(context, failure);
    });
  }

  Future<void> updateDiscount(
    BuildContext context, {
    UnitData? unit,
    CategoryData? category,
    VoidCallback? updated,
    VoidCallback? failed,
  }) async {
    state = state.copyWith(isLoading: true);
    String? imageUrl;
    if (state.imageFile != null) {
      final imageResponse = await _settingsRepository.uploadImage(
        state.imageFile!,
        UploadType.products,
      );
      imageResponse.when(
        success: (data) {
          imageUrl = data.imageData?.title;
        },
        failure: (failure, status) {
          debugPrint('==> upload discount image fail: $failure');
          AppHelpers.showSnackBar(context, failure.toString());
        },
      );
    }
    final response = await _discountRepository.updateDiscount(
      active: state.active,
      id: state.discount?.id ?? 0,
      image: imageUrl,
      type: state.type,
      price: state.price,
      startDate: TimeService.dateFormatDay(state.startDate),
      endDate: TimeService.dateFormatDay(state.endDate),
      ids: state.stocks.map((e) => e.id).toList(),
    );
    response.when(
      success: (data) {
        state = state.copyWith(imageFile: null, isLoading: false, stocks: []);
        updated?.call();
      },
      failure: (fail, status) {
        AppHelpers.showSnackBar(context, fail);
        state = state.copyWith(isLoading: false);
        debugPrint('===> discount update fail $fail');
        failed?.call();
      },
    );
  }

  Future<void> setDiscountDetails(
      DiscountData? discount, ValueChanged<DiscountData?> onSuccess) async {
    final startDate = TimeService.dateFormat(discount?.start);
    final endDate = TimeService.dateFormat(discount?.end);
    state.dateController?.text = '$startDate - $endDate';
    state = state.copyWith(startDate: discount?.start, endDate: discount?.end);
    state = state.copyWith(
      discount: discount,
      price: discount?.price ?? 0,
      type: discount?.type ?? 'fix',
      active: discount?.active ?? true,
    );
  }
}
