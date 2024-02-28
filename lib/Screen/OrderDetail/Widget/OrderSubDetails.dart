import 'dart:convert';
import 'dart:io';
import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../Helper/Constant.dart';
import '../../../Model/Order_Model.dart';
import '../../../Provider/Order/UpdateOrderProvider.dart';
import '../../../UserMap.dart';
import '../../../widgets/desing.dart';
import '../../Language/languageSettings.dart';
import '../../../widgets/snackbar.dart';
import '../../Tarking/map_tracking.dart';
import '../../Tarking/seller_track.dart';
import 'OrderTrackDataSheet.dart';
import 'SingleProduct.dart';
import 'package:http/http.dart'as http;

class GetOrderDetails extends StatelessWidget {
  OrderModel model;
  String? name,mobile,images;
  ScrollController controller;
  Future<List<Directory>?>? externalStorageDirectories;
  Function updateNow;
  GetOrderDetails({
    Key? key,
    this.externalStorageDirectories,
    required this.controller,
    this.name,
    this.mobile,
    this.images,
    required this.updateNow,
    required this.model,
  }) : super(key: key);

  priceDetails(BuildContext context, OrderModel model) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
              child: Text(
                getTranslated(context, 'PRICE_DETAIL')!,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).colorScheme.fontColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.lightBlack,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${getTranslated(context, 'PRICE_LBL')!} :",
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack2,
                        ),
                  ),
                  Text(
                    ' ${DesignConfiguration.getPriceFormat(context, double.parse(model.subTotal!))!}',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack2,
                        ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Delivery Tip",
                      style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack2)),
                  Text(
                    ' ${DesignConfiguration.getPriceFormat(context, double.parse(model.deliveryTip!))!}',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack2,
                        ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Donate Food",
                      style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack2)),
                  Text(
                    ' ${DesignConfiguration.getPriceFormat(context, double.parse(model.doneted!))!}',
                    style: Theme.of(context).textTheme.button!.copyWith(
                      color: Theme.of(context).colorScheme.lightBlack2,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${getTranslated(context, 'DELIVERY_CHARGE')!} :',
                      style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack2)),
                  Text(
                      '+${DesignConfiguration.getPriceFormat(context, double.parse(model.delCharge!))!}',
                      style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack2))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${getTranslated(context, 'PROMO_CODE_DIS_LBL')!} :',
                      style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack2)),
                  Text(
                      '-${DesignConfiguration.getPriceFormat(context, double.parse(model.promoDis!))!}',
                      style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack2))
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         '${getTranslated(context, 'WALLET_BAL')!} :',
            //         style: Theme.of(context).textTheme.button!.copyWith(
            //               color: Theme.of(context).colorScheme.lightBlack2,
            //             ),
            //       ),
            //       Text(
            //         '-${DesignConfiguration.getPriceFormat(context, double.parse(model.walBal!))!}',
            //         style: Theme.of(context).textTheme.button!.copyWith(
            //               color: Theme.of(context).colorScheme.lightBlack2,
            //             ),
            //       )
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 15.0, end: 15.0, top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${getTranslated(context, 'PAYABLE')!} :',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack,
                        ),
                  ),
                  Text(
                    DesignConfiguration.getPriceFormat(
                        context, double.parse(model.payable!))!,
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 15.0,
                end: 15.0,
                top: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${getTranslated(context, 'TOTAL_PRICE')!} :',
                      style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack,
                          fontWeight: FontWeight.bold)),
                  Text(
                    DesignConfiguration.getPriceFormat(
                      context,
                      double.parse(model.total!),
                    )!,
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _imgFromGallery(BuildContext context) async {
    var result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      context.read<UpdateOrdProvider>().files =
          result.paths.map((path) => File(path!)).toList();
      updateNow();
    } else {
      // User canceled the picker
    }
  }

  bankProof(OrderModel model) {
    String status = model.attachList![0].bankTranStatus!;
    Color clr;
    if (status == '0') {
      status = 'Pending';
      clr = Colors.cyan;
    } else if (status == '1') {
      status = 'Rejected';
      clr = Colors.red;
    } else {
      status = 'Accepted';
      clr = Colors.green;
    }

    return Card(
      elevation: 0,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: model.attachList!.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Text(
                        '${getTranslated(context, 'Attachment')} ${i + 1}',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.fontColor,
                        ),
                      ),
                      onTap: () {
                        _launchURL(
                          model.attachList![i].attachment!,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: clr,
              borderRadius: BorderRadius.circular(circularBorderRadius5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(status),
            ),
          )
        ],
      ),
    );
  }

  void _launchURL(String url) async => await canLaunchUrlString(url)
      ? await launchUrlString(url)
      : throw 'Could not launch $url';

  shippingDetails(BuildContext context, OrderModel model) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
              child: Text(
                getTranslated(context, 'SHIPPING_DETAIL')!,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).colorScheme.fontColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.lightBlack,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
              child: Text(
                model.userAddressName ?? '' ',',
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
              child: Text(
                model.address!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.lightBlack2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
              child: Text(
                model.mobile!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.lightBlack2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// get(){
//     return Column(
//       children: [
//
//       ],
//     );
// }
//   dwnInvoice(
//     Future<List<Directory>?>? _externalStorageDirectories,
//     OrderModel model,
//     Function update,
//   ) {
//     print('____ssssss_______${model.id}_________');
//     return FutureBuilder<List<Directory>?>(
//       future: _externalStorageDirectories,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         return Card(
//           elevation: 0,
//           child: InkWell(
//             child: ListTile(
//               dense: true,
//               trailing: const Icon(
//                 Icons.keyboard_arrow_right,
//                 color: colors.primary,
//               ),
//               leading: const Icon(
//                 Icons.receipt,
//                 color: colors.primary,
//               ),
//               title: Text(
//                 getTranslated(context, 'DWNLD_INVOICE')!,
//                 style: Theme.of(context)
//                     .textTheme
//                     .subtitle2!
//                     .copyWith(color: Theme.of(context).colorScheme.lightBlack),
//               ),
//             ),
//             onTap: () async {
//               Directory? directory ;
//               final status = await Permission.storage.request();
//               if (status == PermissionStatus.granted) {
//                 context
//                     .read<UpdateOrdProvider>()
//                     .changeStatus(UpdateOrdStatus.inProgress);
//                 updateNow();
//               }
//               var targetPath;
//
//               if (Platform.isIOS) {
//                 var target = await getApplicationDocumentsDirectory();
//                 targetPath = target.path.toString();
//               } else {
//                 directory = Directory('/storage/emulated/0/Download');
//                 if (!await directory.exists()) directory = await getExternalStorageDirectory();
//                 /*if (snapshot.hasData) {
//
//                   targetPath = (snapshot.data as List<Directory>).first.path;
//                   print('___________${targetPath}__________');
//
//                 }*/
//               }
//               var targetFileName = 'Invoice_${model.id!}';
//               var generatedPdfFile, filePath;
//               try {
//                 generatedPdfFile =
//                     await FlutterHtmlToPdf.convertFromHtmlContent(
//                         model.invoice ?? '<br>NO DATA</br>', directory?.path ?? '', targetFileName);
//                 filePath = generatedPdfFile.path;
//
//
//               } catch (e) {
//
//                 context
//                     .read<UpdateOrdProvider>()
//                     .changeStatus(UpdateOrdStatus.inProgress);
//                 updateNow();
//                 setSnackbar(getTranslated(context, "somethingMSg")!, context);
//                 return;
//               }
//               context
//                   .read<UpdateOrdProvider>()
//                   .changeStatus(UpdateOrdStatus.isSuccsess);
//               updateNow();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     "${getTranslated(context, 'INVOICE_PATH')} $targetFileName",
//                     textAlign: TextAlign.center,
//                     style:
//                         TextStyle(color: Theme.of(context).colorScheme.black),
//                   ),
//                   action: SnackBarAction(
//                     label: getTranslated(context, 'VIEW')!,
//                     textColor: Theme.of(context).colorScheme.fontColor,
//                     onPressed: () async {
//                       await OpenFilex.open(filePath);
//                     },
//                   ),
//                   backgroundColor: Theme.of(context).colorScheme.white,
//                   elevation: 1.0,
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
  dwnInvoice(
      Future<List<Directory>?>? _externalStorageDirectories,
      OrderModel model,
      Function update,
      ) {
    //print('_____surendra______${model.invoice}______${model.id}____');
    // print('____ssssss_______${model.id}_________');
    return FutureBuilder<List<Directory>?>(
      future: _externalStorageDirectories,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Card(
          elevation: 0,
          child: InkWell(
            child: ListTile(
              dense: true,
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: colors.primary,
              ),
              leading: const Icon(
                Icons.receipt,
                color: colors.primary,
              ),
              title: Text(
                getTranslated(context, 'DWNLD_INVOICE')!,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Theme.of(context).colorScheme.lightBlack),
              ),
            ),
            onTap: () async {
              Directory? directory ;
              final status = await Permission.storage.request();
              if (status == PermissionStatus.granted) {
                context
                    .read<UpdateOrdProvider>()
                    .changeStatus(UpdateOrdStatus.inProgress);
                updateNow();
              }
              var targetPath;

              if (Platform.isIOS) {
                var target = await getApplicationDocumentsDirectory();
                targetPath = target.path.toString();
              } else {
                directory = Directory('/storage/emulated/0/Download');
                if (!await directory.exists()) directory = await getExternalStorageDirectory();
                /*if (snapshot.hasData) {

                  targetPath = (snapshot.data as List<Directory>).first.path;
                  print('___________${targetPath}__________');

                }*/
              }
              var targetFileName = 'Invoice_${model.id!}';
              var generatedPdfFile, filePath;
              try {
                generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
                    model.invoice ?? '<br>NO DATA</br>', directory?.path ?? '', targetFileName);
                filePath = generatedPdfFile.path;
              } catch (e) {
                context
                    .read<UpdateOrdProvider>()
                    .changeStatus(UpdateOrdStatus.inProgress);
                updateNow();
                setSnackbar(getTranslated(context, "somethingMSg")!, context);
                return;
              }
              context
                  .read<UpdateOrdProvider>()
                  .changeStatus(UpdateOrdStatus.isSuccsess);
              updateNow();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "${getTranslated(context, 'INVOICE_PATH')} $targetFileName",
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(color: Theme.of(context).colorScheme.black),
                  ),
                  action: SnackBarAction(
                    label: getTranslated(context, 'VIEW')!,
                    textColor: Theme.of(context).colorScheme.fontColor,
                    onPressed: () async {
                      await OpenFilex.open(filePath);
                    },
                  ),
                  backgroundColor: Theme.of(context).colorScheme.white,
                  elevation: 1.0,
                ),
              );
            },
          ),
        );
      },
    );
  }

