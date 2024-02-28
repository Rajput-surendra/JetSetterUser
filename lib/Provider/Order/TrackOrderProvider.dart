import 'package:eshop_multivendor/Helper/String.dart';
import 'package:eshop_multivendor/repository/Order/OrderRepository.dart';
import 'package:flutter/material.dart';

class TrackOrderProvider extends ChangeNotifier{

var result;
  Future <void> getTrackData (String awb ) async{

    var parameter = {
      USERNAME: 'JOSSBYTECHNOLOGIESINDIAPVTLTD-EGS514326',
      PASSWORD: '5hGBxrCzly',
      AWB: awb,

    };



     result =
    await OrderRepository.fetchOrderStatusTrcak(parameter: parameter);
    /*var request = http.MultipartRequest('GET', Uri.parse('https://clbeta.ecomexpress.in/track_me/api/mawbd/'));
    request.fields.addAll({
      'username': 'JOSSBYTECHNOLOGIESINDIAPVTLTD-EGS514326',
      'password': '5hGBxrCzly',
      'awb': '114970250'
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }*/
}
}