import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Helper/routes.dart';
import '../../../Provider/CartProvider.dart';
import '../../Language/languageSettings.dart';
import '../../AddAddress/Add_Address.dart';

class SetAddress extends StatefulWidget {
  Function update;
  SetAddress({Key? key, required this.update}) : super(key: key);

  @override
  State<SetAddress> createState() => _SetAddressState();
}

class _SetAddressState extends State<SetAddress> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8.0),
                  child: Text(
                    getTranslated(context, 'SHIPPING_DETAIL') ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.fontColor,
                      fontFamily: 'ubuntu',
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            context.read<CartProvider>().addressList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           Row(
                             children: [
                               Text(
                                 context.read<CartProvider>().addressList[context.read<CartProvider>().selectedAddress!].name!,
                                 style: const TextStyle(
                                   fontFamily: 'ubuntu',
                                 ),
                               ),
                               SizedBox(width: 5,),
                               Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 5.0),
                                 child: Row(
                                   children: [
                                     Text(
                                       context
                                           .read<CartProvider>()
                                           .addressList[context
                                           .read<CartProvider>()
                                           .selectedAddress!]
                                           .mobile!,
                                       style: Theme.of(context)
                                           .textTheme
                                           .caption!
                                           .copyWith(
                                         fontFamily: 'ubuntu',
                                         color: Theme.of(context)
                                             .colorScheme
                                             .lightBlack,
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                            InkWell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  getTranslated(context, 'CHANGE')!,
                                  style: const TextStyle(
                                    color: colors.primary,
                                    fontFamily: 'ubuntu',
                                  ),
                                ),
                              ),
                              onTap: () async {
                                Routes.navigateToManageAddressScreen(
                                    context, false);
                                context.read<CartProvider>().checkoutState!(
                                  () {
                                    context.read<CartProvider>().deliverable =
                                        false;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Text(
                         // '${context.read<CartProvider>().addressList[context.read<CartProvider>().selectedAddress!].address!}, ${context.read<CartProvider>().addressList[context.read<CartProvider>().selectedAddress!].area!}, ${context.read<CartProvider>().addressList[context.read<CartProvider>().selectedAddress!].city!}, ${context.read<CartProvider>().addressList[context.read<CartProvider>().selectedAddress!].state!}, ${context.read<CartProvider>().addressList[context.read<CartProvider>().selectedAddress!].country!}, ${context.read<CartProvider>().addressList[context.read<CartProvider>().selectedAddress!].pincode!}',
                          '${context.read<CartProvider>().addressList[context.read<CartProvider>().selectedAddress!].address!}',
                            //  ', ${context.read<CartProvider>().addressList[context.read<CartProvider>().selectedAddress!].area!}, ${context.read<CartProvider>().addressList[context.read<CartProvider>().selectedAddress!].city!}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Theme.of(context).colorScheme.lightBlack,
                              ),
                        ),

                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8.0),
                    child: InkWell(
                      child: Text(
                        getTranslated(context, 'ADDADDRESS')!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.fontColor,
                          fontFamily: 'ubuntu',
                        ),
                      ),
                      onTap: () async {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => AddAddress(
                              update: false,
                              index: context
                                  .read<CartProvider>()
                                  .addressList
                                  .length,
                            ),
                          ),
                        );
                        if (mounted) widget.update();
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
