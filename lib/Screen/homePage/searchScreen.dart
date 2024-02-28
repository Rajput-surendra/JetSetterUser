import 'package:eshop_multivendor/Screen/Bus/BusScreen.dart';
import 'package:eshop_multivendor/Screen/Bus/bookingScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Helper/Color.dart';
import '../../widgets/appBar.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController from = TextEditingController();

  final TextEditingController to = TextEditingController();

  final TextEditingController date = TextEditingController();

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        date.text = DateFormat('yMMMd').format(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary1,
      appBar: getSimpleAppBar('Bus', context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'ubuntu',
                ),
                textCapitalization: TextCapitalization.words,
                cursorColor: Colors.teal,
                decoration: InputDecoration()
                    .applyDefaults(Theme.of(context).inputDecorationTheme)
                    .copyWith(
                      hintText: "From Where",
                      prefixIcon: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    ),
                textInputAction: TextInputAction.next,
                controller: to,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
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
                textInputAction: TextInputAction.done,
                cursorColor: Colors.teal,
                decoration: InputDecoration()
                    .applyDefaults(Theme.of(context).inputDecorationTheme)
                    .copyWith(
                        hintText: "To Where",
                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        )),
                controller: from,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                },
              ),
              const Divider(color: Colors.transparent),
              TextFormField(
                textInputAction: TextInputAction.done,
                readOnly: true,
                controller: date,
                cursorColor: Colors.teal,
                decoration: InputDecoration()
                    .applyDefaults(Theme.of(context).inputDecorationTheme)
                    .copyWith(
                        hintText: "Date",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: const Icon(
                            Icons.calendar_month,
                          ),
                        )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select date';
                  }
                },
              ),
              const Divider(color: Colors.transparent),
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    print(from.text);
                    print(to.text);
                    print(date.text);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          BusScreen(title: "${from.text} - ${to.text}"),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(double.maxFinite, 45),
                    backgroundColor: colors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  "Search",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const Divider(color: Colors.transparent),
            ],
          ),
        ),
      ),
    );
  }
}
