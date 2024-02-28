import 'package:eshop_multivendor/Helper/ApiBaseHelper.dart';
import '../Helper/Constant.dart';
import '../Helper/String.dart';

class AddressRepository {
  /// get areas
  static Future<Map<String, dynamic>> getArea({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      var result =
          await ApiBaseHelper().postAPICall(getAreaByCityApi, parameter);

      return result;
    } on Exception catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }
  /// get citys
  static Future<Map<String, dynamic>> getCitys({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      var result = await ApiBaseHelper().postAPICall(getCitiesApi, parameter);
     print('____parameter______${getCitiesApi}_____${parameter}____');
      return result;
    } on Exception catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }

  /// add and update api
  static Future<Map<String, dynamic>> addAndUpdateAddress({
    required Map<String, dynamic> parameter,
    required bool update,
  }) async {
    try {
      print('____aaaaa______${getAddAddressApi}____${parameter}_____');
      var result = await ApiBaseHelper().postAPICall(
        update ? updateAddressApi : getAddAddressApi,
        parameter,
      );

      return result;
    } on Exception catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }
}
