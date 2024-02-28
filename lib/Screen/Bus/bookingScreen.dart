import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BusBookingScreen extends StatefulWidget {
  const BusBookingScreen({Key? key}) : super(key: key);

  @override
  State<BusBookingScreen> createState() => _BusBookingScreenState();
}

class _BusBookingScreenState extends State<BusBookingScreen> {
  int gender = 0;
  int passangerCount = 1;
  double amount = 425;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary1,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: colors.primary,
            )),
        title: const Text(
          'Confirm Booking',
          style: TextStyle(
            color: colors.primary,
            fontWeight: FontWeight.normal,
            fontFamily: 'ubuntu',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 5,
                              offset: Offset(4, 4))
                        ]),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors.primary1,
                          ),
                          child: Icon(Icons.directions_bus_filled_outlined,
                              color: Colors.grey, size: 40),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .5,
                              child: Text(
                                "Charted Bus",
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Indore",
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Bhopal",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "3hr 24min",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Text(
                          "₹425",
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.transparent),
                  Text(
                    "Pickup & Drop",
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Divider(color: Colors.transparent),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 5,
                              offset: Offset(4, 4))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'ubuntu',
                          ),
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.teal,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 10,
                          decoration: InputDecoration()
                              .applyDefaults(
                                  Theme.of(context).inputDecorationTheme)
                              .copyWith(
                                hintText: "Pickup Loaction",
                                counterText: "",
                              ),
                        ),
                        const Divider(color: Colors.transparent),
                        TextFormField(
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'ubuntu',
                          ),
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.teal,
                          decoration: InputDecoration()
                              .applyDefaults(
                                  Theme.of(context).inputDecorationTheme)
                              .copyWith(
                                hintText: "Drop Loaction",
                              ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.transparent),
                  Text(
                    "Contact Information",
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Divider(color: Colors.transparent),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 5,
                              offset: Offset(4, 4))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'ubuntu',
                          ),
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.teal,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 10,
                          decoration: InputDecoration()
                              .applyDefaults(
                                  Theme.of(context).inputDecorationTheme)
                              .copyWith(
                                hintText: "Phone Number",
                                counterText: "",
                              ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            } else if (value.length < 10) {
                              return 'Please enter valid phone number';
                            }
                          },
                        ),
                        const Divider(color: Colors.transparent),
                        TextFormField(
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'ubuntu',
                          ),
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.teal,
                          decoration: InputDecoration()
                              .applyDefaults(
                                  Theme.of(context).inputDecorationTheme)
                              .copyWith(
                                hintText: "Email",
                                counterText: "",
                              ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an email address';
                            } else if (!RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null; // Return null if the input is valid
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.transparent),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Passanger Details",
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      TextButton.icon(
                          onPressed: () {
                            setState(() {
                              passangerCount++;
                              amount += amount;
                            });
                          },
                          icon: Icon(
                            Icons.add,
                            size: 15,
                          ),
                          style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            iconColor: colors.primary,
                          ),
                          label: Text(
                            "Add Passanger",
                            style: TextStyle(color: colors.primary),
                          ))
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                  ListView.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(color: Colors.transparent),
                      itemCount: passangerCount,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: Offset(4, 4))
                                  ]),
                              child: Column(
                                children: [
                                  TextFormField(
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'ubuntu',
                                    ),
                                    textCapitalization:
                                        TextCapitalization.words,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.teal,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    maxLength: 10,
                                    decoration: InputDecoration()
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(
                                          hintText: "Name",
                                          counterText: "",
                                        ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter passanger name';
                                      }
                                    },
                                  ),
                                  const Divider(color: Colors.transparent),
                                  Row(
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4),
                                        child: TextFormField(
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'ubuntu',
                                          ),
                                          textCapitalization:
                                              TextCapitalization.words,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number,
                                          cursorColor: Colors.teal,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          maxLength: 10,
                                          decoration: InputDecoration()
                                              .applyDefaults(Theme.of(context)
                                                  .inputDecorationTheme)
                                              .copyWith(
                                                hintText: "Age",
                                                counterText: "",
                                              ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter passanger age';
                                            }
                                          },
                                        ),
                                      ),
                                      VerticalDivider(),
                                      GestureDetector(
                                        onTap: () => setState(() {
                                          gender = 0;
                                        }),
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                              ),
                                              color: gender == 0
                                                  ? colors.primary
                                                  : null,
                                              border: Border.all(
                                                  color: gender == 0
                                                      ? colors.primary
                                                      : Colors.grey.shade200)),
                                          child: Text(
                                            'Male',
                                            style: TextStyle(
                                              color: gender == 0
                                                  ? colors.whiteTemp
                                                  : null,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => setState(() {
                                          gender = 1;
                                        }),
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                              color: gender == 1
                                                  ? colors.primary
                                                  : null,
                                              border: Border.all(
                                                  color: gender == 1
                                                      ? colors.primary
                                                      : Colors.grey.shade200)),
                                          child: Text(
                                            "Female",
                                            style: TextStyle(
                                              color: gender == 1
                                                  ? colors.whiteTemp
                                                  : null,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            index == 0
                                ? SizedBox.shrink()
                                : Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: () => setState(() {
                                        passangerCount--;
                                        amount = amount / 2;
                                      }),
                                      child: Icon(
                                        Icons.cancel,
                                        color: colors.primary,
                                        size: 20,
                                      ),
                                    ))
                          ],
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Amount : ₹${amount}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Proceed"),
                style:
                    ElevatedButton.styleFrom(backgroundColor: colors.primary),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
