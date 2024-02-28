import 'dart:async';
import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Provider/SettingProvider.dart';
import 'package:eshop_multivendor/Provider/homePageProvider.dart';
import 'package:eshop_multivendor/Screen/Dashboard/Dashboard.dart';
import 'package:eshop_multivendor/Screen/IntroSlider/Intro_Slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Helper/String.dart';
import '../../widgets/desing.dart';
import '../../widgets/systemChromeSettings.dart';
import '../Auth/Login.dart';

//splash screen of app
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<Splash> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool from = false;
  late AnimationController navigationContainerAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  @override
  void initState() {
    SystemChromeSettings.setSystemButtomNavigationBarithTopAndButtom();
    SystemChromeSettings.setSystemUIOverlayStyleWithNoSpecification();
    initializeAnimationController();
    startTime();
    super.initState();
  }

  void initializeAnimationController() {
    Future.delayed(
      Duration.zero,
      () {
        context.read<HomePageProvider>()
          ..setAnimationController(navigationContainerAnimationController)
          ..setBottomBarOffsetToAnimateController(
              navigationContainerAnimationController)
          ..setAppBarOffsetToAnimateController(
              navigationContainerAnimationController);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colors.whiteTemp,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: colors.whiteTemp,
            child: Image.asset(
              'assets/images/png/splash.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              DesignConfiguration.setPngPath('doodle'),
              fit: BoxFit.fill,
              color: colors.grad1Color,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  Future<void> navigationPage() async {
    SettingProvider settingsProvider =
        Provider.of<SettingProvider>(context, listen: false);
    CUR_USERID = context.read<SettingProvider>().userId;
    bool isFirstTime = await settingsProvider.getPrefrenceBool(ISFIRSTTIME);
    if (CUR_USERID != null) {
      // setState(
      //   () {
      //     from = true;
      //   },
      // );
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => const Dashboard(),
        ),
      );
    } else {
      // setState(
      //   () {
      //     from = false;
      //   },
      // );
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }
  }

  @override
  void dispose() {
    if (from) {
      SystemChromeSettings.setSystemButtomNavigationBarithTopAndButtom();
    }
    super.dispose();
  }
}
