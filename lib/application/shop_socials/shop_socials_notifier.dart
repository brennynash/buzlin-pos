import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/models.dart';
import '../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'shop_socials_state.dart';

class ShopSocialsNotifier extends StateNotifier<ShopSocialsState> {
  final ShopsRepository _shopsRepository;
  ShopSocialsNotifier(this._shopsRepository)
      : super(const ShopSocialsState());


  void addSocial(String value, index){
    List<TextEditingController> tempString = List.from(state.socialTypesController);
    tempString[index].text = value;
    state = state.copyWith(socialTypesController: tempString);
  }
  void addTextField({bool? isEdit}){
    if(isEdit != null && (state.socialData?.isNotEmpty  ?? false)){
      List<TextEditingController> tempString = List.from(state.socialTypesController);
      List<TextEditingController> temp = List.from(state.socialControllers);
      for (final social in state.socialData!) {
        temp.add(TextEditingController(text: AppHelpers.getTranslation(social.content ?? "")));
        tempString.add(TextEditingController(text: AppHelpers.getTranslation(social.type ?? "")));
      }
      state = state.copyWith(socialControllers: temp, socialTypesController: tempString);
      return;
    }
    List<TextEditingController> tempString = List.from(state.socialTypesController);
    List<TextEditingController> temp = List.from(state.socialControllers);
    temp.add(TextEditingController());
    tempString.add(TextEditingController(text: AppHelpers.getTranslation(TrKeys.instagram)));
    state = state.copyWith(socialControllers: temp, socialTypesController: tempString);
  }

  void removeSocialFromState(int index){
    List<TextEditingController> tempString = List.from(state.socialTypesController);
    List<TextEditingController> temp = List.from(state.socialControllers);
    temp.removeAt(index);
    tempString.removeAt(index);
    state = state.copyWith(socialControllers: temp, socialTypesController: tempString);
  }

  Future<void> addShopSocials({VoidCallback? onSuccess}) async {
    state = state.copyWith(isSocialLoading: true);
    final response = await _shopsRepository.addShopSocials(
      socialTypes: AppHelpers.extractTextFromControllers(state.socialTypesController),
      socialContents: AppHelpers.extractTextFromControllers(state.socialControllers),
    );
    response.when(
      success: (data) {
        onSuccess?.call();
        state = state.copyWith(isSocialLoading: false);
      },
      failure: (failure, status) {
        state = state.copyWith(isSocialLoading: false);
        debugPrint('==> error social adding days $failure');
      },
    );
  }
  Future<void> fetchShopSocials(
      {VoidCallback? checkYourNetwork, VoidCallback? onSuccess}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isSocialLoading: true);
      final response = await _shopsRepository.getShopSocials();
      response.when(
        success: (data) async {
          state = state.copyWith(
              isSocialLoading: false, socialData: data.data);
          onSuccess?.call();
        },
        failure: (failure, status) {
          state = state.copyWith(isSocialLoading: false);
          debugPrint('==> get editShopData failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> deleteShopSocials(BuildContext context, int id,
      {VoidCallback? updateSuccess}) async {
    state = state.copyWith(isSocialLoading: true);

    final response = await _shopsRepository.deleteShopSocial(
      socialId: id,
    );
    response.when(
      success: (data) {
        List<SocialData>? tempList = List.from(state.socialData!);
        tempList.removeWhere((element) => element.id == id);
        state = state.copyWith(
          socialData: tempList,
          isSocialLoading: false,
        );
        updateSuccess?.call();
      },
      failure: (failure, status) {
        state = state.copyWith(isSocialLoading: false);
        debugPrint('===> delete socials fail $failure');
        AppHelpers.showSnackBar(context,
            failure);
      },
    );
  }

}
