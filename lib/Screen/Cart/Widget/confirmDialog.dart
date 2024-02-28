import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Screen/Cart/Cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Model/Section_Model.dart';
import '../../../Provider/CartProvider.dart';
import '../../../widgets/desing.dart';
import '../../Language/languageSettings.dart';

class GetContent extends StatelessWidget {
  double? allTotalPrice,finalTotalAmount;
    int? selectedNumber;
    double? amt;
   GetContent({Key? key,this.allTotalPrice,this.finalTotalAmount,this.selectedNumber,this.amt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('____Som___amt___${amt}_________');
    List<SectionModel> tempCartListForTestCondtion =
        context.read<CartProvider>().cartList;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
            child: Text(
              getTranslated(context, 'CONFIRM_ORDER')!,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).colorScheme.fontColor,
                    fontFamily: 'ubuntu',
                  ),
            )),
        Divider(color: Theme.of(context).colorScheme.lightBlack),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, 'SUBTOTAL')!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack2,
                          fontFamily: 'ubuntu',
                        ),
                  ),
                  Text(
                    DesignConfiguration.getPriceFormat(
                        context, context.read<CartProvider>().oriPrice)!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: Theme.of(context).colorScheme.fontColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ubuntu',
                        ),
                  )
                  // Text(
                  //   "${allTotalPrice}",
                  //   style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  //     color: Theme.of(context).colorScheme.fontColor,
                  //     fontWeight: FontWeight.bold,
                  //     fontFamily: 'ubuntu',
                  //   ),
                  // )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, 'DELIVERY_CHARGE')!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: Theme.of(context).colorScheme.lightBlack2,
                          fontFamily: 'ubuntu',
                        ),
                  ),
                  dChange.toString() == null ? Text("0.0"): Text(
                    DesignConfiguration.getPriceFormat(
                        context, double.parse(dChange.toString()))!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: Theme.of(context).colorScheme.fontColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ubuntu',
                        ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tip your delivery partner",
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).colorScheme.lightBlack2,
                      fontFamily: 'ubuntu',
                    ),
                  ),
                  selectedNumber  == null ?  Text(
                    "₹ 0.0",
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).colorScheme.fontColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ubuntu',
                    ),
                  ):Text(
                    "₹ ${selectedNumber}",
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).colorScheme.fontColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ubuntu',
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Donate Food",
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).colorScheme.lightBlack2,
                      fontFamily: 'ubuntu',
                    ),
                  ),
                  amt  == null ?  Text(
                    "₹ 0.0",
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).colorScheme.fontColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ubuntu',
                    ),
                  ):Text(
                    "₹ ${amt}",
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).colorScheme.fontColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ubuntu',
                    ),
                  )
                ],
              ),
              context.read<CartProvider>().isPromoValid!
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getTranslated(context, 'PROMO_CODE_DIS_LBL')!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.lightBlack2,
                                fontFamily: 'ubuntu',
                              ),
                        ),
                        Text(
                          DesignConfiguration.getPriceFormat(
                              context, context.read<CartProvider>().promoAmt)!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: Theme.of(context).colorScheme.fontColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ubuntu',
                              ),
                        )
                      ],
                    )
                  : Container(),
              context.read<CartProvider>().isUseWallet!
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getTranslated(context, 'WALLET_BAL')!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                fontFamily: 'ubuntu',
                                color:
                                    Theme.of(context).colorScheme.lightBlack2,
                              ),
                        ),
                        Text(
                          // DesignConfiguration.getPriceFormat(context,
                          //     context.read<CartProvider>().usedBalance)!,
                          "${context.read<CartProvider>().usedBalance}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                fontFamily: 'ubuntu',
                                color: Theme.of(context).colorScheme.fontColor,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      ],
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, 'TOTAL_PRICE')!,
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).colorScheme.lightBlack2,
                            fontFamily: 'ubuntu',
                          ),
                    ),
                    // allTotalPrice ==0.0 ? Text(
                    //   '${context.read<CartProvider>().totalPrice.toStringAsFixed(2)} ',
                    //   style: TextStyle(
                    //     color: Theme.of(context)
                    //         .colorScheme
                    //         .fontColor,
                    //     fontWeight: FontWeight.bold,
                    //     fontFamily: 'ubuntu',
                    //   ),
                    // ):
                    finalTotalAmount != 0.0
                        ? Text(
                      //  '${finalTotalAmount + double.parse(dChange ?? "0.0") - context.read<CartProvider>().promoAmt /*-double.parse( '${context.read<CartProvider>().usedBalance} ')*/} ',
                      finalTotalAmount.toString(),       style:
                    TextStyle(
                      color: Theme.of(
                          context)
                          .colorScheme
                          .fontColor,
                      fontWeight:
                      FontWeight
                          .bold,
                      fontFamily:
                      'ubuntu',
                    ),
                    )
                    //         :   allTotalPrice != 0.0
                    //     ? Text(
                    //   '${allTotalPrice} ',
                    //   style: TextStyle(
                    //     color: Theme.of(
                    //         context)
                    //         .colorScheme
                    //         .fontColor,
                    //     fontWeight:
                    //     FontWeight.bold,
                    //     fontFamily:
                    //     'ubuntu',
                    //   ),
                    // )
                        :  Text(
                      '${context.read<CartProvider>().totalPrice+double.parse(dChange.toString())/*-double.parse("${context.read<CartProvider>().usedBalance}")*/} ',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .fontColor,
                        fontWeight:
                        FontWeight.bold,
                        fontFamily: 'ubuntu',
                      ),
                    ),
                    // Text(
                    //   '${DesignConfiguration.getPriceFormat(context, context.read<CartProvider>().oriPrice)!} ',
                    //   style: TextStyle(
                    //     color: Theme.of(context).colorScheme.fontColor,
                    //     fontWeight: FontWeight.bold,
                    //     fontFamily: 'ubuntu',
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: context.read<CartProvider>().noteController,
                  style: Theme.of(context).textTheme.subtitle2,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: colors.primary.withOpacity(0.1),
                    hintText: getTranslated(context, 'NOTE'),
                  ),
                ),
              ),
              tempCartListForTestCondtion[0].productType != 'digital_product'
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        controller:
                            context.read<CartProvider>().emailController,
                        style: Theme.of(context).textTheme.subtitle2,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: colors.primary.withOpacity(0.1),
                          hintText: 'Enter Email Id',
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
