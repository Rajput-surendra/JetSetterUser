// import 'dart:async';
// import 'dart:convert';
// import 'package:eshop_multivendor/Helper/Color.dart';
// import 'package:eshop_multivendor/Helper/routes.dart';
// import 'package:eshop_multivendor/Provider/Favourite/FavoriteProvider.dart';
// import 'package:eshop_multivendor/Provider/SettingProvider.dart';
// import 'package:eshop_multivendor/Provider/UserProvider.dart';
// import 'package:eshop_multivendor/Provider/authenticationProvider.dart';
// import 'package:eshop_multivendor/Provider/productDetailProvider.dart';
// import 'package:eshop_multivendor/Screen/Auth/Set_Password.dart';
// import 'package:eshop_multivendor/Screen/Auth/SignUp.dart';
// import 'package:eshop_multivendor/Screen/Dashboard/Dashboard.dart';
// import 'package:eshop_multivendor/widgets/desing.dart';
// import 'package:eshop_multivendor/widgets/security.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:http/http.dart';
// import 'package:provider/provider.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import '../../Helper/Constant.dart';
// import '../../Helper/String.dart';
// import '../../widgets/ButtonDesing.dart';
// import 'package:http/http.dart'as http;
// import '../../widgets/snackbar.dart';
// import '../Language/languageSettings.dart';
// import '../../widgets/networkAvailablity.dart';
//
// class VerifyOtp extends StatefulWidget {
//   final String? mobileNumber, countryCode, title;
//   String? responseOtp ;
//   bool? isMobile ,isTrue;
//    VerifyOtp(
//       {Key? key,
//       required String this.mobileNumber,
//       this.countryCode,this.isMobile,
//       this.title,this.responseOtp,this.isTrue})
//       : super(key: key);
//
//   @override
//   _MobileOTPState createState() => _MobileOTPState();
// }
//
// class _MobileOTPState extends State<VerifyOtp> with TickerProviderStateMixin {
//   final dataKey = GlobalKey();
//   String? password;
//   String? otp;
//   bool isCodeSent = false;
//   late String _verificationId;
//   String signature = '';
//   bool _isClickable = false;
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   Animation? buttonSqueezeanimation;
//   AnimationController? buttonController;
//
//   @override
//   void initState() {
//     super.initState();
//     getUserDetails();
//     //getSingature();
//     //_onVerifyCode();
//     Future.delayed(const Duration(seconds: 60)).then(
//       (_) {
//         _isClickable = true;
//       },
//     );
//     buttonController = AnimationController(
//         duration: const Duration(milliseconds: 2000), vsync: this);
//
//     buttonSqueezeanimation = Tween(
//       begin: deviceWidth! * 0.7,
//       end: 50.0,
//     ).animate(
//       CurvedAnimation(
//         parent: buttonController!,
//         curve: const Interval(
//           0.0,
//           0.150,
//         ),
//       ),
//     );
//   }
//
//   Future<void> getSingature() async {
//     signature = await SmsAutoFill().getAppSignature;
//     SmsAutoFill().listenForCode;
//   }
//
//   getUserDetails() async {
//     if (mounted) setState(() {});
//   }
//
//   Future<void> checkNetworkOtp() async {
//     isNetworkAvail = await isNetworkAvailable();
//     if (isNetworkAvail) {
//       if (_isClickable) {
//         _onVerifyCode();
//       } else {
//         setSnackbar(getTranslated(context, 'OTPWR')!, context);
//       }
//     } else {
//       if (mounted) setState(() {});
//
//       Future.delayed(const Duration(seconds: 60)).then(
//         (_) async {
//           isNetworkAvail = await isNetworkAvailable();
//           if (isNetworkAvail) {
//             if (_isClickable) {
//               _onVerifyCode();
//             } else {
//               setSnackbar(getTranslated(context, 'OTPWR')!, context);
//             }
//           } else {
//             await buttonController!.reverse();
//             setSnackbar(getTranslated(context, 'somethingMSg')!, context);
//           }
//         },
//       );
//     }
//   }
//
//   Widget verifyBtn() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10.0),
//       child: Center(
//         child: AppBtn(
//           title: getTranslated(context, 'VERIFY_AND_PROCEED'),
//           btnAnim: buttonSqueezeanimation,
//           btnCntrl: buttonController,
//           onBtnSelected: () async {
//
//             if(widget.isTrue ?? false){
//               print('__________durendra_________');
//
//               _onFormSubmitted();
//             }else{
//               print('__________rajpoot_________');
//               verifyOtp();
//
//             }
//
//           },
//         ),
//       ),
//     );
//   }
//
//   clearYouCartDialog() async {
//     await DesignConfiguration.dialogAnimate(
//       context,
//       StatefulBuilder(
//         builder: (BuildContext context, StateSetter setStater) {
//           return WillPopScope(
//             onWillPop: () async {
//               return false;
//             },
//             child: AlertDialog(
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     circularBorderRadius5,
//                   ),
//                 ),
//               ),
//               title: Text(
//                 getTranslated(context,
//                     'Your cart already has an items of another seller would you like to remove it ?')!,
//                 softWrap: true,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 3,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Theme.of(context).colorScheme.fontColor,
//                   fontWeight: FontWeight.normal,
//                   fontSize: textFontSize16,
//                   fontFamily: 'ubuntu',
//                 ),
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Center(
//                       child: SvgPicture.asset(
//                         DesignConfiguration.setSvgPath('appbarCart'),
//                         color: colors.primary,
//                         height: 50,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 25,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         child: Text(
//                           getTranslated(context, 'CANCEL')!,
//                           style: TextStyle(
//                             color: Theme.of(context).colorScheme.lightBlack,
//                             fontSize: textFontSize15,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'ubuntu',
//                           ),
//                         ),
//                         onPressed: () {
//                           Routes.pop(context);
//                           db.clearSaveForLater();
//                           Navigator.pushNamedAndRemoveUntil(
//                               context, '/home', (r) => false);
//                         },
//                       ),
//                       TextButton(
//                         child: Text(
//                           getTranslated(context, 'Clear Cart')!,
//                           style: const TextStyle(
//                             color: colors.primary,
//                             fontSize: textFontSize15,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'ubuntu',
//                           ),
//                         ),
//                         onPressed: () {
//                           if (CUR_USERID != null) {
//                             context.read<UserProvider>().setCartCount('0');
//                             context
//                                 .read<ProductDetailProvider>()
//                                 .clearCartNow()
//                                 .then(
//                                   (value) async {
//                                 if (context
//                                     .read<ProductDetailProvider>()
//                                     .error ==
//                                     false) {
//                                   if (context
//                                       .read<ProductDetailProvider>()
//                                       .snackbarmessage ==
//                                       'Data deleted successfully') {
//                                   } else {
//                                     setSnackbar(
//                                         context
//                                             .read<ProductDetailProvider>()
//                                             .snackbarmessage,
//                                         context);
//                                   }
//                                 } else {
//                                   setSnackbar(
//                                       context
//                                           .read<ProductDetailProvider>()
//                                           .snackbarmessage,
//                                       context);
//                                 }
//                                 Routes.pop(context);
//                                 await offCartAdd();
//                                 db.clearSaveForLater();
//                                 Navigator.pushNamedAndRemoveUntil(
//                                   context,
//                                   '/home',
//                                       (r) => false,
//                                 );
//                               },
//                             );
//                           } else {
//                             Routes.pop(context);
//                             db.clearSaveForLater();
//                             Navigator.pushNamedAndRemoveUntil(
//                               context,
//                               '/home',
//                                   (r) => false,
//                             );
//                           }
//                         },
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//
//   void _onVerifyCode() async {
//     if (mounted) {
//       setState(
//         () {
//           isCodeSent = true;
//         },
//       );
//     }
//     PhoneVerificationCompleted verificationCompleted() {
//       return (AuthCredential phoneAuthCredential) {
//         _firebaseAuth.signInWithCredential(phoneAuthCredential).then(
//           (UserCredential value) {
//             if (value.user != null) {
//               SettingProvider settingsProvider =
//                   Provider.of<SettingProvider>(context, listen: false);
//
//               setSnackbar(getTranslated(context, 'OTPMSG')!, context);
//               settingsProvider.setPrefrence(MOBILE, widget.mobileNumber!);
//               settingsProvider.setPrefrence(COUNTRY_CODE, widget.countryCode!);
//               if (widget.title == getTranslated(context, 'SEND_OTP_TITLE')) {
//                 Future.delayed(const Duration(seconds: 2)).then((_) {
//                   Navigator.pushReplacement(context,
//                       CupertinoPageRoute(builder: (context) => const SignUp()));
//                 });
//               } else if (widget.title ==
//                   getTranslated(context, 'FORGOT_PASS_TITLE')) {
//                 Future.delayed(const Duration(seconds: 2)).then(
//                   (_) {
//                     Navigator.pushReplacement(
//                       context,
//                       CupertinoPageRoute(
//                         builder: (context) => SetPass(
//                           mobileNumber: widget.mobileNumber!,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }
//             } else {
//               setSnackbar(getTranslated(context, 'OTPERROR')!, context);
//             }
//           },
//         ).catchError(
//           (error) {
//             setSnackbar(error.toString(), context);
//           },
//         );
//       };
//     }
//
//
//
//     PhoneVerificationFailed verificationFailed() {
//       return (FirebaseAuthException authException) {
//         if (mounted) {
//           setState(
//             () {
//               isCodeSent = false;
//             },
//           );
//         }
//       };
//     }
//
//     PhoneCodeSent codeSent() {
//       return (String verificationId, [int? forceResendingToken]) async {
//         _verificationId = verificationId;
//         if (mounted) {
//           setState(
//             () {
//               _verificationId = verificationId;
//             },
//           );
//         }
//       };
//     }
//
//     PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout() {
//       return (String verificationId) {
//         _verificationId = verificationId;
//         if (mounted) {
//           setState(
//             () {
//               _isClickable = true;
//               _verificationId = verificationId;
//             },
//           );
//         }
//       };
//     }
//
//     await _firebaseAuth.verifyPhoneNumber(
//       phoneNumber: '+${widget.countryCode}${widget.mobileNumber}',
//       timeout: const Duration(seconds: 60),
//       verificationCompleted: verificationCompleted(),
//       verificationFailed: verificationFailed(),
//       codeSent: codeSent(),
//       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout(),
//     );
//   }
//
//
//  Future<void> verifyOtp() async {
//
//    var headers = {
//      'Cookie': 'ci_session=02250dbf2e1d3cccb38f822763edbb0ad432555e'
//    };
//    var request = http.MultipartRequest('POST', Uri.parse('https://jetsetterindia.com/app/v1/api/verify_otp'));
//    request.fields.addAll({
//      'mobile': '${widget.mobileNumber}',
//      'otp': '${widget.responseOtp}',
//      'fcm_id': ''
//    });
//    request.headers.addAll(headers);
//    http.StreamedResponse response = await request.send();
//    if (response.statusCode == 200) {
//      var Result = await response.stream.bytesToString();
//      print('_________ssss____________${Result}__________');
//      var finalResult = jsonDecode(Result);
//
//      if(finalResult['error']== true){
//        setSnackbar(finalResult['message'], context);
//
//      }else {
//        var getdata = finalResult['data'];
//        UserProvider userProvider =
//        Provider.of<UserProvider>(context, listen: false);
//          userProvider.setName(finalResult['username'] ?? '');
//        userProvider.setEmail(finalResult[EMAIL] ?? '');
//        userProvider.setProfilePic(finalResult[IMAGE] ?? '');
//
//        SettingProvider settingProvider =
//        Provider.of<SettingProvider>(context, listen: false);
//        settingProvider.saveUserDetail(
//          finalResult['data'][0][ID],
//          finalResult[USERNAME],
//          finalResult[EMAIL],
//          finalResult[MOBILE],
//          finalResult[CITY],
//          finalResult[AREA],
//          finalResult[ADDRESS],
//          finalResult[PINCODE],
//          finalResult[LATITUDE],
//          finalResult[LONGITUDE],
//          finalResult[IMAGE],
//          context,
//        );
//        offFavAdd().then(
//              (value) async {
//            db.clearFav();
//            context.read<FavoriteProvider>().setFavlist([]);
//            List cartOffList = await db.getOffCart();
//            if (singleSellerOrderSystem && cartOffList.isNotEmpty) {
//              forLoginPageSingleSellerSystem = true;
//              offSaveAdd().then(
//                    (value) {
//                  clearYouCartDialog();
//                },
//              );
//            } else {
//              offCartAdd().then(
//                    (value) {
//                  db.clearCart();
//                  offSaveAdd().then(
//                        (value) {
//                      db.clearSaveForLater();
//                      Navigator.pushNamedAndRemoveUntil(
//                        context,
//                        '/home',
//                            (r) => false,
//                      );
//                    },
//                  );
//                },
//              );
//            }
//          },
//        );
//      }
//    }
//    else {
//      print(response.reasonPhrase);
//    }
//
//
//
//  }
//
//   Future<void> offFavAdd() async {
//     List favOffList = await db.getOffFav();
//     if (favOffList.isNotEmpty) {
//       for (int i = 0; i < favOffList.length; i++) {
//         _setFav(favOffList[i]['PID']);
//       }
//     }
//   }
//   Future<void> offSaveAdd() async {
//     List saveOffList = await db.getOffSaveLater();
//
//     if (saveOffList.isNotEmpty) {
//       for (int i = 0; i < saveOffList.length; i++) {
//         saveForLater(saveOffList[i]['VID'], saveOffList[i]['QTY']);
//       }
//     }
//   }
//
//   Future<void> offCartAdd() async {
//     List cartOffList = await db.getOffCart();
//     if (cartOffList.isNotEmpty) {
//       for (int i = 0; i < cartOffList.length; i++) {
//         addToCartCheckout(cartOffList[i]['VID'], cartOffList[i]['QTY']);
//       }
//     }
//   }
//
//   Future<void> addToCartCheckout(String varId, String qty) async {
//     isNetworkAvail = await isNetworkAvailable();
//     if (isNetworkAvail) {
//       try {
//         var parameter = {
//           PRODUCT_VARIENT_ID: varId,
//           USER_ID: CUR_USERID,
//           QTY: qty,
//         };
//
//         Response response =
//         await post(manageCartApi, body: parameter, headers: headers)
//             .timeout(const Duration(seconds: timeOut));
//         if (response.statusCode == 200) {
//           var getdata = json.decode(response.body);
//           if (getdata['message'] == 'One of the product is out of stock.') {
//             homePageSingleSellerMessage = true;
//           }
//         }
//       } on TimeoutException catch (_) {
//         setSnackbar(getTranslated(context, 'somethingMSg')!, context);
//       }
//     } else {
//       if (mounted) isNetworkAvail = false;
//
//       setState(() {});
//     }
//   }
//
//
//   _setFav(String pid) async {
//     isNetworkAvail = await isNetworkAvailable();
//     if (isNetworkAvail) {
//       try {
//         var parameter = {USER_ID: CUR_USERID, PRODUCT_ID: pid};
//         Response response =
//         await post(setFavoriteApi, body: parameter, headers: headers)
//             .timeout(const Duration(seconds: timeOut));
//
//         var getdata = json.decode(response.body);
//
//         bool error = getdata['error'];
//         String? msg = getdata['message'];
//         if (!error) {
//           setSnackbar(msg!, context);
//         } else {
//           setSnackbar(msg!, context);
//         }
//       } on TimeoutException catch (_) {
//         setSnackbar(getTranslated(context, 'somethingMSg')!, context);
//       }
//     } else {
//       if (mounted) {
//         setState(
//               () {
//             isNetworkAvail = false;
//           },
//         );
//       }
//     }
//   }
//
//   saveForLater(String vid, String qty) async {
//     isNetworkAvail = await isNetworkAvailable();
//     if (isNetworkAvail) {
//       try {
//         var parameter = {
//           PRODUCT_VARIENT_ID: vid,
//           USER_ID: CUR_USERID,
//           QTY: qty,
//           SAVE_LATER: '1'
//         };
//         Response response =
//         await post(manageCartApi, body: parameter, headers: headers)
//             .timeout(const Duration(seconds: timeOut));
//         var getdata = json.decode(response.body);
//         bool error = getdata['error'];
//         String? msg = getdata['message'];
//         if (!error) {
//         } else {
//           setSnackbar(msg!, context);
//         }
//       } on TimeoutException catch (_) {
//         setSnackbar(getTranslated(context, 'somethingMSg')!, context);
//       }
//     } else {
//       if (mounted) {
//         setState(
//               () {
//             isNetworkAvail = false;
//           },
//         );
//       }
//     }
//   }
//
//
//
//   void _onFormSubmitted() async {
//     _playAnimation();
//
//     String code = otp!.trim();
//
//     /*if (code.length == 6)*/if(code == widget.responseOtp) {
//       _playAnimation();
//
//       SettingProvider settingsProvider =
//       Provider.of<SettingProvider>(context, listen: false);
//
//       await buttonController!.reverse();
//       setSnackbar(getTranslated(context, 'OTPMSG')!, context);
//       settingsProvider.setPrefrence(MOBILE, widget.mobileNumber!);
//      /* settingsProvider.setPrefrence(COUNTRY_CODE, widget.countryCode!);*/
//
//     if (widget.title == getTranslated(context, 'SEND_OTP_TITLE')) {
//         Future.delayed(const Duration(seconds: 2)).then((_) {
//
//             Navigator.pushReplacement(context,
//                 CupertinoPageRoute(builder: (context) =>  SignUp(mobileNumber: widget.mobileNumber,)));
//
//
//         });
//       } else if (widget.title ==
//           getTranslated(context, 'FORGOT_PASS_TITLE')) {
//
//         Future.delayed(const Duration(seconds: 2)).then(
//               (_) {
//             Navigator.pushReplacement(
//               context,
//               CupertinoPageRoute(
//                 builder: (context) => Dashboard(
//                   // mobileNumber: widget.mobileNumber!,
//                 ),
//               ),
//             );
//           },
//         );
//       }
//       /*AuthCredential authCredential = PhoneAuthProvider.credential(
//           verificationId: _verificationId, smsCode: code);
//
//       _firebaseAuth
//           .signInWithCredential(authCredential)
//           .then((UserCredential value) async {
//         if (value.user != null) {
//           SettingProvider settingsProvider =
//               Provider.of<SettingProvider>(context, listen: false);
//
//           await buttonController!.reverse();
//           setSnackbar(getTranslated(context, 'OTPMSG')!, context);
//           settingsProvider.setPrefrence(MOBILE, widget.mobileNumber!);
//           settingsProvider.setPrefrence(COUNTRY_CODE, widget.countryCode!);
//           if (widget.title == getTranslated(context, 'SEND_OTP_TITLE')) {
//             Future.delayed(const Duration(seconds: 2)).then((_) {
//               Navigator.pushReplacement(context,
//                   CupertinoPageRoute(builder: (context) => const SignUp()));
//             });
//           } else if (widget.title ==
//               getTranslated(context, 'FORGOT_PASS_TITLE')) {
//             Future.delayed(const Duration(seconds: 2)).then(
//               (_) {
//                 Navigator.pushReplacement(
//                   context,
//                   CupertinoPageRoute(
//                     builder: (context) => SetPass(
//                       mobileNumber: widget.mobileNumber!,
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         } else {
//           setSnackbar(getTranslated(context, 'OTPERROR')!, context);
//           await buttonController!.reverse();
//         }
//       }).catchError((error) async {
//         setSnackbar(getTranslated(context, 'WRONGOTP')!, context);
//
//         await buttonController!.reverse();
//       });*/
//     } else {
//       setSnackbar(getTranslated(context, 'ENTEROTP')!, context);
//       await buttonController!.reverse();
//     }
//
//
//
//
//   }
//
//   Future<void> _playAnimation() async {
//     try {
//       await buttonController!.forward();
//     } on TickerCanceled {}
//   }
//
//   @override
//   void dispose() {
//     buttonController!.dispose();
//     super.dispose();
//   }
//
//   monoVarifyText() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.only(
//         top: 60.0,
//       ),
//       child: Text(
//         getTranslated(context, 'MOBILE_NUMBER_VARIFICATION')!,
//         style: Theme.of(context).textTheme.headline6!.copyWith(
//               color: Theme.of(context).colorScheme.fontColor,
//               fontWeight: FontWeight.bold,
//               fontSize: textFontSize23,
//               letterSpacing: 0.8,
//               fontFamily: 'ubuntu',
//             ),
//       ),
//     );
//   }
//
//   otpText() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.only(
//         top: 13.0,
//       ),
//       child: Text(
//         getTranslated(context, 'SENT_VERIFY_CODE_TO_NO_LBL')!,
//         style: Theme.of(context).textTheme.subtitle2!.copyWith(
//               color: Theme.of(context).colorScheme.fontColor.withOpacity(0.5),
//               fontWeight: FontWeight.bold,
//               fontFamily: 'ubuntu',
//             ),
//       ),
//     );
//   }
//
//
//   mobText() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.only(top: 5.0),
//       child: Text(
//         '+${widget.mobileNumber}',
//         style: Theme.of(context).textTheme.subtitle2!.copyWith(
//               color: Theme.of(context).colorScheme.fontColor.withOpacity(0.5),
//               fontWeight: FontWeight.bold,
//               fontFamily: 'ubuntu',
//             ),
//       ),
//     );
//   }
//
//   otpTextVisible() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.only(top: 5.0),
//       child: Text(
//         'Otp:- ${widget.responseOtp}',
//         style: Theme.of(context).textTheme.titleSmall!.copyWith(
//           color: Theme.of(context).colorScheme.fontColor.withOpacity(0.5),
//           fontWeight: FontWeight.bold,
//           fontFamily: 'ubuntu',
//         ),
//       ),
//     );
//   }
//
//   Widget otpLayout() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.only(top: 30),
//       child: PinFieldAutoFill(
//         decoration: BoxLooseDecoration(
//             textStyle: TextStyle(
//                 fontSize: textFontSize20,
//                 color: Theme.of(context).colorScheme.fontColor),
//             radius: const Radius.circular(circularBorderRadius4),
//             gapSpace: 15,
//             bgColorBuilder: FixedColorBuilder(
//                 Theme.of(context).colorScheme.lightWhite.withOpacity(0.4)),
//             strokeColorBuilder: FixedColorBuilder(
//                 Theme.of(context).colorScheme.fontColor.withOpacity(0.2))),
//         currentCode: otp,
//         codeLength: 6,
//         onCodeChanged: (String? code) {
//           otp = code;
//         },
//         onCodeSubmitted: (String code) {
//           otp = code;
//         },
//       ),
//
//     );
//   }
//
//   Widget resendText() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.only(top: 30.0),
//       child: Row(
//         children: [
//           Text(
//             getTranslated(context, 'DIDNT_GET_THE_CODE')!,
//             style: Theme.of(context).textTheme.caption!.copyWith(
//                   color:
//                       Theme.of(context).colorScheme.fontColor.withOpacity(0.5),
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'ubuntu',
//                 ),
//           ),
//           InkWell(
//             onTap: () async {
//               await buttonController!.reverse();
//               print('___________sdeferfergfer__________');
//                resendOTP2() ;
//              //checkNetworkOtp();
//             },
//             child: Text(
//               getTranslated(context, 'RESEND_OTP')!,
//               style: Theme.of(context).textTheme.caption!.copyWith(
//                     color: Theme.of(context).colorScheme.primary,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'ubuntu',
//                   ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Future <void> resendOTP() async{
//     Future.delayed(Duration.zero).then(
//           (value) => context.read<AuthenticationProvider>().senOtp().then(
//             (
//             value,
//             ) async {
//           bool? error = value['error'];
//           String? msg = value['message'];
//           int? receivedOTP = value['otp'] ;
//           await buttonController!.reverse();
//
//           if (!error!) {
//             widget.responseOtp =  receivedOTP.toString() ;
//             setState(() {});
//             setSnackbar(msg!, context);
//           } else {
//             setSnackbar(msg!, context);
//           }
//
//         },
//       ),
//     );
//   }
//
//   Future<void> resendOTP2() async {
//     isNetworkAvail = await isNetworkAvailable();
//     if (isNetworkAvail) {
//       Future.delayed(Duration.zero).then(
//             (value) => context.read<AuthenticationProvider>().getVerifyUser().then(
//               (
//               value,
//               ) async {
//             bool? error = value['error'];
//             String? msg = value['message'];
//             int? receivedOTP = value['data'] ;
//             print('_____dddd_____${receivedOTP}_________');
//             widget.responseOtp = receivedOTP.toString() ;
//             await buttonController!.reverse();
//             SettingProvider settingsProvider =
//             Provider.of<SettingProvider>(context, listen: false);
//             if (widget.title == getTranslated(context, 'SEND_OTP_TITLE')) {
//               if (!error!) {
//                 setSnackbar(msg!, context);
//               } else {
//                 setSnackbar(msg!, context);
//               }
//             }
//             if (widget.title == getTranslated(context, 'FORGOT_PASS_TITLE')) {
//               if (error!) {
//
//               } else {
//                 // setSnackbar(
//                 //     getTranslated(context, 'FIRSTSIGNUP_MSG')!, context);
//               }
//             }
//           },
//         ),
//       );
//     } else {
//       Future.delayed(const Duration(seconds: 2)).then(
//             (_) async {
//           if (mounted) {
//             setState(
//                   () {
//                 isNetworkAvail = false;
//               },
//             );
//           }
//           await buttonController!.reverse();
//         },
//       );
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     print('_____dddddddd_____${widget.responseOtp}_____${widget.isTrue}____');
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       key: _scaffoldKey,
//       backgroundColor: Theme.of(context).colorScheme.white,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.only(
//               top: 23,
//               left: 23,
//               right: 23,
//               bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               getLogo(),
//               monoVarifyText(),
//               otpText(),
//
//               mobText(),
//              //\otpTextVisible(),
//               otpLayout(),
//               resendText(),
//               verifyBtn(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget getLogo() {
//     return Container(
//       alignment: Alignment.center,
//       padding: const EdgeInsets.only(top: 0),
//       child: Image.asset('assets/images/png/splashlogo-removebg-preview.png',height:200,width:200,)
//     );
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Helper/routes.dart';
import 'package:eshop_multivendor/Provider/Favourite/FavoriteProvider.dart';
import 'package:eshop_multivendor/Provider/SettingProvider.dart';
import 'package:eshop_multivendor/Provider/UserProvider.dart';
import 'package:eshop_multivendor/Provider/authenticationProvider.dart';
import 'package:eshop_multivendor/Provider/productDetailProvider.dart';
import 'package:eshop_multivendor/Screen/Auth/Set_Password.dart';
import 'package:eshop_multivendor/Screen/Auth/SignUp.dart';
import 'package:eshop_multivendor/Screen/Dashboard/Dashboard.dart';
import 'package:eshop_multivendor/widgets/desing.dart';
import 'package:eshop_multivendor/widgets/security.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../Helper/Constant.dart';
import '../../Helper/String.dart';
import '../../widgets/ButtonDesing.dart';
import 'package:http/http.dart'as http;
import '../../widgets/snackbar.dart';
import '../Language/languageSettings.dart';
import '../../widgets/networkAvailablity.dart';

class VerifyOtp extends StatefulWidget {
  final String? mobileNumber, countryCode, title;
  String? responseOtp ;
  bool? isMobile,isTrue;
  VerifyOtp(
      {Key? key,
        required String this.mobileNumber,
        this.countryCode,this.isMobile,
        this.title,this.responseOtp,this.isTrue})
      : super(key: key);

  @override
  _MobileOTPState createState() => _MobileOTPState();
}

class _MobileOTPState extends State<VerifyOtp> with TickerProviderStateMixin {
  final dataKey = GlobalKey();
  String? password;
  String? otp;
  bool isCodeSent = false;
  late String _verificationId;
  String signature = '';
  bool _isClickable = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;

  @override
  void initState() {
    super.initState();
    getUserDetails();
    //getSingature();
    //_onVerifyCode();
    Future.delayed(const Duration(seconds: 60)).then(
          (_) {
        _isClickable = true;
      },
    );
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = Tween(
      begin: deviceWidth! * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }

  Future<void> getSingature() async {
    signature = await SmsAutoFill().getAppSignature;
    SmsAutoFill().listenForCode;
  }

  getUserDetails() async {
    if (mounted) setState(() {});
  }

  Future<void> checkNetworkOtp() async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      if (_isClickable) {
        _onVerifyCode();
      } else {
        setSnackbar(getTranslated(context, 'OTPWR')!, context);
      }
    } else {
      if (mounted) setState(() {});

      Future.delayed(const Duration(seconds: 60)).then(
            (_) async {
          isNetworkAvail = await isNetworkAvailable();
          if (isNetworkAvail) {
            if (_isClickable) {
              _onVerifyCode();
            } else {
              setSnackbar(getTranslated(context, 'OTPWR')!, context);
            }
          } else {
            await buttonController!.reverse();
            setSnackbar(getTranslated(context, 'somethingMSg')!, context);
          }
        },
      );
    }
  }

  Widget verifyBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: AppBtn(
          title: getTranslated(context, 'VERIFY_AND_PROCEED'),
          btnAnim: buttonSqueezeanimation,
          btnCntrl: buttonController,
          onBtnSelected: () async {

            if(widget.isTrue  == true){
              print('__________surendra________');
              verifyuser();
            }else{
              print('_________ddddddddd________');
             // _onFormSubmitted();

            }

          },
        ),
      ),
    );
  }

  clearYouCartDialog() async {
    await DesignConfiguration.dialogAnimate(
      context,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setStater) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    circularBorderRadius5,
                  ),
                ),
              ),
              title: Text(
                getTranslated(context,
                    'Your cart already has an items of another seller would you like to remove it ?')!,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.fontColor,
                  fontWeight: FontWeight.normal,
                  fontSize: textFontSize16,
                  fontFamily: 'ubuntu',
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SvgPicture.asset(
                        DesignConfiguration.setSvgPath('appbarCart'),
                        color: colors.primary,
                        height: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          getTranslated(context, 'CANCEL')!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.lightBlack,
                            fontSize: textFontSize15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ubuntu',
                          ),
                        ),
                        onPressed: () {
                          Routes.pop(context);
                          db.clearSaveForLater();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (r) => false);
                        },
                      ),
                      TextButton(
                        child: Text(
                          getTranslated(context, 'Clear Cart')!,
                          style: const TextStyle(
                            color: colors.primary,
                            fontSize: textFontSize15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ubuntu',
                          ),
                        ),
                        onPressed: () {
                          if (CUR_USERID != null) {
                            context.read<UserProvider>().setCartCount('0');
                            context
                                .read<ProductDetailProvider>()
                                .clearCartNow()
                                .then(
                                  (value) async {
                                if (context
                                    .read<ProductDetailProvider>()
                                    .error ==
                                    false) {
                                  if (context
                                      .read<ProductDetailProvider>()
                                      .snackbarmessage ==
                                      'Data deleted successfully') {
                                  } else {
                                    setSnackbar(
                                        context
                                            .read<ProductDetailProvider>()
                                            .snackbarmessage,
                                        context);
                                  }
                                } else {
                                  setSnackbar(
                                      context
                                          .read<ProductDetailProvider>()
                                          .snackbarmessage,
                                      context);
                                }
                                Routes.pop(context);
                                await offCartAdd();
                                db.clearSaveForLater();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/home',
                                      (r) => false,
                                );
                              },
                            );
                          } else {
                            Routes.pop(context);
                            db.clearSaveForLater();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home',
                                  (r) => false,
                            );
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  void _onVerifyCode() async {
    if (mounted) {
      setState(
            () {
          isCodeSent = true;
        },
      );
    }
    PhoneVerificationCompleted verificationCompleted() {
      return (AuthCredential phoneAuthCredential) {
        _firebaseAuth.signInWithCredential(phoneAuthCredential).then(
              (UserCredential value) {
            if (value.user != null) {
              SettingProvider settingsProvider =
              Provider.of<SettingProvider>(context, listen: false);

              setSnackbar(getTranslated(context, 'OTPMSG')!, context);
              settingsProvider.setPrefrence(MOBILE, widget.mobileNumber!);
              settingsProvider.setPrefrence(COUNTRY_CODE, widget.countryCode!);
              if (widget.title == getTranslated(context, 'SEND_OTP_TITLE')) {
                Future.delayed(const Duration(seconds: 2)).then((_) {
                  Navigator.pushReplacement(context,
                      CupertinoPageRoute(builder: (context) => const SignUp()));
                });
              } else if (widget.title ==
                  getTranslated(context, 'FORGOT_PASS_TITLE')) {
                Future.delayed(const Duration(seconds: 2)).then(
                      (_) {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => SetPass(
                          mobileNumber: widget.mobileNumber!,
                        ),
                      ),
                    );
                  },
                );
              }
            } else {
              setSnackbar(getTranslated(context, 'OTPERROR')!, context);
            }
          },
        ).catchError(
              (error) {
            setSnackbar(error.toString(), context);
          },
        );
      };
    }



    PhoneVerificationFailed verificationFailed() {
      return (FirebaseAuthException authException) {
        if (mounted) {
          setState(
                () {
              isCodeSent = false;
            },
          );
        }
      };
    }

    PhoneCodeSent codeSent() {
      return (String verificationId, [int? forceResendingToken]) async {
        _verificationId = verificationId;
        if (mounted) {
          setState(
                () {
              _verificationId = verificationId;
            },
          );
        }
      };
    }

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout() {
      return (String verificationId) {
        _verificationId = verificationId;
        if (mounted) {
          setState(
                () {
              _isClickable = true;
              _verificationId = verificationId;
            },
          );
        }
      };
    }

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+${widget.countryCode}${widget.mobileNumber}',
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationCompleted(),
      verificationFailed: verificationFailed(),
      codeSent: codeSent(),
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout(),
    );
  }


  Future<void> verifyuser() async {

    var headers = {
      'Cookie': 'ci_session=02250dbf2e1d3cccb38f822763edbb0ad432555e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}verify_otp'));
    request.fields.addAll({
      'mobile': '${widget.mobileNumber}',
      'otp': '${otp}',
      'fcm_id': ''
    });
    print('___sdssds_______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      var finalResult = jsonDecode(Result);
      log(Result.toString());

      if(finalResult['error']){
        setSnackbar(finalResult['message'], context);

      }else {
        var getdata = finalResult['data'][0];
        UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
        userProvider.setName(getdata[USERNAME] ?? '');
        userProvider.setEmail(getdata[EMAIL] ?? '');
        userProvider.setProfilePic(getdata[IMAGE] ?? '');
        userProvider.setUserId(getdata[ID] ?? '');
          print('___userId_______${getdata[ID]}_________');
        CUR_USERID = getdata[ID];

        SettingProvider settingProvider =
        Provider.of<SettingProvider>(context, listen: false);
        settingProvider.saveUserDetail(

          getdata[ID],
          getdata[USERNAME],
          getdata[EMAIL],
          getdata[MOBILE],
          getdata[CITY],
          getdata[AREA],
          getdata[ADDRESS],
          getdata[PINCODE],
          getdata[LATITUDE],
          getdata[LONGITUDE],
          getdata[IMAGE],
          context,
        );
        offFavAdd().then(
              (value) async {
            db.clearFav();
            context.read<FavoriteProvider>().setFavlist([]);
            List cartOffList = await db.getOffCart();
            if (singleSellerOrderSystem && cartOffList.isNotEmpty) {
              forLoginPageSingleSellerSystem = true;
              offSaveAdd().then(
                    (value) {
                  clearYouCartDialog();
                },
              );
            } else {
              offCartAdd().then(
                    (value) {
                  db.clearCart();
                  offSaveAdd().then((value) {db.clearSaveForLater();
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const Dashboard(),
                    ),
                  );
                    },
                  );
                },
              );
            }
          },
        );
      }
    }
    else {
      print(response.reasonPhrase);
    }



  }

  Future<void> offFavAdd() async {
    List favOffList = await db.getOffFav();
    if (favOffList.isNotEmpty) {
      for (int i = 0; i < favOffList.length; i++) {
        _setFav(favOffList[i]['PID']);
      }
    }
  }
  Future<void> offSaveAdd() async {
    List saveOffList = await db.getOffSaveLater();

    if (saveOffList.isNotEmpty) {
      for (int i = 0; i < saveOffList.length; i++) {
        saveForLater(saveOffList[i]['VID'], saveOffList[i]['QTY']);
      }
    }
  }

  Future<void> offCartAdd() async {
    List cartOffList = await db.getOffCart();
    if (cartOffList.isNotEmpty) {
      for (int i = 0; i < cartOffList.length; i++) {
        addToCartCheckout(cartOffList[i]['VID'], cartOffList[i]['QTY']);
      }
    }
  }

  Future<void> addToCartCheckout(String varId, String qty) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      try {
        var parameter = {
          PRODUCT_VARIENT_ID: varId,
          USER_ID: CUR_USERID,
          QTY: qty,
        };

        Response response =
        await post(manageCartApi, body: parameter, headers: headers)
            .timeout(const Duration(seconds: timeOut));
        if (response.statusCode == 200) {
          var getdata = json.decode(response.body);
          if (getdata['message'] == 'One of the product is out of stock.') {
            homePageSingleSellerMessage = true;
          }
        }
      } on TimeoutException catch (_) {
        setSnackbar(getTranslated(context, 'somethingMSg')!, context);
      }
    } else {
      if (mounted) isNetworkAvail = false;

      setState(() {});
    }
  }


  _setFav(String pid) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      try {
        var parameter = {USER_ID: CUR_USERID, PRODUCT_ID: pid};
        Response response =
        await post(setFavoriteApi, body: parameter, headers: headers)
            .timeout(const Duration(seconds: timeOut));

        var getdata = json.decode(response.body);

        bool error = getdata['error'];
        String? msg = getdata['message'];
        if (!error) {
          setSnackbar(msg!, context);
        } else {
          setSnackbar(msg!, context);
        }
      } on TimeoutException catch (_) {
        setSnackbar(getTranslated(context, 'somethingMSg')!, context);
      }
    } else {
      if (mounted) {
        setState(
              () {
            isNetworkAvail = false;
          },
        );
      }
    }
  }

  saveForLater(String vid, String qty) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      try {
        var parameter = {
          PRODUCT_VARIENT_ID: vid,
          USER_ID: CUR_USERID,
          QTY: qty,
          SAVE_LATER: '1'
        };
        Response response =
        await post(manageCartApi, body: parameter, headers: headers)
            .timeout(const Duration(seconds: timeOut));
        var getdata = json.decode(response.body);
        bool error = getdata['error'];
        String? msg = getdata['message'];
        if (!error) {
        } else {
          setSnackbar(msg!, context);
        }
      } on TimeoutException catch (_) {
        setSnackbar(getTranslated(context, 'somethingMSg')!, context);
      }
    } else {
      if (mounted) {
        setState(
              () {
            isNetworkAvail = false;
          },
        );
      }
    }
  }



  void _onFormSubmitted() async {
    _playAnimation();

    String code = otp!.trim();

    /*if (code.length == 6)*/if(code == widget.responseOtp) {
      _playAnimation();

      SettingProvider settingsProvider =
      Provider.of<SettingProvider>(context, listen: false);

      await buttonController!.reverse();
      setSnackbar(getTranslated(context, 'OTPMSG')!, context);
      settingsProvider.setPrefrence(MOBILE, widget.mobileNumber!);
      //settingsProvider.setPrefrence(COUNTRY_CODE, widget.countryCode!);

      if (widget.title == getTranslated(context, 'SEND_OTP_TITLE')) {
        Future.delayed(const Duration(seconds: 2)).then((_) {

          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) =>  SignUp(mobileNumber: widget.mobileNumber,)));


        });
      } else if (widget.title ==
          getTranslated(context, 'FORGOT_PASS_TITLE')) {
        Future.delayed(const Duration(seconds: 2)).then(
              (_) {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => SetPass(
                  mobileNumber: widget.mobileNumber!,
                ),
              ),
            );
          },
        );
      }
      /*AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code);

      _firebaseAuth
          .signInWithCredential(authCredential)
          .then((UserCredential value) async {
        if (value.user != null) {
          SettingProvider settingsProvider =
              Provider.of<SettingProvider>(context, listen: false);

          await buttonController!.reverse();
          setSnackbar(getTranslated(context, 'OTPMSG')!, context);
          settingsProvider.setPrefrence(MOBILE, widget.mobileNumber!);
          settingsProvider.setPrefrence(COUNTRY_CODE, widget.countryCode!);
          if (widget.title == getTranslated(context, 'SEND_OTP_TITLE')) {
            Future.delayed(const Duration(seconds: 2)).then((_) {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => const SignUp()));
            });
          } else if (widget.title ==
              getTranslated(context, 'FORGOT_PASS_TITLE')) {
            Future.delayed(const Duration(seconds: 2)).then(
              (_) {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SetPass(
                      mobileNumber: widget.mobileNumber!,
                    ),
                  ),
                );
              },
            );
          }
        } else {
          setSnackbar(getTranslated(context, 'OTPERROR')!, context);
          await buttonController!.reverse();
        }
      }).catchError((error) async {
        setSnackbar(getTranslated(context, 'WRONGOTP')!, context);

        await buttonController!.reverse();
      });*/
    } else {
      setSnackbar(getTranslated(context, 'ENTEROTP')!, context);
      await buttonController!.reverse();
    }




  }

  Future<void> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    buttonController!.dispose();
    super.dispose();
  }

  monoVarifyText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 60.0,
      ),
      child: Text(
        getTranslated(context, 'MOBILE_NUMBER_VARIFICATION')!,
        style: Theme.of(context).textTheme.headline6!.copyWith(
          color: Theme.of(context).colorScheme.fontColor,
          fontWeight: FontWeight.bold,
          fontSize: textFontSize23,
          letterSpacing: 0.8,
          fontFamily: 'ubuntu',
        ),
      ),
    );
  }

  otpText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 13.0,
      ),
      child: Text(
        getTranslated(context, 'SENT_VERIFY_CODE_TO_NO_LBL')!,
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
          color: Theme.of(context).colorScheme.fontColor.withOpacity(0.5),
          fontWeight: FontWeight.bold,
          fontFamily: 'ubuntu',
        ),
      ),
    );
  }

  mobText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 5.0),
      child: Text(
        '+91${widget.mobileNumber}',
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
          color: Theme.of(context).colorScheme.fontColor.withOpacity(0.5),
          fontWeight: FontWeight.bold,
          fontFamily: 'ubuntu',
        ),
      ),
    );
  }

  otpTextVisible() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 5.0),
      child: Text(
        'Otp:- ${widget.responseOtp}',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Theme.of(context).colorScheme.fontColor.withOpacity(0.5),
          fontWeight: FontWeight.bold,
          fontFamily: 'ubuntu',
        ),
      ),
    );
  }

  Widget otpLayout() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 30),
      child: PinFieldAutoFill(
        decoration: BoxLooseDecoration(
            textStyle: TextStyle(
                fontSize: textFontSize20,
                color: Theme.of(context).colorScheme.fontColor),
            radius: const Radius.circular(circularBorderRadius4),
            gapSpace: 15,
            bgColorBuilder: FixedColorBuilder(
                Theme.of(context).colorScheme.lightWhite.withOpacity(0.4)),
            strokeColorBuilder: FixedColorBuilder(
                Theme.of(context).colorScheme.fontColor.withOpacity(0.2))),
        currentCode: otp,
        codeLength: 6,
        onCodeChanged: (String? code) {
          otp = code;
        },
        onCodeSubmitted: (String code) {
          otp = code;
        },
      ),
    );
  }

  Widget resendText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 30.0),
      child: Row(
        children: [
          Text(
            getTranslated(context, 'DIDNT_GET_THE_CODE')!,
            style: Theme.of(context).textTheme.caption!.copyWith(
              color:
              Theme.of(context).colorScheme.fontColor.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontFamily: 'ubuntu',
            ),
          ),
          InkWell(
            onTap: () async {
              await buttonController!.reverse();
              print('___________sdeferfergfer__________');
              resendOTP2();
              // resendOTP2();
              //checkNetworkOtp();
            },
            child: Text(
              getTranslated(context, 'RESEND_OTP')!,
              style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontFamily: 'ubuntu',
              ),
            ),
          )
        ],
      ),
    );
  }

  Future <void> resendOTP() async{
    Future.delayed(Duration.zero).then(
          (value) => context.read<AuthenticationProvider>().senOtp("").then(
            (
            value,
            ) async {
          bool? error = value['error'];
          String? msg = value['message'];
          int? receivedOTP = value['otp'] ;
          await buttonController!.reverse();

          if (!error!) {
            widget.responseOtp =  receivedOTP.toString() ;
            setState(() {});
            setSnackbar(msg!, context);
          } else {
            setSnackbar(msg!, context);
          }

        },
      ),
    );
  }
  Future<void> resendOTP2() async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      Future.delayed(Duration.zero).then(
            (value) => context.read<AuthenticationProvider>().getVerifyUser().then(
              (value) async {
            bool? error = value['error'];
            String? msg = value['message'];
            int? receivedOTP = value['data'] ;
            widget.responseOtp = receivedOTP.toString() ;
            print('_____sueeee_____${widget.responseOtp}_____${receivedOTP.toString()}____');
            print('_____sueeee_____${receivedOTP.toString()}');
            await buttonController!.reverse();
            SettingProvider settingsProvider = Provider.of<SettingProvider>(context, listen: false);
            if (widget.title == getTranslated(context, 'SEND_OTP_TITLE')) {
              if (!error!) {
                setSnackbar(msg!, context);
              } else {
                setSnackbar(msg!, context);
              }
            }
            if (widget.title == getTranslated(context, 'FORGOT_PASS_TITLE')) {
              if (error!) {
              } else {
                setSnackbar(msg!, context);
              }
            }
          },
        ),
      );
    } else {
      Future.delayed(const Duration(seconds: 2)).then(
            (_) async {
          if (mounted) {
            setState(
                  () {
                isNetworkAvail = false;
              },
            );
          }
          await buttonController!.reverse();
        },
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: 23,
              left: 23,
              right: 23,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getLogo(),
              monoVarifyText(),
              otpText(),
              mobText(),
             //otpTextVisible(),
              otpLayout(),
              resendText(),
              verifyBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getLogo() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 60),
        child: Image.asset('assets/images/png/splashlogo-removebg-preview.png',height:110,width:110,)
    );
  }
}
