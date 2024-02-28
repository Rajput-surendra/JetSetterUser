import 'dart:async';
import 'package:eshop_multivendor/Provider/systemProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Helper/Color.dart';
import '../../Helper/String.dart';
import '../../widgets/appBar.dart';
import '../Language/languageSettings.dart';
import '../../widgets/networkAvailablity.dart';

class RefoundPolicy extends StatefulWidget {
  final String? title;

  const RefoundPolicy({Key? key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StatePrivacy();
  }
}

class StatePrivacy extends State<RefoundPolicy> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;

  @override
  void initState() {
    getSystemPolicy();

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
    super.initState();
  }

  @override
  void dispose() {
    buttonController!.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:colors.primary1,
      key: _scaffoldKey,
      appBar: getSimpleAppBar(widget.title!, context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Refund Policy and Cancellation",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),)),
            SizedBox(height: 10,),
            Text("Refund Policy: We understand that circumstances can change, and sometimes you may need to cancel your order or request a refund. Our refund policy is designed to be fair and accommodating"),
            SizedBox(height: 10,),
            Text("Refund Policy:",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("Welcome to our Refund and Cancellation page, where we aim to provide you with clear and transparent information regarding our policies. Your satisfaction is our top priority, and we want to ensure that your experience with us is as smooth and hassle-free as possible.Refund Policy "),
            SizedBox(height: 10,),
            Text("Cancellation:",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("You have the option to cancel your order within 24 hours of placing it, and we will provide a full refund with no questions asked. If you wish to cancel your order after 24 hours but before it has been shipped, a cancellation fee may apply. Once the order has been shipped, we cannot cancel it, but you can still initiate a return. Returns and ExchangesIf you are not completely satisfied with your purchase, you can return the item within 30 days of receiving it. Returned items must be in their original condition and packaging, and you may be responsible for return shipping costs. We offer exchanges for damaged or defective items, and we will cover the return shipping costs in such cases. Please contact our customer support team to initiate a cancellation, return, or exchange.Your satisfaction is our priority, and we are here to assist you with any questions or concerns you may have. Feel free to reach out to our customer support team for further assistance. Thank you for choosing us as your trusted provider, and we look forward to serving you with the best products and services in the future")
          ],
        ),
      )


      //   if (value.getCurrentStatus == SystemProviderPolicyStatus.isSuccsess) {
      //     if (value.policy.isNotEmpty) {
      //       return SingleChildScrollView(
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: HtmlWidget(
      //             value.policy,
      //             onErrorBuilder: (context, element, error) =>
      //                 Text('$element error: $error'),
      //             onLoadingBuilder: (context, element, loadingProgress) =>
      //                 const Center(child: CircularProgressIndicator()),
      //             onTapUrl: (url) {
      //               launchUrl(Uri.parse(url));
      //               return true;
      //             },
      //           ),
      //         ),
      //       );
      //     } else {
      //       Center(
      //         child: Text(
      //           getTranslated(context, 'No Data Found')!,
      //         ),
      //       );
      //     }
      //   } else if (value.getCurrentStatus ==
      //       SystemProviderPolicyStatus.isFailure) {
      //     return Center(
      //       child: Text('Something went wrong:- ${value.errorMessage}'),
      //     );
      //   }
      //   return const Center(
      //     child: CircularProgressIndicator(),
      //   );
      // }
      //),
    );
  }

  Future<void> getSystemPolicy() async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      String type = '';
      if (widget.title == getTranslated(context, 'PRIVACY')) {
        type = PRIVACY_POLLICY;
      } else if (widget.title == getTranslated(context, 'TERM')) {
        type = TERM_COND;
      } else if (widget.title == getTranslated(context, 'ABOUT_LBL')) {
        type = ABOUT_US;
      } else if (widget.title == getTranslated(context, 'CONTACT_LBL')) {
        type = CONTACT_US;
      } else if (widget.title ==
          getTranslated(context, 'SHIPPING_POLICY_LBL')) {
        type = shippingPolicy;
      } else if (widget.title == getTranslated(context, 'RETURN_POLICY_LBL')) {
        type = returnPolicy;
      }

      await Future.delayed(Duration.zero);
      await context.read<SystemProvider>().getSystemPolicies(type);
    }
  }
}
