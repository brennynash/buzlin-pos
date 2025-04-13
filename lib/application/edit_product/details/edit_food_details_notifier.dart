import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'edit_food_details_state.dart';

class EditFoodDetailsNotifier extends StateNotifier<EditFoodDetailsState> {
  final ProductsRepository _productsRepository;
  final GalleryRepositoryFacade _galleryRepository;

  EditFoodDetailsNotifier(this._productsRepository, this._galleryRepository)
      : super(EditFoodDetailsState(titleController: TextEditingController(), descriptionController: TextEditingController()));

  void setTax(String value) {
    state = state.copyWith(tax: value.trim());
  }

  void setMaxQty(String value) {
    state = state.copyWith(maxQty: value.trim());
  }

  void setMinQty(String value) {
    state = state.copyWith(minQty: value.trim());
  }
  void changeState(int index) {
    state = state.copyWith(stateIndex: index);
  }
  void changeFeatureType(value) => state = state.copyWith(featureType: value);

  void setActive(bool? value) {
    final product =
        state.product?.copyWith(active: !(state.product?.active ?? false));
    state = state.copyWith(product: product);
  }

  void setInterval(String value) {
    state = state.copyWith(interval: value.trim());
  }
  void setDesc(){
    Map<String, List<String>> temp = Map.from(state.mapOfDesc);
    if(temp.containsKey(state.language?.locale)){
      List<String> list = [state.title, state.description];
      temp.update(state.language?.locale ?? "en", (value) => list);
    }else{
      List<String> list = [state.title, state.description];
      temp[state.language?.locale ?? "en"] = list;
    }
    state = state.copyWith(mapOfDesc: temp,);
  }

  void setTitleAndDescState(String key){
    state = state.copyWith(title: state.mapOfDesc[key]?.first ?? "", description: state.mapOfDesc[key]?.last ?? "");
    state.titleController?.text = state.mapOfDesc[key]?.first ?? "";
    state.descriptionController?.text = state.mapOfDesc[key]?.last ?? "";
  }
  Future<void> getProductDetailsByIdEdited(
      ValueChanged<ProductData?> onSuccess) async {
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository
        .getProductDetailsEdited(state.product?.uuid ?? "");
    response.when(
      success: (data) async {
        final List<Stocks> stocks = data.data?.stocks ?? <Stocks>[];
        state = state.copyWith(
          product: data.data,
          listOfUrls: data.data?.galleries ?? [],
          isLoading: false,
        );
        state.titleController?.text = data.data?.translation?.title ?? "";
        state.descriptionController?.text = data.data?.translation?.description ?? "";
        if(data.data?.translations != null){
          Map<String, List<String>> temp = Map.from(state.mapOfDesc);
          var items = data.data?.translations;
          for(int i = 0; i < data.data!.translations!.length; i++){
              temp[items?[i].locale ?? "en"] = [items?[i].title ?? '', items?[i].description ?? ''];
          }
          state = state.copyWith(mapOfDesc: temp);
        }
        onSuccess(data.data);
        if (stocks.isNotEmpty) {
          // final int groupsCount = stocks[0].extras?.length ?? 0;
          // final List<int> selectedIndexes = List.filled(groupsCount, 0);
          // setSelectedIndexes(selectedIndexes);
        }
      },
      failure: (failure, s) {
        debugPrint('==> get product details failure: $failure');
      },
    );
  }

  void setLanguage(LanguageData? languageData) {
    state = state.copyWith(language: languageData);
  }

  void setDigital(bool? value) {
    final product =
        state.product?.copyWith(digital: !(state.product?.digital ?? false));
    state = state.copyWith(product: product);
  }

  void setAgeLimit(String value) {
    final product =
        state.product?.copyWith(ageLimit: state.product?.ageLimit ?? 0);
    state = state.copyWith(product: product);
  }

