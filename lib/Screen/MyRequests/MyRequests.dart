import 'dart:convert';

import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Helper/String.dart';
import 'package:eshop_multivendor/Screen/MyRequests/requestDetailScreen.dart';
import 'package:eshop_multivendor/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../Model/myRequestModel.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({Key? key}) : super(key: key);

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  int selected = 0;
  RequestModel? requests;
  Future<void> getData({
    required String apply_type,
  }) async {
    try {
      var headers = {
        'Cookie': 'ci_session=837aa322a1d12291d0f8e572ee73739f6ac390a4'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://jetsetterindia.com/app/v1/api/passport_visa_apply'));
      request.fields
          .addAll({'user_id': CUR_USERID.toString(), 'apply_type': apply_type});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        requests = RequestModel.fromJson(json);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  Widget getStatus(int status) {
    switch (status) {
      case 0:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              border: Border.all(color: colors.primary),
              borderRadius: BorderRadius.circular(5),
              color: colors.primary.withOpacity(0.2)),
          child: Text(
            'Pending',
            style: TextStyle(color: colors.primary),
          ),
        );
      case 1:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(5),
              color: Colors.green.withOpacity(0.2)),
          child: Text(
            'Approved',
            style: TextStyle(color: Colors.green),
          ),
        );

      case 2:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(5),
              color: Colors.red.withOpacity(0.2)),
          child: Text(
            'Rejected',
            style: TextStyle(color: Colors.red),
          ),
        );

      case 3:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
              color: Colors.black.withOpacity(0.2)),
          child: Text(
            'Completed',
            style: TextStyle(color: Colors.black),
          ),
        );
      default:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              border: Border.all(color: colors.primary),
              borderRadius: BorderRadius.circular(5),
              color: colors.primary.withOpacity(0.2)),
          child: Text(
            'Pending',
            style: TextStyle(color: colors.primary),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary1,
      appBar: getSimpleAppBar('My Requests', context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    selected = 0;
                  }),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selected == 0
                          ? Colors.teal
                          : Colors.teal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.teal),
                    ),
                    child: Text(
                      "Passport",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: selected == 0 ? Colors.white : Colors.teal),
                    ),
                  ),
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    selected = 1;
                  }),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selected == 1
                          ? Colors.teal
                          : Colors.teal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.teal),
                    ),
                    child: Text(
                      "Visa",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: selected == 1 ? Colors.white : Colors.teal),
                    ),
                  ),
                ),
              )
            ]),
            Divider(color: Colors.transparent),
            Expanded(
              child: FutureBuilder(
                  future: getData(apply_type: selected.toString()),
                  builder: (context, snap) {
                    return snap.connectionState == ConnectionState.waiting
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: requests!.data.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RequestDetailScren(
                                            data: requests!.data[index],
                                          ))),
                              child: Card(
                                elevation: 2,
                                color: Colors.white,
                                margin: const EdgeInsets.only(bottom: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${requests!.data[index].firstName} ${requests!.data[index].lastName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            DateFormat('dd-MM-yyyy').format(
                                              DateTime.parse(requests!
                                                  .data[index].createdAt
                                                  .toString()),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(requests!.data[index].mobile
                                          .toString()),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '₹ 120',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          getStatus(int.parse(requests!
                                              .data[index].status
                                              .toString())),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
