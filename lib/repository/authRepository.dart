import '../Helper/ApiBaseHelper.dart';
import '../Helper/Constant.dart';
import '../Helper/String.dart';

class AuthRepository {
  //
  //This method is used to fetch System policies {e.g. Privacy Policy, T&C etc..}
  static Future<Map<String, dynamic>> fetchLoginData({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      var loginDetail =
          await ApiBaseHelper().postAPICall(getUserLoginApi, parameter);

      return loginDetail;
    } on Exception catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }

  //validate referl code
 static Future<Map<String, dynamic>> validateReferal({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      var result =
          await ApiBaseHelper().postAPICall(validateReferalApi, parameter);

      return result;
    } on Exception catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }
  static Future<Map<String, dynamic>> fetchverificationData({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      print('_____parameter_111____${getVerifyUserApi}_____${parameter}____');
      var loginDetail =
          await ApiBaseHelper().postAPICall(getVerifyUserApi, parameter);

      return loginDetail;
    } on Exception catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }

  static Future<Map<String, dynamic>> fetchOtpData({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      print('_____parameter_____${sendOtpApi}______${parameter}___');
      var otpDetail =
      await ApiBaseHelper().postAPICall(sendOtpApi, parameter);

      return otpDetail;
    } on Exception catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }

  static Future<Map<String, dynamic>> fetchSingUpData({
    required Map<String, dynamic> parameter,
  }) async {
    print('___________${parameter}__________');
    print('___________${getUserSignUpApi}__________');
    try {
      var loginDetail =
          await ApiBaseHelper().postAPICall(getUserSignUpApi, parameter);

      return loginDetail;
    } on Exception catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }

  static Future<Map<String, dynamic>> fetchFetchReset({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      var loginDetail =
          await ApiBaseHelper().postAPICall(getResetPassApi, parameter);

      return loginDetail;
    } on Exception catch (e) {
      throw ApiException('$errorMesaage${e.toString()}');
    }
  }
}