  Future<void> updateProduct(
    BuildContext context, {
    UnitData? unit,
    CategoryData? category,
    Brand? brand,
    Function(ProductData?)? updated,
    VoidCallback? failed,
  }) async {
    state = state.copyWith(isLoading: true);
    List<String> imageUrl = List.from(state.listOfUrls.map((e) => e.path));
    if (state.images.isNotEmpty) {
      final imageResponse = await _galleryRepository.uploadMultiImage(
        state.images,
        UploadType.products,
      );
      imageResponse.when(
        success: (data) {
          imageUrl.addAll(data.data?.title ?? []);
        },
        failure: (failure, status) {
          debugPrint('==> upload product image fail: $failure');
          AppHelpers.showSnackBar(context, failure);
          state = state.copyWith(isLoading: true);
        },
      );
    }
    List<Galleries> tempList = List.from(List.from(state.listOfUrls)
        .where((element) => element.preview != null));
    List<String> previews = [];
    for (var element in tempList) {
      if (element.preview?.isNotEmpty ?? false) {
        previews.add(element.preview!);
      }
    }
    final response = await _productsRepository.updateProduct(
      titlesAndDescriptions: state.mapOfDesc,
      tax: state.tax,
      maxQty: state.maxQty,
      minQty: state.minQty == 'null' || state.minQty == '' ? "0": state.minQty,
      quantity: state.quantity,
      active: state.product?.active ?? false,
      digital: state.product?.digital ?? false,
      ageLimit: state.product?.ageLimit ?? 0,
      categoryId: category?.id,
      unitId: unit?.id,
      brandId: brand?.id,
      images: imageUrl,
      interval: state.interval,
      uuid: state.product?.uuid,
      previews: previews,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isLoading: false);
        final updatedTranslation = state.product?.translation?.copyWith(
          title: state.title,
          description: state.description,
        );
        final updatedProduct = state.product?.copyWith(
          translation: updatedTranslation,
          tax: num.tryParse(state.tax),
          maxQty: int.tryParse(state.maxQty),
          minQty: int.tryParse(state.minQty),
          barcode: state.barcode,
          active: state.product?.active ?? false,
          categoryId: category?.id,
          category: category,
          interval: num.tryParse(state.interval),
          unit: unit,
          // img: imageUrl,
        );
        updated?.call(updatedProduct);
      },
      failure: (fail, status) {
        AppHelpers.showSnackBar(context, fail);
        state = state.copyWith(isLoading: false);
        debugPrint('===> product update fail $fail');
        failed?.call();
      },
    );
  }

  void setDescription(String value) {
    state = state.copyWith(description: value.trim());
  }

  void setTitle(String value) {
    state = state.copyWith(title: value.trim());
  }

  void setImageFile(String file) {
    List<String> list = List.from(state.images);
    list.add(file);
    state = state.copyWith(images: list);
  }

  void deleteImage(String value) {
    List<String> list = List.from(state.images);
    list.remove(value);
    List<Galleries> urls = List.from(state.listOfUrls);
    urls.removeWhere((element) => element.path == value);
    state = state.copyWith(images: list, listOfUrls: urls);
  }

  void setUploadImage(Galleries gallery) {
    List<Galleries> list = List.from(state.listOfUrls);
    list.insert(0,gallery);
    state = state.copyWith(listOfUrls: list);
  }

  Future<void> setFoodDetails(ProductData? product) async {
    state = state.copyWith(
        product: product,
        minQty: product?.minQty.toString() ?? '',
        maxQty: product?.maxQty.toString() ?? '',
        tax: product?.tax == null ? '' : (product?.tax.toString() ?? ''),
        title: product?.translation?.title ?? '',
        description: product?.translation?.description ?? '',
        barcode: product?.barcode ?? '',
        active: product?.active ?? false,
        interval: product?.interval == null
            ? ''
            : (product?.interval.toString() ?? ''),
        listOfUrls: state.listOfUrls,
        images: []);
  }
}
