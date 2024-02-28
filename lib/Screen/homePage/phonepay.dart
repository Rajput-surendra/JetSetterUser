import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/String.dart';
import '../../widgets/appBar.dart';
import '../Language/languageSettings.dart';

class PhonepayGateway extends StatefulWidget {
  const PhonepayGateway({Key? key, required this.amount}) : super(key: key);
  final String amount;

  @override
  State<PhonepayGateway> createState() => _PhonepayGatewayState();
}

class _PhonepayGatewayState extends State<PhonepayGateway> {
  String? url;

  String? merchantId;

  String? merchantTransactionId;

  String? callBackUrl;

  String? _paymentStatus;

  bool? isPhonePayPaymentSuccess;

  String? mobile;
  InAppWebViewController? _webViewController;

  getPhonpayURL({int? i}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      mobile = preferences.getString("mobile");
      var headers = {
        'Cookie':
            'ci_session=21a0cce4198ce39adcae5825f47e9ae7fb206970; ekart_security_cookie=66d94dbdccb45e35b890fe9e55cb162e'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://jetsetterindia.com/app/v1/api/initiate_phone_payment'));
      request.fields.addAll({
        'user_id': CUR_USERID.toString(),
        'mobile': mobile.toString(),
        'amount': widget.amount,
      });

      request.headers.addAll(headers);

      print('_____request_____${request.fields}_________');

      http.StreamedResponse response = await request.send();
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      log(finalResult.toString());
      if (response.statusCode == 200) {
        url = finalResult['data']['data']['instrumentResponse']['redirectInfo']
            ['url'];
        setState(() {
          url;
        });
        merchantId = finalResult['data']['data']['merchantId'];
        merchantTransactionId =
            finalResult['data']['data']['merchantTransactionId'];
        print(merchantTransactionId.toString() + "______________________");
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  // initiatePayment() {
  //   print(url.toString() + "______________________");
  //   // Replace this with the actual PhonePe payment URL you have
  //   String phonePePaymentUrl = url ?? '';
  //   callBackUrl = "https://jetsetterindia.com/app/home/phonepay_success";
  // }

  getfat() async {
    var headers = {
      'Cookie': 'ci_session=fda639c7e3c8bd1817cf3d60effb9c425dfe81cb'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://jetsetterindia.com/app/v1/api/check_phonepay_status'));
    request.fields.addAll({'transaction_id': merchantTransactionId.toString()});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var responseData = jsonDecode(result);
      var err = responseData['error'];
      if (err == false) {
        String isError = responseData['data'][0]['error'];

        if (isError == true) {
          print('__________dddddddddddddd_________');
          Navigator.pop(context);
          // Payment success
          _paymentStatus = 'Payment Failure';
          isPhonePayPaymentSuccess = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Payment Failure')));
        } else {
          Navigator.pop(context);
          // isAdvancePaymentSuccess = false;
          // context.read<CartProvider>().totalPrice = context.read<CartProvider>().totalPrice - deductAmount!;
          //context.read<CartProvider>().deductAmount = deductAmount ?? 0.0 ;
          setState(() {});
          // Payment failure
          _paymentStatus = 'Payment Success';
          isPhonePayPaymentSuccess = true;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Payment Success')));
        }
      } else {
        // Navigator.pop(context);
      }
      print("11111111111${responseData}");
    } else {
      print(response.reasonPhrase);
    }
  }

  late Future my;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    my = getPhonpayURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          getSimpleAppBar(getTranslated(context, 'PhonePe Payment')!, context),
      body: FutureBuilder(
          future: my,
          builder: (context, snap) {
            return snap.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(url!)),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    onLoadStart: ((controller, url) {}),
                    onLoadStop: (controller, url) async {
                      getfat();
                      // _handlePaymentStatus(url.toString());
                      print("${callBackUrl} hsjgdsjgdjsgjd" +
                          "${url.toString()} MKJKJKLHKHKGKGKJG");
                      if (url.toString().contains(callBackUrl!)) {
                        // Extract payment status from URL
                        /// String? paymentStatus = extractPaymentStatusFromUrl(url.toString());
                        ///

                        await _webViewController?.stopLoading();

                        if (await _webViewController?.canGoBack() ?? false) {
                          await _webViewController?.goBack();
                        } else {
                          Navigator.pop(context);
                        }

                        // Update payment status
                        /*setState(() {
                      _paymentStatus = paymentStatus!;
                    });*/
                        // Stop loading and close WebView
                      }
                    },
                  );
          }),
    );
  }
}
