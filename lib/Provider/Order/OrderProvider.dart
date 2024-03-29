import 'package:flutter/cupertino.dart';
import '../../Helper/Constant.dart';
import '../../Helper/String.dart';
import '../../Helper/routes.dart';
import '../../Model/Order_Model.dart';
import '../../repository/Order/OrderRepository.dart';

enum OrderStatus {
  initial,
  inProgress,
  isSuccsess,
  isFailure,
  isMoreLoading,
}

class OrderProvider extends ChangeNotifier {
  OrderStatus _OrderStatus = OrderStatus.initial;
  List<OrderModel> OrderList = [];
  String errorMessage = '';
  int OrderOffset = 0;
  final int _OrderPerPage = perPage;
  String? activeStatus;
  bool isNodata = false;

  bool hasMoreData = true;
  bool isGettingdata = false;

  get getCurrentStatus => _OrderStatus;

  changeStatus(OrderStatus status) {
    _OrderStatus = status;
    notifyListeners();
  }

  Future<void> getOrder(BuildContext context, String searchText,bool isTrue
      ) async {
    try {
      if (hasMoreData) {
        hasMoreData = false;
        isGettingdata = true;
        if (OrderOffset == 0) {
          OrderList = [];
        }
        changeStatus(OrderStatus.inProgress);
        if (CUR_USERID != null) {
          var parameter = {
            LIMIT: _OrderPerPage.toString(),
            OFFSET: OrderOffset.toString(),
            USER_ID: CUR_USERID,
            SEARCH: searchText ?? "",
          };
          print('______ddddd____${parameter}_________');
          if (activeStatus != null) {
            if (activeStatus == awaitingPayment) activeStatus = 'awaiting';
            parameter[ACTIVE_STATUS] = activeStatus;
          }

          Map<String, dynamic> result =
          await OrderRepository.fetchOrder(parameter: parameter);
          bool error = result['error'];
          print('____dddddddddd_______${result['error']}__________');

          isGettingdata = false;
          if (OrderOffset == 0) isNodata = error;
          print('___________${parameter}__________');
          if (!error) {
            if (result.isNotEmpty) {
              List<OrderModel> allitems = [];
              List<OrderModel> tempList = [];

              for (var element in (result['orderList'] as List)) {
                tempList.add(element);
              }
              allitems.addAll(tempList);
              for (OrderModel item in tempList) {
                OrderList.where((i) => i.id == item.id).map(
                      (obj) {
                    allitems.remove(item);
                    return obj;
                  },
                ).toList();
              }
              OrderList.addAll(allitems);
              OrderOffset += _OrderPerPage;
              hasMoreData = true;
            } else {
              hasMoreData = false;
            }
            hasMoreData = false;
            changeStatus(OrderStatus.isSuccsess);
          } else {
            changeStatus(OrderStatus.isSuccsess);
          }
        } else {
          hasMoreData = false;
          Future.delayed(const Duration(seconds: 1)).then(
                (_) {
              Routes.navigateToLoginScreen(context);
            },
          );
        }
      }
    } catch (e) {
      errorMessage = e.toString();
      print('___________${e.toString()}__________');

      changeStatus(OrderStatus.isFailure);
    }
  }
}
