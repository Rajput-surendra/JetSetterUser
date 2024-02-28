import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../Helper/Constant.dart';
import '../../Helper/String.dart';
import '../../Provider/Order/OrderProvider.dart';
import '../../widgets/appBar.dart';
import '../../widgets/desing.dart';
import '../Cart/Cart.dart';
import '../Language/languageSettings.dart';

class OrderSuccess extends StatefulWidget {
   OrderSuccess({Key? key,this.orderId}) : super(key: key);
  String? orderId;

  @override
  State<StatefulWidget> createState() {
    return StateSuccess();
  }
}

class StateSuccess extends State<OrderSuccess> {
  setStateNow() {
    setState(() {});
  }
  OrderProvider? orderPro;
  @override
  Widget build(BuildContext context) {
    print('____Som___get.orderId___${widget.orderId}_________');
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:colors.primary1,
      appBar: getAppBar(
          getTranslated(context, 'ORDER_PLACED')!, context, setStateNow),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(vertical: 40),
              child: SvgPicture.asset(
                DesignConfiguration.setSvgPath('bags'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getTranslated(context, 'ORD_PLC')!,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Text(
              getTranslated(context, 'ORD_PLC_SUCC')!,
              style: TextStyle(color: Theme.of(context).colorScheme.fontColor),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 28.0),
              child: CupertinoButton(
                child: Container(
                  width: deviceWidth! * 0.7,
                  height: 45,
                  alignment: FractionalOffset.center,
                  decoration: const BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(circularBorderRadius10),
                    ),
                  ),
                  child: Text(
                    getTranslated(context, 'CONTINUE_SHOPPING')!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: colors.whiteTemp,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                onPressed: ()  async {
                  orderPro = Provider.of<OrderProvider>(context, listen: false);
                  orderPro?.getOrder(context, '',true);
                 await Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false,arguments: orderIdNew.toString());
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}
