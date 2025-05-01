import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/data/pickup_address.dart';
import '../../domain/models/models.dart';
import '../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'right_side_state.dart';

class RightSideNotifier extends StateNotifier<RightSideState> {
  final UsersFacade _usersRepository;
  final CurrenciesRepository _currenciesRepository;
  final PaymentsFacade _paymentsRepository;
  final ProductsRepository _productsRepository;
  final OrdersRepository _ordersRepository;
  final AddressRepository _addressRepository;
  Timer? _searchUsersTimer;

  RightSideNotifier(
    this._usersRepository,
    this._currenciesRepository,
    this._paymentsRepository,
    this._productsRepository,
    this._ordersRepository,
    this._addressRepository,
  ) : super(RightSideState(phoneNumberController: TextEditingController()));
  Timer? timer;

  void setCoupon(String coupon, BuildContext context) {
    state = state.copyWith(coupon: coupon, isActive: false);
    fetchCarts(
      checkYourNetwork: () {
        AppHelpers.showSnackBar(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }

  setCalculate(String item) {
    if (item == "-1" && state.calculate.isNotEmpty) {
      state = state.copyWith(
          calculate: state.calculate.substring(0, state.calculate.length - 1));
      return;
    } else if (state.calculate.length > 25) {
      return;
    } else if (item == "." && state.calculate.isEmpty) {
      state = state.copyWith(calculate: "${state.calculate}0$item");
      return;
    } else if (item == "." && state.calculate.contains(".")) {
      return;
    } else if (item != "-1") {
      state = state.copyWith(calculate: state.calculate + item);
      return;
    }
  }


  void setDeliveryPrice(int number) {
    state = state.copyWith(deliveryFee: 0);
  }

  void clear() {
    state = state.copyWith(
        deliveryFee: 0,
        deliveryPrice: null,
        pickupAddress: null,
        selectedAddress: null,
        phoneNumberController: null);
  }



  Future<void> fetchBags() async {
    state = state.copyWith(isBagsLoading: true, bags: []);
    List<BagData> bags = LocalStorage.getBags();
    if (bags.isEmpty) {
      final BagData firstBag = BagData(index: 0, bagProducts: []);
      LocalStorage.setBags([firstBag]);
      bags = [firstBag];
    }
    state = state.copyWith(
      bags: bags,
      isBagsLoading: false,
      selectedUser: bags[0].selectedUser,
      isActive: false,
      isPromoCodeLoading: false,
      coupon: null,
    );
  }

  Future<void> checkPromoCode(
    BuildContext context,
    String? promoCode,
  ) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isPromoCodeLoading: true,
        isActive: false,
      );

      final response = await _usersRepository.checkCoupon(
        coupon: promoCode ?? "",
      );
      response.when(
        success: (data) {
          List<BagData> bags = LocalStorage.getBags();
          bags[state.selectedBagIndex] =
              bags[state.selectedBagIndex].copyWith(coupon: data);
          LocalStorage.setBags(bags);
          //state = state.copyWith(checkedCoupon: success, isCouponLoading: false);
          fetchCarts();
          state = state.copyWith(isPromoCodeLoading: false, isActive: true);
        },
        failure: (failure, status) {
          state = state.copyWith(
            isPromoCodeLoading: false,
            isActive: false,
          );
          AppHelpers.showSnackBar(
            context,
            failure,
          );
        },
      );
    } else {
      if (context.mounted) {
        AppHelpers.showSnackBar(
            context, AppHelpers.getTranslation(TrKeys.noInternetConnection));
      }
    }
  }

  void addANewBag() {
    List<BagData> newBags = List.from(state.bags);
    newBags.add(BagData(index: newBags.length, bagProducts: []));
    LocalStorage.setBags(newBags);
    state = state.copyWith(bags: newBags);
  }

  void setSelectedBagIndex(int index) {
    state = state.copyWith(
      selectedBagIndex: index,
      selectedUser: state.bags[index].selectedUser,
    );
  }

  void removeBag(int index) {
    List<BagData> bags = List.from(state.bags);
    List<BagData> newBags = [];
    bags.removeAt(index);
    for (int i = 0; i < bags.length; i++) {
      newBags.add(BagData(index: i, bagProducts: bags[i].bagProducts));
    }
    LocalStorage.setBags(newBags);
    final int selectedIndex =
        state.selectedBagIndex == index ? 0 : state.selectedBagIndex;
    state = state.copyWith(bags: newBags, selectedBagIndex: selectedIndex);
  }