//   String? dName,dMobile,dImages;
//   getDeliveryBoys() async {
//   var headers = {
//     'Cookie': 'ci_session=8cdca4217e6c7e539f59add9362b3b9af535e699'
//   };
//   var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_driver_details'));
//   request.fields.addAll({
//     'driver_id': '79'
//   });
//
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//      var result = await response.stream.bytesToString();
//      var finalResult = jsonDecode(result);
//      dName = finalResult['data']['username'];
//      dMobile = finalResult['data']['mobile'];
//      dImages = finalResult['data']['driver_profile'];
//   }
//   else {
//   print(response.reasonPhrase);
//   }
//
// }
   Widget trackYourOrder (BuildContext context) {
    return Card(child: InkWell(
      onTap: (){
showBottomSheet(context: context, builder: (context) => OrderTrackDataBottomSheet(awb: '1057847214' ),);
    },child: ListTile(
      dense: true,
      trailing: const Icon(
        Icons.keyboard_arrow_right,
        color: colors.primary,
      ),
      leading: const Icon(
        Icons.traffic_outlined,
        color: colors.primary,
      ),
      title: Text(
        getTranslated(context, 'TRACK_ORDER')!,
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Theme.of(context).colorScheme.lightBlack),
      ),
    ),),);
}

  bankTransfer(OrderModel model, BuildContext context, String id) {
    return model.payMethod == 'Bank Transfer'
        ? Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getTranslated(context, 'BANKRECEIPT')!,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).colorScheme.lightBlack),
                      ),
                      SizedBox(
                        height: 30,
                        child: IconButton(
                          icon: const Icon(
                            Icons.add_photo_alternate,
                            color: colors.primary,
                            size: 20.0,
                          ),
                          onPressed: () {
                            _imgFromGallery(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  model.attachList!.isNotEmpty ? bankProof(model) : Container(),
                  Consumer<UpdateOrdProvider>(builder: (context, value, child) {
                    return Container(
                      padding: const EdgeInsetsDirectional.only(
                          start: 20.0, end: 20.0, top: 5),
                      height: value.files.isNotEmpty ? 180 : 0,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.files.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  child: Stack(
                                    alignment: AlignmentDirectional.topEnd,
                                    children: [
                                      Image.file(
                                        value.files[i],
                                        width: 180,
                                        height: 180,
                                      ),
                                      Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .black26,
                                        child: const Icon(
                                          Icons.clear,
                                          size: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    value.files.removeAt(i);
                                    updateNow();
                                  },
                                );
                              },
                            ),
                          ),
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.lightWhite,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    circularBorderRadius4,
                                  ),
                                ),
                              ),
                              child: Text(
                                getTranslated(context, 'SUBMIT_LBL')!,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .fontColor),
                              ),
                            ),
                            onTap: () {
                              Future.delayed(Duration.zero).then(
                                (value) => context
                                    .read<UpdateOrdProvider>()
                                    .sendBankProof(id, context),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          )
        : Container();
  }

  showNote(OrderModel model, BuildContext context) {
    return model.note! != ''
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${getTranslated(context, 'NOTE')}:",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).colorScheme.lightBlack2)),
                    Text(model.note!,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).colorScheme.lightBlack2)),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
  }

  Widget getOrderNoAndOTPDetails(OrderModel model, BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${getTranslated(context, "ORDER_ID_LBL")!} - ${model.id}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.lightBlack2),
                ),
                Text(
                  '${model.dateTime}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.lightBlack2),
                )
              ],
            ),
            model.otp != null && model.otp!.isNotEmpty && model.otp != '0'
                ? Text(
                    "${getTranslated(context, "OTP")!} - ${model.otp}",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.lightBlack2),
                  )
                : Container(),
            // Text(
            //   'Email - ${model.email}',
            //   style:
            //       TextStyle(color: Theme.of(context).colorScheme.lightBlack2),
            // ),
          ],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    print('_____222_____${model.activeStatus}_________');
    return SingleChildScrollView(
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            getOrderNoAndOTPDetails(model, context),
            model.delDate != null && model.delDate!.isNotEmpty
                ? Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "${getTranslated(context, 'PREFER_DATE_TIME')!}: ${model.delDate!} - ${model.delTime!}",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).colorScheme.lightBlack2),
                      ),
                    ),
                  )
                : Container(),

            showNote(model, context),
            bankTransfer(model, context, model.id!),
            GetSingleProduct(
              model: model,
              activeStatus: '',
              id: model.id!,
              updateNow: updateNow,
            ),


            /*name == null ? SizedBox.shrink():*/ model.itemList![0].status == "shipped" ?  InkWell(
              onTap: (){
                // String url =
                //     "https://www.google.com/maps/dir/?api=1&origin=${"22.719568"},${"75.857727"}&destination=${"23.259933"},${"77.412613"}&travel_mode=driving&dir_action=navigate";
                // print(url);
                // print('____Som______${model.activeStatus}_________');
                // print('___model.deliveryBoyId.toString()_______${model.addressId}_________');
                //
              Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryAddMap(driverId: model.itemList?[0].deliveryBoyId,addressId: model.addressId,DeliveryAdd:model.address ),));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colors.whiteTemp,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child:  ListTile(
                    leading:  Icon(Icons.location_on_outlined,color: colors.primary,),
                    title:  Text(
                      getTranslated(context, 'TRACK_ORDER')!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Theme.of(context).colorScheme.lightBlack),
                    ),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      color: colors.primary,
                    ),
                  ),
              ),
            ):SizedBox.shrink(),

            name == null ?Text("No Delivery Boy Details")  :Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
                color: colors.whiteTemp
            ),
            height: 115,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 2),
                  child: Text("Delivery Boy Details"),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                          height: 80,
                          width: 80,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network("${images}",fit: BoxFit.fill,))),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${name.toString()}"),
                        Text("${mobile.toString()}"),
                      ],
                    )

                  ],
                ),
              ],
            )
          ),
            dwnInvoice(
              externalStorageDirectories,
              model,
              updateNow,
            ),

           // trackYourOrder(context,),
            model.itemList![0].productType != 'digital_product'
                ? shippingDetails(
                    context,
                    model,
                  )
                : Container(),

            priceDetails(
              context,
              model,
            ),
          ],
        ),
      ),
    );
  }
}
