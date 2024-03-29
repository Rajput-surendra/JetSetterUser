import 'package:eshop_multivendor/Helper/ApiBaseHelper.dart';
import 'package:eshop_multivendor/Model/Section_Model.dart';
import 'package:eshop_multivendor/Model/delivery_charges_response.dart';
import '../Helper/Constant.dart';
import '../Helper/String.dart';

class CartRepository {
  static Future<Map<String, dynamic>> clearCart(
      {required Map<String, dynamic> parameter}) async {
    try {
      var cartData = await ApiBaseHelper().postAPICall(clearCartApi, parameter);
      return cartData;
    } catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }

  static Future<Map<String, dynamic>> fetchUserCart(
      {required Map<String, dynamic> parameter}) async {
    try {
      var cartData = await ApiBaseHelper().postAPICall(getCartApi, parameter);
      return {
        'error': cartData['error'],
        'message': cartData['message'],
        'cartList': (cartData['data'] as List)
            .map((data) => SectionModel.fromCart(data))
            .toList()
      };
    } catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }

  static Future<Map<String, dynamic>> fetchDeliveryCharge() async {
    try {
      var cartData = await ApiBaseHelper().getAPICall(getDeliveryChargeApi);
      print('_____getDeliveryChargeApi_____${getDeliveryChargeApi}_________');
      return {
        'error': cartData['error'],
        'message': cartData['message'],
        'deliveryCharge': (cartData['data'] as List)
            .map((data) => DeliveryChargeData.fromJson(data))
            .toList()

      };
    } catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }

  static Future<Map<String, dynamic>> fetchUserOfflineCart(
      {required Map<String, dynamic> parameter}) async {
    try {
      var offlineCartData =
          await ApiBaseHelper().postAPICall(getProductApi, parameter);
      return {
        'error': offlineCartData['error'],
        'message': offlineCartData['message'],
        'offlineCartList': (offlineCartData['data'] as List)
            .map((data) => Product.fromJson(data))
            .toList()
      };
    } catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }

  ///SetSave For Latter Product .
  static Future<Map<String, dynamic>> manageCartAPICall({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      var result = await ApiBaseHelper().postAPICall(manageCartApi, parameter);

      return result;
    } on Exception catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }
}