  void removeOrderedBag(BuildContext context) {
    List<BagData> bags = List.from(state.bags);
    List<BagData> newBags = [];
    bags.removeAt(state.selectedBagIndex);
    if (bags.isEmpty) {
      final BagData firstBag = BagData(index: 0, bagProducts: []);
      newBags = [firstBag];
    } else {
      for (int i = 0; i < bags.length; i++) {
        newBags.add(BagData(index: i, bagProducts: bags[i].bagProducts));
      }
    }
    LocalStorage.setBags(newBags);
    state = state.copyWith(
        bags: newBags,
        selectedBagIndex: 0,
        selectedUser: null,
        selectedAddress: null,
        selectedCurrency: null,
        selectedPayment: null,
        orderType: TrKeys.pickup);
    setInitialBagData(context, newBags[0]);
  }

  Future<void> fetchUsers({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isUsersLoading: true,
        dropdownUsers: [],
        users: [],
      );
      final response = await _usersRepository.searchUsers(
          query: state.usersQuery.isEmpty ? null : state.usersQuery);
      response.when(
        success: (data) async {
          final List<UserData> users = data.users ?? [];
          List<DropDownItemData> dropdownUsers = [];
          for (int i = 0; i < users.length; i++) {
            dropdownUsers.add(
              DropDownItemData(
                index: i,
                title: '${users[i].firstname} ${users[i].lastname ?? ""}',
              ),
            );
          }
          state = state.copyWith(
            isUsersLoading: false,
            users: users,
            dropdownUsers: dropdownUsers,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isUsersLoading: false);
          debugPrint('==> get users failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setPhoneNumber(String value) {
    state.phoneNumberController?.text = value.trim();
  }

  void setZipCode(String value) {
    state = state.copyWith(zipCode: value.trim());
  }

  void setHomeNumber(String value) {
    state = state.copyWith(homeNumber: value.trim());
  }

  void setDetail(String value) {
    state = state.copyWith(details: value.trim());
  }

  setCountry(CountryData? country) {
    List<BagData> bags = LocalStorage.getBags();
    bags[state.selectedBagIndex] = bags[state.selectedBagIndex].copyWith(
      pickupAddress: PickupAddress(country: country),
    );
    LocalStorage.setBags(bags);
    state = state.copyWith(
        pickupAddress: PickupAddress(country: country), bags: bags);
  }

  setCity(CityData? city) {
    List<BagData> bags = LocalStorage.getBags();
    BagData bag = bags[state.selectedBagIndex];
    bag = bag.copyWith(pickupAddress: bag.pickupAddress?.copyWith(city: city));
    bags[state.selectedBagIndex] = bag;
    LocalStorage.setBags(bags);
    state = state.copyWith(pickupAddress: bag.pickupAddress, bags: bags);
  }

  void setUsersQuery(BuildContext context, String query) {
    if (state.usersQuery == query) {
      return;
    }
    state = state.copyWith(usersQuery: query.trim());

    if (_searchUsersTimer?.isActive ?? false) {
      _searchUsersTimer?.cancel();
    }
    _searchUsersTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        state = state.copyWith(users: [], dropdownUsers: []);
        fetchUsers(
          checkYourNetwork: () {
            AppHelpers.showSnackBar(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
      },
    );
  }

  void setSelectedUser(BuildContext context, int index) {
    final user = state.users[index];
    final bags = LocalStorage.getBags();
    final bag = bags[state.selectedBagIndex].copyWith(selectedUser: user);
    bags[state.selectedBagIndex] = bag;
    LocalStorage.setBags(bags);
    state = state.copyWith(
      bags: bags,
      selectedUser: user,
    );
    state.phoneNumberController?.text = user.phone ?? "";
    fetchUserDetails(
      checkYourNetwork: () {
        AppHelpers.showSnackBar(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
    setUsersQuery(context, '');
  }

  void removeSelectedUser() {
    final List<BagData> bags = List.from(LocalStorage.getBags());
    final BagData bag = bags[state.selectedBagIndex]
        .copyWith(selectedUser: null, deliveryAddress: null);
    bags[state.selectedBagIndex] = bag;
    LocalStorage.setBags(bags);
    state = state.copyWith(
      bags: bags,
      selectedUser: null,
    );
  }

  Future<void> fetchUserDetails({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isUserDetailsLoading: true);
      final response =
          await _usersRepository.getUserDetails(state.selectedUser?.uuid ?? '');
      response.when(
        success: (data) async {
          state = state.copyWith(
            isUserDetailsLoading: false,
            selectedUser: data.data,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isUserDetailsLoading: false);
          debugPrint('==> get users details failure: $failure');
          // AppHelpers.showSnackBar(
          //   context,
          //   failure,
          // );
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setSelectedOrderType(String? type) {
    state = state.copyWith(orderType: type ?? state.orderType,selectedAddress: null,pickupAddress: null);
  }

  void setSelectedAddress({AddressData? address}) {
    final List<BagData> bags = List.from(LocalStorage.getBags());
    final user = bags[state.selectedBagIndex].selectedUser;
    final BagData bag = bags[state.selectedBagIndex]
        .copyWith(deliveryAddress: address, selectedUser: user);
    bags[state.selectedBagIndex] = bag;
    LocalStorage.setBags(bags);
    state = state.copyWith(bags: bags, selectedAddress: address);
  }

  void setInitialBagData(BuildContext context, BagData bag) {
    state = state.copyWith(
        selectedAddress: bag.selectedAddress,
        selectedUser: bag.selectedUser,
        selectedCurrency: bag.selectedCurrency,
        selectedPayment: bag.selectedPayment,
        orderType: state.orderType.isEmpty ? TrKeys.pickup : state.orderType);
    if (bag.selectedUser != null) {
      fetchUserDetails(
        checkYourNetwork: () {
          AppHelpers.showSnackBar(
            context,
            AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
          );
        },
      );
    }
    fetchCarts(
      checkYourNetwork: () {
        AppHelpers.showSnackBar(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }

  Future<void> fetchCurrencies({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isCurrenciesLoading: true, currencies: []);
      final response = await _currenciesRepository.getCurrencies();
      response.when(
        success: (data) async {
          state = state.copyWith(
            isCurrenciesLoading: false,
            currencies: data.data ?? [],
          );
          for (final currency in data.data ?? []) {
            if (currency.isDefault ?? false) {
              setSelectedCurrency(currency.id);
            }
          }
        },
        failure: (failure, status) {
          state = state.copyWith(isCurrenciesLoading: false);
          debugPrint('==> get currencies failure: $failure');
          // AppHelpers.showSnackBar(
          //   context,
          //   failure,
          // );
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setSelectedCurrency(int? currencyId) {
    final List<BagData> bags = List.from(LocalStorage.getBags());
    final user = bags[state.selectedBagIndex].selectedUser;
    final address = bags[state.selectedBagIndex].selectedAddress;
    CurrencyData? currencyData;
    for (final currency in state.currencies) {
      if (currencyId == currency.id) {
        currencyData = currency;
        break;
      }
    }
    final BagData bag = bags[state.selectedBagIndex].copyWith(
      deliveryAddress: address,
      selectedUser: user,
      selectedCurrency: currencyData,
    );
    bags[state.selectedBagIndex] = bag;
    LocalStorage.setBags(bags);
    state = state.copyWith(bags: bags, selectedCurrency: currencyData);
    fetchCarts(checkYourNetwork: () {}, isNotLoading: true);
  }

  Future<void> fetchPayments({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isPaymentsLoading: true, payments: []);
      final response = await _paymentsRepository.getPayments();
      response.when(
        success: (data) async {
          final List<PaymentData> payments = data.data ?? [];
          List<PaymentData> filteredPayments = [];
          for (final payment in payments) {
            if (payment.tag == 'cash' || payment.tag == 'wallet') {
              filteredPayments.add(payment);
            }
          }
          state = state.copyWith(
            isPaymentsLoading: false,
            payments: filteredPayments,
          );
          for (final payment in payments) {
            if (payment.tag == 'cash') {
              setSelectedPayment(payment.id);
            }
          }
        },
        failure: (failure, status) {
          state = state.copyWith(isPaymentsLoading: false);
          debugPrint('==> get payments failure: $failure');
          // AppHelpers.showSnackBar(
          //   context,
          //   failure,
          // );
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setSelectedPayment(int? paymentId) {
    final List<BagData> bags = List.from(LocalStorage.getBags());
    final user = bags[state.selectedBagIndex].selectedUser;
    final address = bags[state.selectedBagIndex].selectedAddress;
    PaymentData? paymentData;
    for (final payment in state.payments) {
      if (paymentId == payment.id) {
        paymentData = payment;
        break;
      }
    }
    final BagData bag = bags[state.selectedBagIndex].copyWith(
      deliveryAddress: address,
      selectedUser: user,
      selectedPayment: paymentData,
    );
    bags[state.selectedBagIndex] = bag;
    LocalStorage.setBags(bags);
    state = state.copyWith(bags: bags, selectedPayment: paymentData);
  }

  Future<void> fetchCarts({
    VoidCallback? checkYourNetwork,
    int? pointId,
    bool isNotLoading = false,
  }) async {
    final connected = await AppConnectivity.connectivity();

    if (connected) {
      BagData bag = LocalStorage.getBags()[state.selectedBagIndex];
      if (isNotLoading) {
        state = state.copyWith(
          isButtonLoading: true,
        );
      } else {
        state = state.copyWith(
          isProductCalculateLoading: true,
          paginateResponse: null,
          bags: LocalStorage.getBags(),
        );
      }

      final List<BagProductData> bagProducts =
          LocalStorage.getBags()[state.selectedBagIndex].bagProducts ?? [];
      if (bagProducts.isNotEmpty) {
        pointId ??=
            state.bags[state.selectedBagIndex].pickupAddress?.deliveryPoint?.id;

        final response =
            await _productsRepository.getAllCalculations(bag, state.orderType,
                // state.coupon,
                bagIndex: state.selectedBagIndex);

        response.when(
          success: (data) async {
            state = state.copyWith(
              isButtonLoading: false,
              isProductCalculateLoading: false,
              paginateResponse: data.data,
              //paginateResponseData: data.data
            );
            if (state.bags[state.selectedBagIndex].pickupAddress?.deliveryPoint
                    ?.price !=
                null) {
              state = state.copyWith(
                deliveryFee:state.paginateResponse?.deliveryFee ?? 0,
              );
            }
            if (data.data?.totalPrice != null && data.data?.totalPrice != 0) {
              state = state.copyWith(
                totalFee: state.orderType == TrKeys.delivery
                    ? ((data.data?.totalPrice ?? state.totalFee) +
                        (state.deliveryPrice?.price ?? 0))
                    : data.data?.totalPrice ?? state.totalFee,
              );
            }
            if (data.data?.serviceFee != null && data.data?.serviceFee != 0) {
              state = state.copyWith(
                serviceFee: data.data?.serviceFee ?? state.serviceFee,
              );
            }
            // if (data.data?.data?.couponPrice != null && data.data?.data?.couponPrice != 0) {
            //   state = state.copyWith(
            //     //coupon: data.data?.serviceFee ?? state.serviceFee,
            //   );
            // }
          },
          failure: (failure, status) {
            state = state.copyWith(
              isProductCalculateLoading: false,
              isButtonLoading: false,
            );
            debugPrint('==> get product calculate failure: $failure');
            // AppHelpers.showSnackBar(
            //   context,
            //   failure,
            // );
          },
        );
      }

      state = state.copyWith(
        isButtonLoading: false,
        isProductCalculateLoading: false,
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setDate(DateTime date) {
    state = state.copyWith(orderDate: date);
  }

  void setTime(TimeOfDay time) {
    state = state.copyWith(orderTime: time);
  }

  void clearBag(BuildContext context) {
    var newPagination = state.paginateResponse?.copyWith(stocks: []);
    state = state.copyWith(paginateResponse: newPagination);
    List<BagData> bags = List.from(LocalStorage.getBags());
    bags[state.selectedBagIndex] =
        bags[state.selectedBagIndex].copyWith(bagProducts: []);
    LocalStorage.setBags(bags);
  }

  void deleteProductFromBag(BuildContext context, BagProductData bagProduct) {
    final List<BagProductData> bagProducts = List.from(
        LocalStorage.getBags()[state.selectedBagIndex].bagProducts ?? []);
    int index = 0;
    for (int i = 0; i < bagProducts.length; i++) {
      if (bagProducts[i].stockId == bagProduct.stockId) {
        index = i;
        break;
      }
    }
    bagProducts.removeAt(index);
    List<BagData> bags = List.from(LocalStorage.getBags());
    bags[state.selectedBagIndex] =
        bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
    LocalStorage.setBags(bags);
    fetchCarts(
      checkYourNetwork: () {
        AppHelpers.showSnackBar(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }

  void deleteProductCount({
    required BagProductData? bagProductData,
    required int productIndex,
  }) {
    List<Stocks>? listOfProduct = state.paginateResponse?.stocks;
    listOfProduct?.removeAt(productIndex);
    PriceData? data = state.paginateResponse;
    PriceData? newData = data?.copyWith(stocks: listOfProduct);
    state = state.copyWith(paginateResponse: newData);
    final List<BagProductData> bagProducts =
        LocalStorage.getBags()[state.selectedBagIndex].bagProducts ?? [];
    bagProducts.removeAt(productIndex);

    List<BagData> bags = List.from(LocalStorage.getBags());
    bags[state.selectedBagIndex] =
        bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
    LocalStorage.setBags(bags);

    fetchCarts(isNotLoading: true);
  }

  void decreaseProductCount({
    required int productIndex,
  }) {
    timer?.cancel();
    Stocks? product = state.paginateResponse?.stocks?[productIndex];
    if ((product?.quantity ?? 1) > 1) {
      Stocks? newProduct = product?.copyWith(
        quantity: ((product.quantity ?? 0) - 1),
      );
      List<Stocks>? listOfProduct = state.paginateResponse?.stocks;
      listOfProduct?.removeAt(productIndex);
      listOfProduct?.insert(productIndex, newProduct ?? Stocks());
      PriceData? data = state.paginateResponse;
      PriceData? newData = data?.copyWith(stocks: listOfProduct);
      state = state.copyWith(paginateResponse: newData);
      final List<BagProductData> bagProducts =
          LocalStorage.getBags()[state.selectedBagIndex].bagProducts ?? [];
      for (int i = 0; i < bagProducts.length; i++) {
        if (bagProducts[i].stockId == product?.stock?.id) {
          BagProductData newProductData = bagProducts[i]
              .copyWith(quantity: (bagProducts[i].quantity ?? 0) - 1);
          bagProducts.removeAt(i);
          bagProducts.insert(i, newProductData);
          break;
        }
      }

      List<BagData> bags = List.from(LocalStorage.getBags());
      bags[state.selectedBagIndex] =
          bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
      LocalStorage.setBags(bags);
    } else {
      List<Stocks>? listOfProduct = state.paginateResponse?.stocks;
      listOfProduct?.removeAt(productIndex);
      PriceData? data = state.paginateResponse;
      PriceData? newData = data?.copyWith(stocks: listOfProduct);
      state = state.copyWith(paginateResponse: newData);
      final List<BagProductData> bagProducts =
          LocalStorage.getBags()[state.selectedBagIndex].bagProducts ?? [];
      for (int i = 0; i < bagProducts.length; i++) {
        if (bagProducts[i].stockId == product?.stock?.id) {
          bagProducts.removeAt(i);
          break;
        }
      }

      List<BagData> bags = List.from(LocalStorage.getBags());
      bags[state.selectedBagIndex] =
          bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
      LocalStorage.setBags(bags);
    }
    timer = Timer(
      const Duration(milliseconds: 500),
      () => fetchCarts(isNotLoading: true),
    );
  }

  void increaseProductCount({
    required int productIndex,
  }) {
    timer?.cancel();
    Stocks? product = state.paginateResponse?.stocks?[productIndex];
    Stocks? newProduct = product?.copyWith(
      quantity: ((product.quantity ?? 0) + 1),
    );
    List<Stocks>? listOfProduct = state.paginateResponse?.stocks;
    listOfProduct?.removeAt(productIndex);
    listOfProduct?.insert(productIndex, newProduct ?? Stocks());
    PriceData? data = state.paginateResponse;
    PriceData? newData = data?.copyWith(stocks: listOfProduct);
    state = state.copyWith(paginateResponse: newData);
    final List<BagProductData> bagProducts =
        LocalStorage.getBags()[state.selectedBagIndex].bagProducts ?? [];

    for (int i = 0; i < bagProducts.length; i++) {
      if (bagProducts[i].stockId == product?.id) {
        BagProductData newProductData = bagProducts[i]
            .copyWith(quantity: (bagProducts[i].quantity ?? 0) + 1);
        bagProducts.removeAt(i);
        bagProducts.insert(i, newProductData);
        break;
      }
    }

    List<BagData> bags = List.from(LocalStorage.getBags());
    bags[state.selectedBagIndex] =
        bags[state.selectedBagIndex].copyWith(bagProducts: bagProducts);
    LocalStorage.setBags(bags);
    timer = Timer(
      const Duration(milliseconds: 500),
      () => fetchCarts(isNotLoading: true),
    );
  }

  Future<void> placeOrder({
    VoidCallback? checkYourNetwork,
    VoidCallback? openSelectDeliveriesDrawer,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (state.orderType == TrKeys.dine) {
        openSelectDeliveriesDrawer?.call();
      } else {
        if (state.selectedUser == null) {
          state = state.copyWith(selectUserError: TrKeys.selectUser);
          return;
        }
        if (state.selectedAddress == null &&
            (state.orderType == TrKeys.delivery)) {
          state = state.copyWith(
              selectAddressError: TrKeys.selectAddress, selectUserError: null);
          return;
        }
        if (state.selectedCurrency == null) {
          state = state.copyWith(
              selectCurrencyError: TrKeys.selectCurrency,
              selectUserError: null,
              selectAddressError: null);
          return;
        }
        if (state.selectedPayment == null) {
          state = state.copyWith(
              selectPaymentError: TrKeys.selectPayment,
              selectUserError: null,
              selectAddressError: null,
              selectCurrencyError: null);
          return;
        }
        state = state.copyWith(
            selectPaymentError: null,
            selectUserError: null,
            selectAddressError: null,
            selectCurrencyError: null);
        openSelectDeliveriesDrawer?.call();
      }
    } else {
      checkYourNetwork?.call();
    }
  }

  setNote(String note) {
    state = state.copyWith(comment: note);
  }

  void getDeliveryPrices() async {
    final res = await _addressRepository.getDeliveryPrice(
      countryId: state.pickupAddress?.country?.id ?? 0,
      cityId: state.pickupAddress?.city?.id ?? 0,
    );
    res.when(success: (data) async {
      if (data.data?.isNotEmpty ?? false) {
        state = state.copyWith(deliveryPrice: data.data?.first);
        List<BagData> bags = LocalStorage.getBags();
        BagData bag = bags[state.selectedBagIndex];
        bag = bag.copyWith(
            deliveryAddress: AddressData(deliveryPrice: state.deliveryPrice));
        bags[state.selectedBagIndex] = bag;
        await LocalStorage.setBags(bags);
        state = state.copyWith(
            deliveryPrice: bag.selectedAddress?.deliveryPointsData, bags: bags);
      }
    }, failure: (failure, status) {
      // AppHelpers.showSnackBar(
      //   context,
      //   failure,
      // );
    });
  }

  setDeliveryPoint(DeliveryPointsData? deliveryPoint) {
    List<BagData> bags = LocalStorage.getBags();
    BagData bag = bags[state.selectedBagIndex];
    bag = bag.copyWith(
        pickupAddress:
            bag.pickupAddress?.copyWith(deliveryPoint: deliveryPoint));
    bags[state.selectedBagIndex] = bag;
    LocalStorage.setBags(bags);
    state = state.copyWith(pickupAddress: bag.pickupAddress, bags: bags);
  }

  Future createOrder(
    BuildContext context,
    OrderBodyData data, {
    VoidCallback? onSuccess,
    int? deliveryPriceId,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isOrderLoading: true);
      final num wallet = state.selectedUser?.wallet?.price ?? 0;
      if (data.bagData.selectedPayment?.tag == "wallet" &&
          wallet < (state.paginateResponse?.totalPrice ?? 0)) {
        if (context.mounted) {
          AppHelpers.showSnackBar(
              context, AppHelpers.getTranslation(TrKeys.notEnoughMoney));
        }
        state = state.copyWith(isOrderLoading: false);
        return;
      }
      final response = await _ordersRepository.createOrder(data);
      response.when(
        success: (res) async {
          state = state.copyWith(isOrderLoading: false);
          onSuccess?.call();
          removeOrderedBag(context);
          switch (data.bagData.selectedPayment?.tag) {
            case 'cash':
              _paymentsRepository.createTransaction(
                  orderId: res.data?.id ?? 0,
                  paymentId: data.bagData.selectedPayment?.id ?? 0,
                  deliveryPriceId: deliveryPriceId);
              break;
            case 'wallet':
              _paymentsRepository.createTransaction(
                  orderId: res.data?.id ?? 0,
                  paymentId: data.bagData.selectedPayment?.id ?? 0,
                  deliveryPriceId: deliveryPriceId);
              break;
            default:
              _paymentsRepository.createTransaction(
                  orderId: res.data?.id ?? 0,
                  paymentId: data.bagData.selectedPayment?.id ?? 0);
              break;
          }
        },
        failure: (failure, status) {
          state = state.copyWith(isOrderLoading: false);
          if (mounted) {
            AppHelpers.showSnackBar(
              context,
              AppHelpers.getTranslation(500.toString()),
            );
          }
        },
      );
    } else {
      if (context.mounted) {
        AppHelpers.showSnackBar(
            context, AppHelpers.getTranslation(TrKeys.noInternetConnection));
      }
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    state.phoneNumberController?.dispose();
    super.dispose();
  }
}
