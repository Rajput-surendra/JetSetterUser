import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Model/myRequestModel.dart';
import 'package:eshop_multivendor/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestDetailScren extends StatelessWidget {
  const RequestDetailScren({Key? key, required this.data}) : super(key: key);
  final RequestData data;
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
      appBar: getSimpleAppBar('Request Details', context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Applicant Detail",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Divider(color: Colors.transparent),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colors.whiteTemp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "First Name : ${data.firstName}",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Last Name : ${data.lastName}",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Phone Number : ${data.mobile}",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Email : ${data.email}",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Gender : ${data.gender!.toUpperCase()}",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Date of Birth : ${data.age}",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              const Divider(color: Colors.transparent),
              Text(
                "Documents Uploded",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Divider(color: Colors.transparent),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colors.whiteTemp,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    data.photograph == ''
                        ? SizedBox.shrink()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Photograph',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width * .25,
                                height: MediaQuery.of(context).size.width * .25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colors.primary1),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                      placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                                color: colors.primary),
                                          ),
                                      imageUrl:
                                          'https://jetsetterindia.com/${data.photograph}'),
                                ),
                              ),
                            ],
                          ),
                    data.passportFront == ''
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              Text(
                                'Front',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width * .25,
                                height: MediaQuery.of(context).size.width * .25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colors.primary1),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                      placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                                color: colors.primary),
                                          ),
                                      imageUrl:
                                          'https://jetsetterindia.com/${data.passportFront}'),
                                ),
                              ),
                            ],
                          ),
                    data.passportBack == ''
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              Text(
                                'Back',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width * .25,
                                height: MediaQuery.of(context).size.width * .25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colors.primary1),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                      placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                                color: colors.primary),
                                          ),
                                      imageUrl:
                                          'https://jetsetterindia.com/${data.passportBack}'),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              const Divider(color: Colors.transparent),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  getStatus(int.parse(data.status.toString())),
                ],
              ),
              const Divider(color: Colors.transparent),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colors.whiteTemp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Applied on : ${DateFormat('dd MMM, yyyy').format(
                        DateTime.parse(data.createdAt.toString()),
                      )}',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Application Type : ${data.passportType == 0 ? 'Fresh Apply' : 'Re-Issue'}',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Application Fee : ₹${data.amount}',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
