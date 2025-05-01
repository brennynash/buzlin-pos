import 'dart:async';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'order_details_state.dart';

class OrderDetailsNotifier extends StateNotifier<OrderDetailsState> {
  final OrdersRepository _ordersRepository;
  final UsersFacade _usersRepository;
  final ProductsRepository _productsRepository;

  OrderDetailsNotifier(this._ordersRepository, this._usersRepository, this._productsRepository)
      : super(const OrderDetailsState());
  Timer? _searchUsersTimer;
  String _replaceNote = '';
  String _replacePhone = '';
  String _orderId = '';

  void clear(){
    _replacePhone = '';
    _replacePhone = '';
    _orderId = '';
    state = state.copyWith(changedStock: null, changedQuantity: 0);
  }

  Future<void> updateOrderStatus({
    required OrderStatus status,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isUpdating: true);
    final response = await _ordersRepository.updateOrderStatus(
      status: status,
      orderId: state.order?.id,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isUpdating: false);
        fetchOrderDetails(order: state.order);
        success?.call();
      },
      failure: (failure, status) {
        debugPrint('===> update order status fail $failure');
        state = state.copyWith(isUpdating: false);
        // AppHelpers.showSnackBar(
        //   context,
        //   failure,
        // );
      },
    );
  }

  bool compareOrderIdForTracking(OrderData data) {
    return data.id.toString() == _orderId;
  }

    Future<void> updateOrderTracking(
        BuildContext context, {
          required String name,
          required String id,
          String? url,
          VoidCallback? success,
        }) async {

      state = state.copyWith(isUpdating: true);
      final response = await _ordersRepository.updateOrderTracking(
        name: name,
        id: id,
        url: url,
        orderId: state.order?.id ?? 0,
      );
      response.when(
        success: (data) {
          OrderData? temp = state.order?.copyWith(
            trackId: id,
            trackUrl: url,
            trackName: name,
          );
          state = state.copyWith(isUpdating: false, order: temp);
          _orderId = state.order?.id.toString() ?? "";
          success?.call();
        },
        failure: (failure, status) {
          debugPrint('===> update order tracking fail $failure');
          state = state.copyWith(isUpdating: false);
          AppHelpers.errorSnackBar(context, text: failure);
        },
      );
    }

  void setReplaceNote(String value){
    _replaceNote = value;
  }

  void setReplacePhone(String value){
    _replacePhone = value;
  }

  void setStock(Stocks stockData) {
    if (state.changedStock?.id == stockData.id) {
      deleteStock();
      return;
    }
    state = state.copyWith(changedStock: stockData);
  }

  void deleteStock() {
    state = state.copyWith(changedStock: null);
  }
  void setProduct(ProductData? product) {
    final List<Stocks> stocks = product?.stocks ?? <Stocks>[];
    state = state.copyWith(
      isLoading: false,
      initialStocks: stocks,
      stockCount: state.productData?.minQty ?? 0,
    );
  }
  void setOldStock(Stocks? stocks) {
    state = state.copyWith(oldStock: stocks);
  }

  void setNewStock(Stocks? stocks, ProductData product) {
    state = state.copyWith(changedStock: stocks, productData: product);
  }

  void setQuantity(int quantity) => state = state.copyWith(changedQuantity: quantity);

  void updateExtras() {
    final int groupsCount = state.initialStocks[0].extras?.length ?? 0;
    final List<TypedExtra> groupExtras = [];
    for (int i = 0; i < groupsCount; i++) {
      if (i == 0) {
        final TypedExtra extras = StockFormat.getFirstExtras(
            state.selectedIndexes[0], state.initialStocks);
        groupExtras.add(extras);
      } else {
        final TypedExtra extras = StockFormat.getUniqueExtras(
          groupExtras,
          state.selectedIndexes,
          i,
          state.initialStocks,
        );
        groupExtras.add(extras);
      }
    }
    Stocks? selectedStock = StockFormat.getSelectedStock(
        groupExtras, state.initialStocks, state.selectedIndexes);
    state =
        state.copyWith(typedExtras: groupExtras, selectedStock: selectedStock);
  }

  void clearSelectedExtra(){
    state = state.copyWith(colorExtra: null, imageExtra: null, textExtra: null);
  }
  Future<void> getProductDetailsByIdEdited(
      String uuid,
      ValueChanged<ProductData?> onSuccess) async {
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository
        .getProductDetailsEdited(uuid);
    response.when(
      success: (data) async {
        state = state.copyWith(
          productData: data.data,
          isLoading: false,
        );
        onSuccess(data.data);
      },
      failure: (failure, s) {
        debugPrint('==> get product details failure: $failure');
      },
    );
    state = state.copyWith(isLoading: false);

  }

  void decreaseStockCount() {
    Stocks? stocks;
    if (state.changedQuantity == 1) {
      stocks = null;
    } else {
      stocks = state.changedStock?.copyWith(quantity: state.changedQuantity - 1);
    }
    state = state.copyWith(changedQuantity: state.changedQuantity - 1, changedStock: stocks);
  }

  void increaseStockCount(Stocks? stock) {
    int quantity = 0;
    quantity = state.changedStock?.id == stock?.id ? state.changedQuantity + 1 : 1;
    if ((stock?.quantity ?? 0) < quantity) {
      return;
    }
    state = state.copyWith(
      changedQuantity: quantity,
      changedStock: stock?.copyWith(
        quantity: quantity,
      ),
    );
  }

  Future<void> updateOrderStockId({
    required BuildContext context,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isUpdating: true);
    final response = await _ordersRepository.updateOrderStockId(
      order: state.order,
      stockId: state.changedStock?.id ?? 0,
      quantity: state.changedStock?.quantity ?? 0,
      replaceStockId:  state.oldStock?.stock?.id ?? 0,
      replaceQuantity: state.oldStock?.quantity ?? 0,
      replaceNote: _replaceNote,
      currencyId: state.order?.currencyId??LocalStorage.getSelectedCurrency()?.id,
      phone: _replacePhone.isNotEmpty
          ? _replacePhone
          : state.order?.user?.phone
          ?? state.order?.myAddress?.phone,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isUpdating: false);
        fetchOrderDetails(order: state.order);
        success?.call();
      },
      failure: (failure, status) {
        debugPrint('===> update order stock id fail $failure');
        state = state.copyWith(isUpdating: false);
        AppHelpers.showSnackBar(
          context,
          failure,
        );
      },
    );
  }

  // void toggleOrderDetailChecked({required int index}) {
  //   List<OrderDetail>? orderDetails = state.order?.details;
  //   if (orderDetails == null || orderDetails.isEmpty) {
  //     return;
  //   }
  //   OrderDetail detail = orderDetails[index];
  //   final bool isChecked = detail.isChecked ?? false;
  //   detail = detail.copyWith(isChecked: !isChecked);
  //   orderDetails[index] = detail;
  //   final order = state.order?.copyWith(details: orderDetails);
  //   state = state.copyWith(order: order);
  // }

  void changeStatus(String status) {
    state = state.copyWith(status: status);
  }

  Future<void> fetchOrderDetails({OrderData? order}) async {

    state = state.copyWith(isLoading: true, order: order);
    final response =
    await _ordersRepository.getOrderDetails(orderId: order?.id);
    response.when(
      success: (data) {
        state = state.copyWith(isLoading: false, order: data.data);
      },
      failure: (failure, status) {
        debugPrint('===> fetch order details fail $failure');
        state = state.copyWith(isLoading: false);
      },
    );
  }
  Future<void> fetchUsers({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isUsersLoading: true,
        dropdownUsers: [],
        users: [],
      );
      final response = await _usersRepository.searchDeliveryman(
          state.usersQuery.isEmpty ? null : state.usersQuery);
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
    state = state.copyWith(
      selectedUser: user,
    );

    setUsersQuery(context, '');
  }

  Future<void> setDeliveryMan(BuildContext context) async {
    state = state.copyWith(isUpdating: true);
    final response = await _ordersRepository.setDeliverMan(
      orderId: state.order?.id ?? 0,
      deliverymanId: state.selectedUser?.id ?? 0,
    );
    response.when(
      success: (data) {
        fetchOrderDetails(order: state.order);
      },
      failure: (failure, status) {
        debugPrint('===> set deliveryman fail $failure');
        AppHelpers.showSnackBar(
          context,
          AppHelpers.getTranslation(TrKeys.somethingWentWrongWithTheServer),
        );
      },
    );
  }

  void removeSelectedUser() {
    state = state.copyWith(
      selectedUser: null,
    );
  }
}