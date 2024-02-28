//
// import 'dart:convert';
// import 'package:flutter/services.dart';
//
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:math';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import '../../Helper/String.dart';
// import '../../Helper/constant.dart';
// import '../Test/Widget/ListTile2.dart';
//
// class UserMapScreen extends StatefulWidget {
//    String ? dId;
//   UserMapScreen({this.dId});
//   @override
//   _UserMapScreenState createState() => _UserMapScreenState();
// }
//
//
// class _UserMapScreenState extends State<UserMapScreen> {
//  // final DocumentReference documentReference = FirebaseFirestore.instance.collection('92').doc('qPoeXMGDCkuWuiDkBnf0');
//
//   LatLng driverLocation = LatLng(22.7177, 75.8545);
//   LatLng userLocation = LatLng(22.7281,  75.8042);
//
//   BitmapDescriptor? myIcon ;
//
//   List<LatLng> routeCoordinates = [];
//
//   List<Polyline> polyLines = [];
//
//   late double bearing;
//   double dNewLat = 0.0 ;
//   double dNewLong = 0.0 ;
//   double userLat = 0.0 ;
//   double userLong = 0.0 ;
//
//  // CollectionReference collectionRef=FirebaseFirestore.instance.collection("driverlocation");
//
//   late Timer _timer;
//   void _startTimer() {
//
//     _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
//      getLatLongApi();
//     });
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     ///userLocation = LatLng(double.parse(widget.venorlat ?? ''),double.parse(widget.venorlang ?? '0.0'));
//
//     getLatLongApi();
//
//     _startTimer();
//     // init();
//
//     BitmapDescriptor.fromAssetImage(
//         const ImageConfiguration(size: Size(5, 5)), 'assets/images/png/plan.png')
//         .then((onValue) {
//       myIcon = onValue;
//     });
//
//
//
//   }
//
//
//   init() async{
//     var encodedPoly = await getRouteCoordinates(
//         LatLng(dNewLat,  dNewLong),
//         // const LatLng(22.7281,  75.8042));
//        LatLng(userLat,userLong));
//
//
//     polyLines.add(Polyline(
//         polylineId: const PolylineId("1"), //pass any string here
//         width: 7,
//         geodesic: true,
//         points: convertToLatLng(decodePoly(encodedPoly)),
//         color: primary));
//
//     setState(() {
//
//     });
//   }
//
//
//   getLatLongApi() async {
//     var headers = {
//       'Cookie': 'ci_session=bec982583a172f8af24d3074f39cddbc10290cd5'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_lat_lang'));
//     request.fields.addAll({
//       'user_id':CUR_USERID.toString(),
//       'driver_id':"24"
//     });
//     print('_____request.fields_____${request.fields}_________');
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var result  =  await response.stream.bytesToString();
//       var finalResult = jsonDecode(result);
//
//
//       userLat =  double.parse(finalResult['user']['longitude']);
//       userLong =  double.parse(finalResult['user']['longitude']);
//       dNewLat =  double.parse(finalResult['driver']['latitude']);
//       dNewLong =  double.parse(finalResult['driver']['longitude']);
//       driverLocation = LatLng(dNewLat, dNewLong);
//       bearing = await getBearing( LatLng(dNewLat, dNewLong),  LatLng(userLat,userLong));
//       userLocation = LatLng(userLat,userLong);
//
//       print('____2______${dNewLat}______${bearing}___');
//       print('_____3_____${userLocation}_________');
//       print('___1_______${driverLocation}_________');
//       setState(() {
//
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//
//   }
//   final Set<Polyline>_polyline={};
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//             onPressed: (){
//               init();
//             },
//             child: const Icon(Icons.directions)),
//         body:
//
//
//         // dNewLat==0.0?Container(
//         //     height: MediaQuery.of(context).size.height,
//         //     width: MediaQuery.of(context).size.width,
//         //
//         //     child: Center(child: CircularProgressIndicator())):
//         GoogleMap(
//           initialCameraPosition: CameraPosition(
//             target: userLocation,
//             zoom: 15.0,
//           ),
//           markers: <Marker>{
//             Marker(
//                 markerId: const MarkerId('userMarker'),
//                 position: driverLocation,
//                 icon: myIcon ?? BitmapDescriptor.defaultMarker,
//                 anchor: const Offset(0.5, 0.5),
//                 flat: true,
//                 rotation: bearing,
//                 draggable: false),
//             Marker(
//               markerId: const MarkerId('driverMarker'),
//               position: userLocation,
//               icon: BitmapDescriptor.defaultMarkerWithHue(
//                   BitmapDescriptor.hueRed),
//             ),
//           },
//           polylines: Set<Polyline>.of(
//               polyLines) /*{
//           Polyline(
//             polylineId: const PolylineId('user-driver-polyline'),
//             color: Colors.blue,
//             points: routeCoordinates,
//           ),
//         }*/
//           ,
//         )
//     );
//   }
//
//
//
//   static List<LatLng> convertToLatLng(List points) {
//     List<LatLng> result = <LatLng>[];
//     for (int i = 0; i < points.length; i++) {
//       if (i % 2 != 0) {
//         result.add(LatLng(points[i - 1], points[i]));
//       }
//     }
//     return result;
//   }
//
//   Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
//     print("JJJJJJJJJJJJJJJJJJJJJJJJJ");
//     final url = 'https://www.google.com/maps/dir/?api=AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM&origin=${userLat},${userLong}&destination=${dNewLat},${dNewLong}';
//
//     print(url);
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//     String url1 =
//     // "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyDi_XlHtopewZHtpWWxIO-EQ7mCegHr5o0";
//    // "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyAXL1tpx0xZORmWdCkqaStqHC4BhklFZ78";
//        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyAmJixElxZzVtD26BWhCaGC1S3HMHsGDLc";
//     http.Response response = await http.get(Uri.parse(url));
//     print(url);
//     Map values = jsonDecode(response.body);
//     print("Predictions " + values.toString());
//    // print("Predictions ${values["routes"][0]["overview_polyline"]["points"]}");
//
//     return values["routes"][0]["overview_polyline"]["points"];
//   }
//
//
//   static List decodePoly(String poly) {
//     var list = poly.codeUnits;
//     var lList = [];
//     int index = 0;
//     int len = poly.length;
//     int c = 0;
//     // repeating until all attributes are decoded
//     do {
//       var shift = 0;
//       int result = 0;
//
//       // for decoding value of one attribute
//       do {
//         c = list[index] - 63;
//         result |= (c & 0x1F) << (shift * 5);
//         index++;
//         shift++;
//       } while (c >= 32);
//       // if value is negative then bitwise not the value /
//       if (result & 1 == 1) {
//         result = ~result;
//       }
//       var result1 = (result >> 1) * 0.00001;
//       lList.add(result1);
//     } while (index < len);
//
//     /*adding to previous value as done in encoding */
//     for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
//
//     print(lList.toString());
//
//     return lList;
//   }
//
//   double getBearing(LatLng begin, LatLng end) {
//
//     double lat = (begin.latitude - end.latitude).abs();
//
//     double lng = (begin.longitude - end.longitude).abs();
//
//     if (begin.latitude < end.latitude && begin.longitude < end.longitude) {
//
//       return (atan(lng / lat) * (180 / pi));
//
//     } else if (begin.latitude >= end.latitude && begin.longitude < end.longitude) {
//
//       return (90 - (atan(lng / lat) * (180 / pi))) + 90;
//
//     } else if (begin.latitude >= end.latitude && begin.longitude >= end.longitude) {
//
//       return (atan(lng / lat) * (180 / pi)) + 180;
//
//     } else if (begin.latitude < end.latitude && begin.longitude >= end.longitude) {
//
//       return (90 - (atan(lng / lat) * (180 / pi))) + 270;
//
//     }
//
//     return -1;
//
//   }
//
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _timer.cancel();
//   }
// }

