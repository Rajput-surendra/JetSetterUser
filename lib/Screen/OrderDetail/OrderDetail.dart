import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:eshop_multivendor/Model/Order_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../Helper/Color.dart';
import '../../Helper/Constant.dart';
import '../../Helper/String.dart';
import '../../Provider/Order/UpdateOrderProvider.dart';
import '../../widgets/appBar.dart';
import '../../widgets/desing.dart';
import '../Language/languageSettings.dart';
import '../../widgets/networkAvailablity.dart';
import '../NoInterNetWidget/NoInterNet.dart';
import 'Widget/OrderSubDetails.dart';
import 'Widget/SingleProduct.dart';
import 'Widget/SubHeadingTabBar.dart';
import 'package:http/http.dart' as http;

class OrderDetail extends StatefulWidget {
  final OrderModel model;

  const OrderDetail({Key? key, required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StateOrder();
  }
}

class StateOrder extends State<OrderDetail>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Future<List<Directory>?>? _externalStorageDirectories;
  String?  dMobile, dImages;
  dynamic dName;
  getDeliveryBoys() async {
    var headers = {
      'Cookie': 'ci_session=8cdca4217e6c7e539f59add9362b3b9af535e699'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}get_driver_details'));
    request.fields.addAll(
        {'driver_id':widget.model.itemList!.first.deliveryBoyId == null ? "189" :widget.model.itemList!.first.deliveryBoyId.toString()
        });
    print('____Som___driver_id___${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      print(result.toString());
      dName = finalResult['data']['username'].toString();
      dMobile = finalResult['data']['mobile'].toString();
      dImages = finalResult['data']['driver_profile'];
      setState(() {});
      print('____dName______${dName}_____${dMobile}__${dImages}__');
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();

    getDeliveryBoys();
    context.read<UpdateOrdProvider>().externalStorageDirectories =
        getExternalStorageDirectories(type: StorageDirectory.downloads);

    context.read<UpdateOrdProvider>().files.clear();
    context.read<UpdateOrdProvider>().reviewPhotos.clear();
    //FlutterDownloader.registerCallback(downloadCallback);
    context.read<UpdateOrdProvider>().buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    context.read<UpdateOrdProvider>().buttonSqueezeanimation = Tween(
      begin: deviceWidth! * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: context.read<UpdateOrdProvider>().buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
    context.read<UpdateOrdProvider>().tabController = TabController(
      length: 6,
      vsync: this,
    );
    context.read<UpdateOrdProvider>().tabController.addListener(
      () {
        setState(() {});
      },
    );

    _externalStorageDirectories =
        getExternalStorageDirectories(type: StorageDirectory.documents);
    context.read<UpdateOrdProvider>().changeStatus(UpdateOrdStatus.isSuccsess);
  }

  void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  setStateNow() {
    setState(() {});
  }

  @override
  void dispose() {
    context.read<UpdateOrdProvider>().buttonController!.dispose();
    context.read<UpdateOrdProvider>().commentTextController.dispose();
    context.read<UpdateOrdProvider>().tabController.dispose();
    context.read<UpdateOrdProvider>().controller.dispose();
    context.read<UpdateOrdProvider>().buttonController!.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await context.read<UpdateOrdProvider>().buttonController!.forward();
    } on TickerCanceled {}
  }

  setStateNoInternate() async {
    _playAnimation();

    Future.delayed(const Duration(seconds: 2)).then(
      (_) async {
        isNetworkAvail = await isNetworkAvailable();
        if (isNetworkAvail) {
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (BuildContext context) => super.widget));
        } else {
          await context.read<UpdateOrdProvider>().buttonController!.reverse();
          if (mounted) setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    var model = widget.model;
    String? pDate, prDate, sDate, dDate, cDate, rDate;

    if (model.listStatus.contains(PLACED)) {
      pDate = model.listDate![model.listStatus.indexOf(PLACED)];

      if (pDate != null) {
        List d = pDate.split(' ');
        pDate = d[0] + '\n' + d[1];
      }
    }
    if (model.listStatus.contains(PROCESSED)) {
      prDate = model.listDate![model.listStatus.indexOf(PROCESSED)];
      if (prDate != null) {
        List d = prDate.split(' ');
        prDate = d[0] + '\n' + d[1];
      }
    }
    if (model.listStatus.contains(SHIPED)) {
      sDate = model.listDate![model.listStatus.indexOf(SHIPED)];
      if (sDate != null) {
        List d = sDate.split(' ');
        sDate = d[0] + '\n' + d[1];
      }
    }
    if (model.listStatus.contains(DELIVERD)) {
      dDate = model.listDate![model.listStatus.indexOf(DELIVERD)];
      if (dDate != null) {
        List d = dDate.split(' ');
        dDate = d[0] + '\n' + d[1];
      }
    }
    if (model.listStatus.contains(CANCLED)) {
      cDate = model.listDate![model.listStatus.indexOf(CANCLED)];
      if (cDate != null) {
        List d = cDate.split(' ');
        cDate = d[0] + '\n' + d[1];
      }
    }
    if (model.listStatus.contains(RETURNED)) {
      rDate = model.listDate![model.listStatus.indexOf(RETURNED)];
      if (rDate != null) {
        List d = rDate.split(' ');
        rDate = d[0] + '\n' + d[1];
      }
    }

    return WillPopScope(
      onWillPop: () async {
        if (context.read<UpdateOrdProvider>().tabController.index != 0) {
          context.read<UpdateOrdProvider>().tabController.animateTo(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar:
            getSimpleAppBar(getTranslated(context, 'ORDER_DETAIL')!, context),
        body: isNetworkAvail
            ? Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GetSubHeadingsTabBar(),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller:
                              context.read<UpdateOrdProvider>().tabController,
                          children: [
                            GetOrderDetails(
                              name: dName,
                              mobile: dMobile,
                              images: dImages,
                              model: model,
                              controller:
                                  context.read<UpdateOrdProvider>().controller,
                              externalStorageDirectories:
                                  _externalStorageDirectories,
                              updateNow: setStateNow,
                            ),
                            SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GetSingleProduct(
                                  model: model,
                                  activeStatus: PROCESSED,
                                  id: widget.model.id!,
                                  updateNow: setStateNow,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GetSingleProduct(
                                  model: model,
                                  activeStatus: SHIPED,
                                  id: widget.model.id!,
                                  updateNow: setStateNow,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GetSingleProduct(
                                  model: model,
                                  activeStatus: DELIVERD,
                                  id: widget.model.id!,
                                  updateNow: setStateNow,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GetSingleProduct(
                                  model: model,
                                  activeStatus: CANCLED,
                                  id: widget.model.id!,
                                  updateNow: setStateNow,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GetSingleProduct(
                                  model: model,
                                  activeStatus: RETURNED,
                                  id: widget.model.id!,
                                  updateNow: setStateNow,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  DesignConfiguration.showCircularProgress(
                      context.read<UpdateOrdProvider>().getCurrentStatus ==
                          UpdateOrdStatus.inProgress,
                      colors.primary),
                ],
              )
            : NoInterNet(
                buttonController:
                    context.read<UpdateOrdProvider>().buttonController,
                buttonSqueezeanimation:
                    context.read<UpdateOrdProvider>().buttonSqueezeanimation,
                setStateNoInternate: setStateNoInternate,
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
