import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Helper/Color.dart';
import '../../../Helper/Constant.dart';
import '../../../Helper/String.dart';
import '../../Language/languageSettings.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  noCartImage(BuildContext context) {
    return Image.asset('assets/images/png/cartEmpty_image.png',height:250,width:250,);
  }

  noCartText(BuildContext context) {
    return Text(
      getTranslated(context, 'NO_CART')!,
      style: Theme.of(context).textTheme.headline5!.copyWith(
            color: colors.blackTemp,
            fontWeight: FontWeight.normal,
            fontFamily: 'ubuntu',
          ),
    );
  }

  noCartDec(BuildContext context) {
    return Container(
      padding:
          const EdgeInsetsDirectional.only(top: 30.0, start: 30.0, end: 30.0),
      child: Text(
        getTranslated(context, 'CART_DESC')!,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Theme.of(context).colorScheme.lightBlack2,
              fontWeight: FontWeight.normal,
              fontFamily: 'ubuntu',
            ),
      ),
    );
  }

  shopNow(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 28.0),
      child: CupertinoButton(
        child: Container(
          width: deviceWidth! * 0.7,
          height: 45,
          alignment: FractionalOffset.center,
          decoration: const BoxDecoration(
            color: colors.primary,
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [colors.grad1Color, colors.grad2Color],
            //   stops: [0, 1],
            // ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                circularBorderRadius50,
              ),
            ),
          ),
          child: Text(
            getTranslated(context, 'SHOP_NOW')!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Theme.of(context).colorScheme.white,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'ubuntu',
                ),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            noCartImage(context),
            // noCartText(context),
            // noCartDec(context),
            shopNow(context)
          ],
        ),
      ),
    );
  }
}