import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;

import '../../Helper/Constant.dart';
import '../../Helper/String.dart';

class UserMapScreen extends StatefulWidget {
  String? driverId;
  String?userlat;
  String?userlong;
  String?addressId;
  UserMapScreen({
    this.driverId,
    this.userlat,
    this.userlong,
    this.addressId
  });

  @override
  _UserMapScreenState createState() => _UserMapScreenState();
}

class _UserMapScreenState extends State<UserMapScreen> {


  LatLng driverLocation = LatLng(22.7177, 75.8545);
  // LatLng userLocation = LatLng(22.7281,  75.8042);
  LatLng userLocation = LatLng(22.7281,  75.8042);


  BitmapDescriptor? myIcon ;

  List<LatLng> routeCoordinates = [];

  List<Polyline> polyLines = [];

  late double bearing ;
  double dNewLat = 22.7533 ;
  double dNewLong =75.8937 ;

  //
  // Future<void> getdatadriverData() async {
  //   // driverLocation = LatLng(dNewLat, dNewLong);
  //
  //
  //   print('data prasent${widget.driverId}');
  //
  //
  //   try {
  //
  //     DocumentSnapshot document = await collectionRef.doc('${widget.driverId}').get();
  //     if (document.exists) {
  //
  //
  //       dNewLat = document.get('lat') as double; // Replace with your field name
  //       dNewLong = document.get('long') as double; // Replace with your field name
  //       driverLocation = LatLng(dNewLat, dNewLong);
  //       bearing = getBearing( LatLng(dNewLat, dNewLong),  LatLng(double.parse(widget.userlat ?? '0.0'),double.parse(widget.userlong ?? '0.0')));
  //
  //       print('${dNewLat}_______');
  //       print('${dNewLong}_______');
  //
  //
  //
  //
  //
  //       setState(() {
  //
  //       });
  //
  //     }else{
  //       print('data not prasent');
  //     }
  //
  //   } catch (e) {
  //
  //     print('${e}');
  //
  //
  //     // print('Error adding data: $e');
  //   }
  //
  // }
  //
var userLat;
var userLong;
    getLatLongApi() async {
    var headers = {
      'Cookie': 'ci_session=bec982583a172f8af24d3074f39cddbc10290cd5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_lat_lang'));
    request.fields.addAll({
      'address_id':widget.addressId.toString(),
      'driver_id':widget.driverId.toString() ??  '1'
    });
    print('_____request.fields___zzzz__${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  =  await response.stream.bytesToString();
      print('____Som______${result}_________');
      var finalResult = jsonDecode(result);

      // userLat = 22.727269;
      // userLong =  75.883894;
      userLat =  double.parse(finalResult['user']['latitude'].toString());
      userLong =  double.parse(finalResult['user']['longitude'].toString());
      print('____userLong______${userLat}____${userLong}_____');
      dNewLat =  double.parse(finalResult['driver']['latitude'].toString());
      dNewLong =  double.parse(finalResult['driver']['longitude'].toString());
      print('____dNewLong______${dNewLat}____${dNewLong}_____');
      driverLocation = LatLng(dNewLat, dNewLong);
      bearing = await getBearing( LatLng(dNewLat, dNewLong),  LatLng(userLat,userLong));
      userLocation = LatLng(userLat,userLong);
      setState(() {

      });
      init();
      // setState(() {
      //
      // });
    }
    else {
      print(response.reasonPhrase);
    }

  }



  late Timer _timer;

  void _startTimer() {

    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      getLatLongApi();
    });
  }


  @override
  void initState(){
    super.initState();
    print('===================driver id${widget.driverId} ');
    print('===================current lat ${widget.userlat} ');
    print('===================driver id${widget.userlong}');


    getLatLongApi();
    _startTimer();
    // init();
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(1, 1)), 'assets/images/png/scooter.png')
        .then((onValue) {
      myIcon = onValue;
    });


  }

  void init() async {
    var encodedPoly = await getRouteCoordinates(
      LatLng(dNewLat, dNewLong),
      LatLng(userLat ?? 0.0, userLong ?? 0.0),
    );

    polyLines.add(Polyline(
      polylineId: PolylineId("1"),
      width: 7,
      geodesic: true,
      points: convertToLatLng(decodePoly(encodedPoly)),
      color: Colors.blueAccent,
    ));

    setState(() {
      // Update the state to rebuild the widget and show the polyline
    });
  }

  @override
  Widget build(BuildContext context) {
    print('_____dddddd_____${widget.driverId}_________');
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //     onPressed: (){
        //       init();
        //     },
        //     child: const Icon(Icons.directions)),
        body:
        userLat == null?
        Center(child: CircularProgressIndicator()):
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: userLocation,
            zoom: 15.0,
          ),
          markers: <Marker>{
            Marker(
                markerId: const MarkerId('userMarker'),
                position: userLocation,
                icon: myIcon ?? BitmapDescriptor.defaultMarker,
                anchor: const Offset(0.5, 0.5),
                flat: true,
                rotation: bearing,
                draggable: false),
            Marker(
              markerId: const MarkerId('driverMarker'),
              position: driverLocation,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
            ),
          },
          polylines: Set<Polyline>.of(
              polyLines) /*{
          Polyline(
            polylineId: const PolylineId('user-driver-polyline'),
            color: Colors.blue,
            points: routeCoordinates,
          ),
        }*/
          ,
        )
    );
  }

  static List<LatLng> convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1]as double, points[i]as double));
      }
    }
    return result;
  }

  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
  // "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY";
       "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyAmJixElxZzVtD26BWhCaGC1S3HMHsGDLc";
    http.Response response = await http.get(Uri.parse(url));
    print("=================>${url}");
    Map values = jsonDecode(response.body) as Map<dynamic, dynamic> ;
    print("Predictions " + values.toString());
    return values["routes"]["overview_polyline"]["points"].toString();
  }


  static List decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
    // repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      // if value is negative then bitwise not the value /
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }


  double getBearing(LatLng begin, LatLng end) {

    double lat = (begin.latitude - end.latitude).abs();

    double lng = (begin.longitude - end.longitude).abs();



    if (begin.latitude < end.latitude && begin.longitude < end.longitude) {

      return (atan(lng / lat) * (180 / pi));

    } else if (begin.latitude >= end.latitude && begin.longitude < end.longitude) {

      return (90 - (atan(lng / lat) * (180 / pi))) + 90;

    } else if (begin.latitude >= end.latitude && begin.longitude >= end.longitude) {

      return (atan(lng / lat) * (180 / pi)) + 180;

    } else if (begin.latitude < end.latitude && begin.longitude >= end.longitude) {

      return (90 - (atan(lng / lat) * (180 / pi))) + 270;

    }

    return -1;

  }
}