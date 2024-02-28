// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
//
// class VisaScreen extends StatefulWidget {
//
//
//   @override
//   State<VisaScreen> createState() => _VisaScreenState();
// }
//
// class _VisaScreenState extends State<VisaScreen> {
//   int selected = 0;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.grey.shade200,
//         appBar: AppBar(
//           backgroundColor: Colors.teal,
//           title: const Text(
//             "Visa",
//             style: TextStyle(
//               fontSize: 20,
//               color: Colors.white,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () => setState(() {
//                       selected = 0;
//                     }),
//                     child: Container(
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: selected == 0
//                             ? Colors.teal
//                             : Colors.teal.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Colors.teal),
//                       ),
//                       child: Text(
//                         "Apply For Fresh",
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: selected == 0 ? Colors.white : Colors.teal),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const VerticalDivider(),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () => setState(() {
//                       selected = 1;
//                     }),
//                     child: Container(
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: selected == 1
//                             ? Colors.teal
//                             : Colors.teal.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Colors.teal),
//                       ),
//                       child: Text(
//                         "Re-Issue Visa",
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: selected == 1 ? Colors.white : Colors.teal),
//                       ),
//                     ),
//                   ),
//                 )
//               ]),
//               const Divider(color: Colors.transparent),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: selected == 0 ? ApplyForFreshWidget() : ReIssueVisa(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// enum Gender {
//   male,
//   female,
// }
//
// enum BookingType {
//   normal,
//   tatkal,
// }
//
// class ApplyForFreshWidget extends StatefulWidget {
//   const ApplyForFreshWidget({super.key});
//
//   @override
//   State<ApplyForFreshWidget> createState() => _ApplyForFreshWidgetState();
// }
//
// class _ApplyForFreshWidgetState extends State<ApplyForFreshWidget> {
//   InputDecoration TextFormFieldDeco = InputDecoration(
//     contentPadding: const EdgeInsets.all(10),
//     fillColor: Colors.white,
//     hintStyle: const TextStyle(fontSize: 14),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: BorderSide(color: Colors.grey.shade400),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: const BorderSide(color: Colors.teal),
//     ),
//   );
//   final _key = GlobalKey<FormState>();
//   Gender? _selectedGender;
//   BookingType? _selectedBookingType;
//   DateTime? _selectedDate;
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
//         age.text = DateFormat('yMMMd').format(_selectedDate!);
//       });
//     }
//   }
//
//   final TextEditingController firstName = TextEditingController();
//   final TextEditingController lastName = TextEditingController();
//   final TextEditingController phone = TextEditingController();
//   final TextEditingController email = TextEditingController();
//   final TextEditingController age = TextEditingController();
//   File? passportFront;
//   File? passportBack;
//   File? photo;
//   Future<void> _pickImage(ImageSource source, int type) async {
//     try {
//       final pickedFile = await ImagePicker().pickImage(source: source);
//
//       if (pickedFile != null) {
//         setState(() {
//           switch (type) {
//             case 1:
//               passportFront = File(pickedFile.path);
//               break;
//             case 2:
//               passportBack = File(pickedFile.path);
//
//               break;
//             case 3:
//               photo = File(pickedFile.path);
//
//               break;
//             default:
//           }
//         });
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }
//
//   void _showImagePickerOptions(BuildContext context, int type) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           color: Colors.white,
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(
//                   Icons.photo_library,
//                   color: Colors.black,
//                 ),
//                 title: const Text(
//                   'Choose from Gallery',
//                 ),
//                 onTap: () {
//                   _pickImage(ImageSource.gallery, type);
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.camera_alt,
//                   color: Colors.black,
//                 ),
//                 title: const Text(
//                   'Take a Picture',
//                 ),
//                 onTap: () {
//                   _pickImage(ImageSource.camera, type);
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> uploadData({
//     required String firstName,
//     required String lastName,
//     required String gender,
//     required String phone,
//     required String email,
//     required String age,
//     required String type,
//     required String passport_type,
//     required String apply_type,
//     required String passport_front,
//     required String passport_back,
//     required String photograph,
//   }) async {
//     try {
//       var request = http.MultipartRequest('POST',
//           Uri.parse('https://jetsetterindia.com/app/v1/api/apply_visa'));
//       request.fields.addAll({
//         'passport_type': passport_type,
//         'apply_type': apply_type,
//         'first_name': firstName,
//         'last_name': lastName,
//         'gender': gender,
//         'mobile': phone,
//         'email': email,
//         'age': age,
//         'type': type,
//       });
//       print(passport_front);
//       print(passport_back);
//       print(photograph);
//       request.files.add(
//           await http.MultipartFile.fromPath('passport_front', passport_front));
//       request.files.add(
//           await http.MultipartFile.fromPath('passport_back', passport_back));
//       request.files
//           .add(await http.MultipartFile.fromPath('photograph', photograph));
//       log(request.fields.toString());
//       http.StreamedResponse response = await request.send();
//       var json = jsonDecode(await response.stream.bytesToString());
//       log(json.toString());
//       if (response.statusCode == 200) {
//       } else {
//         print(response.reasonPhrase);
//       }
//     } catch (e, stackTrace) {
//       print(stackTrace);
//       throw Exception(e);
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     firstName.clear();
//     lastName.clear();
//     phone.clear();
//     email.clear();
//     age.clear();
//     _selectedBookingType = null;
//     _selectedDate = null;
//     _selectedGender = null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _key,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextFormField(
//             cursorColor: Colors.teal,
//             decoration: TextFormFieldDeco.copyWith(
//               hintText: "First Name",
//             ),
//             textInputAction: TextInputAction.next,
//             controller: firstName,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter first name';
//               }
//             },
//           ),
//           const Divider(color: Colors.transparent),
//           TextFormField(
//             textInputAction: TextInputAction.next,
//             cursorColor: Colors.teal,
//             decoration: TextFormFieldDeco.copyWith(
//               hintText: "Last Name",
//             ),
//             controller: lastName,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter last name';
//               }
//             },
//           ),
//           const Divider(color: Colors.transparent),
//           const Text(
//             "Gender",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           Row(
//             children: [
//               Radio(
//                 activeColor: Colors.teal,
//                 value: Gender.male,
//                 groupValue: _selectedGender,
//                 onChanged: (Gender? value) {
//                   setState(() {
//                     _selectedGender = value!;
//                   });
//                 },
//               ),
//               const Text(
//                 'Male',
//                 style: TextStyle(fontSize: 16),
//               ),
//               Radio(
//                 activeColor: Colors.teal,
//                 value: Gender.female,
//                 groupValue: _selectedGender,
//                 onChanged: (Gender? value) {
//                   setState(() {
//                     _selectedGender = value!;
//                   });
//                 },
//               ),
//               const Text(
//                 'Female',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//           const Divider(color: Colors.transparent),
//           TextFormField(
//             textInputAction: TextInputAction.next,
//             cursorColor: Colors.teal,
//             maxLength: 10,
//             decoration: TextFormFieldDeco.copyWith(
//               hintText: "Mobile Number",
//               counterText: "",
//             ),
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.phone,
//             controller: phone,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter phone number';
//               } else if (value.length < 10) {
//                 return 'Please enter valid phone number';
//               }
//             },
//           ),
//           const Divider(color: Colors.transparent),
//           TextFormField(
//             textInputAction: TextInputAction.next,
//             keyboardType: TextInputType.emailAddress,
//             cursorColor: Colors.teal,
//             decoration: TextFormFieldDeco.copyWith(
//               hintText: "Email Address",
//             ),
//             controller: email,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter an email address';
//               } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
//                   .hasMatch(value)) {
//                 return 'Please enter a valid email address';
//               }
//               return null; // Return null if the input is valid
//             },
//           ),
//           const Divider(color: Colors.transparent),
//           TextFormField(
//             textInputAction: TextInputAction.done,
//             readOnly: true,
//             controller: age,
//             cursorColor: Colors.teal,
//             decoration: TextFormFieldDeco.copyWith(
//                 hintText: "Age",
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: Colors.grey.shade400),
//                 ),
//                 suffixIcon: GestureDetector(
//                   onTap: () => _selectDate(context),
//                   child: const Icon(
//                     Icons.calendar_month,
//                   ),
//                 )),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please select age';
//               }
//             },
//           ),
//           const Divider(color: Colors.transparent),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                 onTap: () => _showImagePickerOptions(context, 1),
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * .15,
//                   width: MediaQuery.of(context).size.width * .29,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.teal.withOpacity(0.1),
//                       image: passportFront == null
//                           ? null
//                           : DecorationImage(image: FileImage(passportFront!)),
//                       border: Border.all(color: Colors.teal)),
//                   child: passportFront == null
//                       ? const Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Passport Front",
//                               style:
//                                   TextStyle(color: Colors.teal, fontSize: 12),
//                             ),
//                           ],
//                         )
//                       : const SizedBox.shrink(),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => _showImagePickerOptions(context, 2),
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * .15,
//                   width: MediaQuery.of(context).size.width * .29,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.teal.withOpacity(0.1),
//                       image: passportBack == null
//                           ? null
//                           : DecorationImage(image: FileImage(passportBack!)),
//                       border: Border.all(color: Colors.teal)),
//                   child: passportBack == null
//                       ? const Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Passport Back",
//                               style:
//                                   TextStyle(color: Colors.teal, fontSize: 12),
//                             ),
//                           ],
//                         )
//                       : const SizedBox.shrink(),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => _showImagePickerOptions(context, 3),
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * .15,
//                   width: MediaQuery.of(context).size.width * .29,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.teal.withOpacity(0.1),
//                       image: photo == null
//                           ? null
//                           : DecorationImage(image: FileImage(photo!)),
//                       border: Border.all(color: Colors.teal)),
//                   child: photo == null
//                       ? const Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Photograph",
//                               style:
//                                   TextStyle(color: Colors.teal, fontSize: 12),
//                             ),
//                           ],
//                         )
//                       : const SizedBox.shrink(),
//                 ),
//               ),
//             ],
//           ),
//           const Divider(color: Colors.transparent),
//           Row(
//             children: [
//               Radio(
//                 activeColor: Colors.teal,
//                 value: BookingType.normal,
//                 groupValue: _selectedBookingType,
//                 onChanged: (BookingType? value) {
//                   setState(() {
//                     _selectedBookingType = value!;
//                   });
//                 },
//               ),
//               const Text(
//                 'Normal',
//                 style: TextStyle(fontSize: 16),
//               ),
//               Radio(
//                 activeColor: Colors.teal,
//                 value: BookingType.tatkal,
//                 groupValue: _selectedBookingType,
//                 onChanged: (BookingType? value) {
//                   setState(() {
//                     _selectedBookingType = value!;
//                   });
//                 },
//               ),
//               const Text(
//                 'Tatkal',
//                 style: TextStyle(fontSize: 16),
//               ),
//               const VerticalDivider(),
//               Text(
//                 "Amount: ${_selectedBookingType == BookingType.normal ? "500" : _selectedBookingType == BookingType.tatkal ? "1000" : 0}",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//           const Divider(color: Colors.transparent),
//           ElevatedButton(
//             onPressed: () {
//               if (_key.currentState!.validate() &&
//                   passportFront != null &&
//                   passportBack != null &&
//                   photo != null) {
//                 print(firstName.text);
//                 print(lastName.text);
//                 print(_selectedGender!.name);
//                 print(phone.text);
//                 print(email.text);
//                 print(age.text);
//                 print(passportFront!.path.toString());
//                 print(passportBack!.path.toString());
//                 print(photo!.path.toString());
//                 print(_selectedBookingType);
//                 print(DateFormat('yyyy-MM-dd').format(_selectedDate!));
//                 uploadData(
//                   firstName: firstName.text.toString(),
//                   lastName: lastName.text.toString(),
//                   gender: _selectedGender!.name.toString(),
//                   phone: phone.text.toString(),
//                   email: email.text.toString(),
//                   age: DateFormat('yyyy-MM-dd')
//                       .format(_selectedDate!)
//                       .toString(),
//                   type: _selectedBookingType == BookingType.normal ? "0" : "1",
//                   passport_type: "0",
//                   apply_type: "1",
//                   passport_front: passportFront!.path.toString(),
//                   passport_back: passportBack!.path.toString(),
//                   photograph: photo!.path.toString(),
//                 );
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                     content: Text("Some Fields are missing, please check")));
//               }
//             },
//             style: ElevatedButton.styleFrom(
//                 fixedSize: const Size.fromWidth(double.maxFinite),
//                 backgroundColor: Colors.teal,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10))),
//             child: const Text(
//               "Submit",
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ),
//           const Divider(color: Colors.transparent),
//         ],
//       ),
//     );
//   }
// }
//
// class ReIssueVisa extends StatefulWidget {
//   const ReIssueVisa({super.key});
//
//   @override
//   State<ReIssueVisa> createState() => _ReIssueVisaState();
// }
//
// class _ReIssueVisaState extends State<ReIssueVisa> {
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
//   final _key = GlobalKey<FormState>();
//   Gender? _selectedGender;
//   BookingType? _selectedBookingType;
//   DateTime? _selectedDate;
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
//         age.text = DateFormat('yMMMd').format(_selectedDate!);
//       });
//     }
//   }
//
//   final TextEditingController firstName = TextEditingController();
//   final TextEditingController lastName = TextEditingController();
//   final TextEditingController phone = TextEditingController();
//   final TextEditingController email = TextEditingController();
//   final TextEditingController age = TextEditingController();
//   File? passportFront;
//   File? passportBack;
//   File? photo;
//   Future<void> _pickImage(ImageSource source, int type) async {
//     try {
//       final pickedFile = await ImagePicker().pickImage(source: source);
//
//       if (pickedFile != null) {
//         setState(() {
//           switch (type) {
//             case 1:
//               passportFront = File(pickedFile.path);
//               break;
//             case 2:
//               passportBack = File(pickedFile.path);
//
//               break;
//             case 3:
//               photo = File(pickedFile.path);
//
//               break;
//             default:
//           }
//         });
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }
//
//   void _showImagePickerOptions(BuildContext context, int type) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           color: Colors.white,
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(
//                   Icons.photo_library,
//                   color: Colors.black,
//                 ),
//                 title: const Text(
//                   'Choose from Gallery',
//                 ),
//                 onTap: () {
//                   _pickImage(ImageSource.gallery, type);
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.camera_alt,
//                   color: Colors.black,
//                 ),
//                 title: const Text(
//                   'Take a Picture',
//                 ),
//                 onTap: () {
//                   _pickImage(ImageSource.camera, type);
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> uploadData({
//     required String firstName,
//     required String lastName,
//     required String gender,
//     required String phone,
//     required String email,
//     required String age,
//     required String type,
//     required String passport_type,
//     required String apply_type,
//     required String passport_front,
//     required String passport_back,
//     required String photograph,
//   }) async {
//     try {
//       var request = http.MultipartRequest('POST',
//           Uri.parse('https://jetsetterindia.com/app/v1/api/apply_visa'));
//       request.fields.addAll({
//         'passport_type': passport_type,
//         'apply_type': apply_type,
//         'first_name': firstName,
//         'last_name': lastName,
//         'gender': gender,
//         'mobile': phone,
//         'email': email,
//         'age': age,
//         'type': type,
//       });
//       print(passport_front);
//       print(passport_back);
//       print(photograph);
//       request.files.add(
//           await http.MultipartFile.fromPath('passport_front', passport_front));
//       request.files.add(
//           await http.MultipartFile.fromPath('passport_back', passport_back));
//       request.files
//           .add(await http.MultipartFile.fromPath('photograph', photograph));
//       log(request.fields.toString());
//       http.StreamedResponse response = await request.send();
//       var json = jsonDecode(await response.stream.bytesToString());
//       log(json.toString());
//       if (response.statusCode == 200) {
//       } else {
//         print(response.reasonPhrase);
//       }
//     } catch (e, stackTrace) {
//       print(stackTrace);
//       throw Exception(e);
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     firstName.clear();
//     lastName.clear();
//     phone.clear();
//     email.clear();
//     age.clear();
//     _selectedBookingType = null;
//     _selectedDate = null;
//     _selectedGender = null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _key,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextFormField(
//             cursorColor: Colors.teal,
//             decoration: TextFormFieldDeco.copyWith(
//               hintText: "First Name",
//             ),
//             textInputAction: TextInputAction.next,
//             controller: firstName,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter first name';
//               }
//             },
//           ),
//           const Divider(color: Colors.transparent),
//           TextFormField(
//             textInputAction: TextInputAction.next,
//             cursorColor: Colors.teal,
//             decoration: TextFormFieldDeco.copyWith(
//               hintText: "Last Name",
//             ),
//             controller: lastName,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter last name';
//               }
//             },
//           ),
//           const Divider(color: Colors.transparent),
//           const Text(
//             "Gender",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           Row(
//             children: [
//               Radio(
//                 activeColor: Colors.teal,
//                 value: Gender.male,
//                 groupValue: _selectedGender,
//                 onChanged: (Gender? value) {
//                   setState(() {
//                     _selectedGender = value!;
//                   });
//                 },
//               ),
//               const Text(
//                 'Male',
//                 style: TextStyle(fontSize: 16),
//               ),
//               Radio(
//                 activeColor: Colors.teal,
//                 value: Gender.female,
//                 groupValue: _selectedGender,
//                 onChanged: (Gender? value) {
//                   setState(() {
//                     _selectedGender = value!;
//                   });
//                 },
//               ),
//               const Text(
//                 'Female',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//           const Divider(color: Colors.transparent),
//           TextFormField(
//             textInputAction: TextInputAction.next,
//             cursorColor: Colors.teal,
//             maxLength: 10,
//             decoration: TextFormFieldDeco.copyWith(
//               hintText: "Mobile Number",
//               counterText: "",
//             ),
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.phone,
//             controller: phone,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter phone number';
//               } else if (value.length < 10) {
//                 return 'Please enter valid phone number';
//               }
//             },
//           ),
//           const Divider(color: Colors.transparent),
//           TextFormField(
//             textInputAction: TextInputAction.next,
//             keyboardType: TextInputType.emailAddress,
//             cursorColor: Colors.teal,
//             decoration: TextFormFieldDeco.copyWith(
//               hintText: "Email Address",
//             ),
//             controller: email,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter an email address';
//               } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
//                   .hasMatch(value)) {
//                 return 'Please enter a valid email address';
//               }
//               return null; // Return null if the input is valid
//             },
//           ),
//           const Divider(color: Colors.transparent),
//           TextFormField(
//             textInputAction: TextInputAction.done,
//             readOnly: true,
//             controller: age,
//             cursorColor: Colors.teal,
//             decoration: TextFormFieldDeco.copyWith(
//                 hintText: "Age",
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: Colors.grey.shade400),
//                 ),
//                 suffixIcon: GestureDetector(
//                   onTap: () => _selectDate(context),
//                   child: const Icon(
//                     Icons.calendar_month,
//                   ),
//                 )),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please select age';
//               }
//             },
//           ),
//           const Divider(color: Colors.transparent),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                 onTap: () => _showImagePickerOptions(context, 1),
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * .15,
//                   width: MediaQuery.of(context).size.width * .29,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.teal.withOpacity(0.1),
//                       image: passportFront == null
//                           ? null
//                           : DecorationImage(image: FileImage(passportFront!)),
//                       border: Border.all(color: Colors.teal)),
//                   child: passportFront == null
//                       ? const Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Visa Front",
//                               style:
//                                   TextStyle(color: Colors.teal, fontSize: 12),
//                             ),
//                           ],
//                         )
//                       : const SizedBox.shrink(),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => _showImagePickerOptions(context, 2),
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * .15,
//                   width: MediaQuery.of(context).size.width * .29,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.teal.withOpacity(0.1),
//                       image: passportBack == null
//                           ? null
//                           : DecorationImage(image: FileImage(passportBack!)),
//                       border: Border.all(color: Colors.teal)),
//                   child: passportBack == null
//                       ? const Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Visa Back",
//                               style:
//                                   TextStyle(color: Colors.teal, fontSize: 12),
//                             ),
//                           ],
//                         )
//                       : const SizedBox.shrink(),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => _showImagePickerOptions(context, 3),
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * .15,
//                   width: MediaQuery.of(context).size.width * .29,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.teal.withOpacity(0.1),
//                       image: photo == null
//                           ? null
//                           : DecorationImage(image: FileImage(photo!)),
//                       border: Border.all(color: Colors.teal)),
//                   child: photo == null
//                       ? const Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Photograph",
//                               style:
//                                   TextStyle(color: Colors.teal, fontSize: 12),
//                             ),
//                           ],
//                         )
//                       : const SizedBox.shrink(),
//                 ),
//               ),
//             ],
//           ),
//           const Divider(color: Colors.transparent),
//           Row(
//             children: [
//               Radio(
//                 activeColor: Colors.teal,
//                 value: BookingType.normal,
//                 groupValue: _selectedBookingType,
//                 onChanged: (BookingType? value) {
//                   setState(() {
//                     _selectedBookingType = value!;
//                   });
//                 },
//               ),
//               const Text(
//                 'Normal',
//                 style: TextStyle(fontSize: 16),
//               ),
//               Radio(
//                 activeColor: Colors.teal,
//                 value: BookingType.tatkal,
//                 groupValue: _selectedBookingType,
//                 onChanged: (BookingType? value) {
//                   setState(() {
//                     _selectedBookingType = value!;
//                   });
//                 },
//               ),
//               const Text(
//                 'Tatkal',
//                 style: TextStyle(fontSize: 16),
//               ),
//               const VerticalDivider(),
//               Text(
//                 "Amount: ${_selectedBookingType == BookingType.normal ? "500" : _selectedBookingType == BookingType.tatkal ? "1000" : 0}",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//           const Divider(color: Colors.transparent),
//           ElevatedButton(
//             onPressed: () {
//               if (_key.currentState!.validate() &&
//                   passportFront != null &&
//                   passportBack != null &&
//                   photo != null) {
//                 print(firstName.text);
//                 print(lastName.text);
//                 print(_selectedGender!.name);
//                 print(phone.text);
//                 print(email.text);
//                 print(age.text);
//                 print(passportFront!.path.toString());
//                 print(passportBack!.path.toString());
//                 print(photo!.path.toString());
//                 print(_selectedBookingType);
//                 print(DateFormat('yyyy-MM-dd').format(_selectedDate!));
//                 uploadData(
//                   firstName: firstName.text.toString(),
//                   lastName: lastName.text.toString(),
//                   gender: _selectedGender!.name.toString(),
//                   phone: phone.text.toString(),
//                   email: email.text.toString(),
//                   age: DateFormat('yyyy-MM-dd')
//                       .format(_selectedDate!)
//                       .toString(),
//                   type: _selectedBookingType == BookingType.normal ? "0" : "1",
//                   passport_type: "1",
//                   apply_type: "1",
//                   passport_front: passportFront!.path.toString(),
//                   passport_back: passportBack!.path.toString(),
//                   photograph: photo!.path.toString(),
//                 );
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                     content: Text("Some Fields are missing, please check")));
//               }
//             },
//             style: ElevatedButton.styleFrom(
//                 fixedSize: const Size.fromWidth(double.maxFinite),
//                 backgroundColor: Colors.teal,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10))),
//             child: const Text(
//               "Submit",
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ),
//           const Divider(color: Colors.transparent),
//         ],
//       ),
//     );
//   }
// }
