// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class SearchScreen extends StatefulWidget {
//   SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final _key = GlobalKey<FormState>();
//   InputDecoration TextFormFieldDeco = InputDecoration(
//     contentPadding: const EdgeInsets.all(10),
//     fillColor: Colors.white,
//     hintStyle: const TextStyle(fontSize: 14),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: BorderSide(color: Colors.grey.shade400),
//     ),
//     focusedErrorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: const BorderSide(color: Colors.red),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: const BorderSide(color: Colors.red),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: const BorderSide(color: Colors.teal),
//     ),
//   );
//   final TextEditingController from = TextEditingController();
//
//   final TextEditingController to = TextEditingController();
//
//   final TextEditingController date = TextEditingController();
//
//   DateTime? _selectedDate;
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//         date.text = DateFormat('yMMMd').format(_selectedDate!);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: const Text(
//           "Bus",
//           style: TextStyle(
//             fontSize: 20,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _key,
//           child: Column(
//             children: [
//               TextFormField(
//                 cursorColor: Colors.teal,
//                 decoration: TextFormFieldDeco.copyWith(
//                   hintText: "From Where",
//                   prefixIcon: const Icon(
//                     Icons.location_on,
//                     color: Colors.red,
//                   ),
//                 ),
//                 textInputAction: TextInputAction.next,
//                 controller: to,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter location';
//                   }
//                 },
//               ),
//               const Divider(color: Colors.transparent),
//               TextFormField(
//                 textInputAction: TextInputAction.next,
//                 cursorColor: Colors.teal,
//                 decoration: TextFormFieldDeco.copyWith(
//                     hintText: "To Where",
//                     prefixIcon: const Icon(
//                       Icons.location_on,
//                       color: Colors.red,
//                     )),
//                 controller: from,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter location';
//                   }
//                 },
//               ),
//               const Divider(color: Colors.transparent),
//               TextFormField(
//                 textInputAction: TextInputAction.done,
//                 readOnly: true,
//                 controller: date,
//                 cursorColor: Colors.teal,
//                 decoration: TextFormFieldDeco.copyWith(
//                     hintText: "Date",
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.grey.shade400),
//                     ),
//                     suffixIcon: GestureDetector(
//                       onTap: () => _selectDate(context),
//                       child: const Icon(
//                         Icons.calendar_month,
//                       ),
//                     )),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select date';
//                   }
//                 },
//               ),
//               const Divider(color: Colors.transparent),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_key.currentState!.validate()) {
//                     print(from.text);
//                     print(to.text);
//                     print(date.text);
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                     fixedSize: const Size.fromWidth(double.maxFinite),
//                     backgroundColor: Colors.teal,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10))),
//                 child: const Text(
//                   "Search",
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//               const Divider(color: Colors.transparent),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
