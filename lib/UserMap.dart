import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import 'Helper/Constant.dart';

class DeliveryAddMap extends StatefulWidget {
  final String? driverId,addressId,DeliveryAdd;

  const DeliveryAddMap({Key? key, required this.driverId,this.addressId,this.DeliveryAdd}) : super(key: key);
  @override
  State<DeliveryAddMap> createState() => _DeliveryAddMapState();
}

class _DeliveryAddMapState extends State<DeliveryAddMap> {
  var custLat, custLon;
  Position? currentLocation;
  double? dNewLat = 0.0;
  double? dNewLong = 0.0;
  double userLat = 0.0;
  double userLong = 0.0;
  double sellerLat = 0.0;
  double sellerLong = 0.0;
  BitmapDescriptor? myIcon;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Completer<GoogleMapController> _controller = Completer();
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
      // userLat =  double.parse(finalResult['user']['latitude'].toString());
      // userLong =  double.parse(finalResult['user']['longitude'].toString());
      //print('____userLong______${userLat}____${userLong}_____');
      dNewLat =  double.parse(finalResult['driver']['latitude'].toString());
      dNewLong =  double.parse(finalResult['driver']['longitude'].toString());
      //print('____dNewLong______${dNewLat}____${dNewLong}_____');
      // driverLocation = LatLng(dNewLat, dNewLong);
      // bearing = await getBearing( LatLng(dNewLat, dNewLong),  LatLng(userLat,userLong));
      // userLocation = LatLng(userLat,userLong);
     setState(() {});

      _getPolyline();
      _addMarker(
          LatLng(userLat, userLong),
          "origin",
          BitmapDescriptor.defaultMarker,true
      );
      // Add destination marker
      // _addMarker(
      //     LatLng(dNewLat, dNewLong),
      //     "destination",
      //     BitmapDescriptor.defaultMarkerWithHue(90),false
      // );

      //init();

    }
    else {
      print(response.reasonPhrase);
    }

  }
  getLatLong() async {
    try {
      List<Location> locations = await locationFromAddress(widget.DeliveryAdd!);
      userLat = locations.first.latitude;
      userLong = locations.first.longitude;
      print("custLat: $custLat, custLon: $custLon");
      //await getUserCurrentLocation();
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  late Timer _timer;
  Future getUserCurrentLocation() async {
    polylines = {};
    markers = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dNewLat = double.parse(prefs.getString('Lat').toString());
    dNewLong = double.parse(prefs.getString('Lon').toString());
    print("dNewLat: $dNewLat, dNewLong: $dNewLong");

    print("TIMERRR CALLED");
    _addMarker(LatLng(custLat, custLon), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90), false);
    _addMarker(LatLng(dNewLat!, dNewLong!), "start",
        BitmapDescriptor.defaultMarkerWithHue(90), false);
    _getPolyline();
    //call update  location api
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM",
      PointLatLng(userLat, userLong),
      PointLatLng(dNewLat!, dNewLong!),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    // setState(() {});
  }

  _addMarker(
      LatLng position, String id, BitmapDescriptor descriptor, bool foruser) {
    MarkerId markerId = MarkerId(id);

    Marker marker = Marker(
        markerId: markerId,
        icon: foruser
            ? BitmapDescriptor.defaultMarker
            : myIcon ?? BitmapDescriptor.defaultMarker,
        position: position);
    markers[markerId] = marker;
  }

  @override
  void initState() {
    getLatLong();
    _startTimer();


    super.initState();
  }

  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(22.7500894, 75.9001985),
    zoom: 15,
  );


  void _startTimer() {
    try {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
        getLatLongApi();

      });
    } catch (e, s) {
      print(s);
    }
  }
  @override
  Widget build(BuildContext context) {
    print('____Som___DeliveryAdd___${widget.DeliveryAdd}_________');
    return SafeArea(
      child: Scaffold(
        body:   GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(22.7500894, 75.9001985),
            zoom: 13,
          ),
          myLocationEnabled: true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,

          polylines: Set<Polyline>.of(polylines.values),
          markers: Set<Marker>.of(markers.values),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            // controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(dNewLat!, dNewLong!), 14));
          },
        ),
      ),
    );
  }
}
