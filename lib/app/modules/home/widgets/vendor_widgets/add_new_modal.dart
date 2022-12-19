// import 'package:flutter/material.dart';
// import 'package:flutter_erp/app/data/models/vendor.dart';
// import 'package:flutter_erp/app/modules/home/widgets/modal_accordion.dart';
// import 'package:flutter_erp/app/modules/home/widgets/modal_form_field.dart';
// import 'package:get/get.dart';
//
// class AddVendorModal extends StatefulWidget {
//   const AddVendorModal({Key? key}) : super(key: key);
//
//   @override
//   State<AddVendorModal> createState() => _AddVendorModalState();
// }
//
// class _AddVendorModalState extends State<AddVendorModal> {
//   late final GlobalKey<FormState> _formKey;
//   late Vendor _vendor;
//
//   @override
//   void initState() {
//     _formKey = GlobalKey<FormState>();
//     _vendor = Vendor();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       alignment: Alignment.center,
//       child: Container(
//         width: Get.width * 0.5,
//         constraints: BoxConstraints(
//           maxHeight: Get.height * 0.7,
//         ),
//         decoration: BoxDecoration(
//           color: context.theme.colorScheme.background,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Add Vendor",
//               style: context.textTheme.titleLarge!.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: context.theme.colorScheme.onBackground,
//               ),
//             ),
//             const SizedBox(
//               height: 22,
//             ),
//             Expanded(
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       _basicDetails(),
//                       _Address(),
//                       _BusinessDetails(),
//                       _Licences(),
//                       _BankDetails(),
//                       _AdditionalInformation(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             _Footer(
//               onCancel: () {
//                 Get.back();
//               },
//               onSave: () {
//                 if (_formKey.currentState?.validate() ?? false) {
//                   _formKey.currentState?.save();
//                   Get.back(result: _vendor);
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _basicDetails() {
//     return Column(
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: ModalFormField(
//                 title: "Name",
//                 keyboardType: TextInputType.name,
//                 maxLength: 40,
//                 onSaved: (value) {
//                   setState(() {
//                     _vendor.name = value;
//                   });
//                 },
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: ModalFormField(
//                 title: "Email",
//                 maxLength: 40,
//                 keyboardType: TextInputType.emailAddress,
//                 onSaved: (value) {
//                   if (value != null && value.isNotEmpty) {
//                     setState(() {
//                       _vendor.emailId = value;
//                     });
//                   }
//                 },
//                 onValidate: (value) {
//                   if (value is String) {
//                     if (value.isEmpty || value.isEmail) {
//                       return null;
//                     }
//                     return "Invalid Email";
//                   }
//                   return value;
//                 },
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 20),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               flex: 2,
//               child: ModalFormField(
//                 title: "Mobile no.",
//                 isRequired: true,
//                 maxLength: 20,
//                 onSaved: (value) {
//                   if (value != null && value.isNotEmpty) {
//                     setState(() {
//                       _vendor.mobileNo = value;
//                     });
//                   }
//                 },
//                 onValidate: (value) {
//                   if (value is String) {
//                     if (value.isPhoneNumber) {
//                       return null;
//                     }
//                     return "Required";
//                   }
//                   return value;
//                 },
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// class _Address extends StatelessWidget {
//   const _Address({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ModalAccordion(
//           title: "Address",
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 30),
//             child: Column(
//               children: [
//                 Row(
//                   children: const [
//                     Expanded(
//                       flex: 2,
//                       child: ModalFormField(
//                         title: "Street Address",
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Pin Code",
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: const [
//                     Expanded(
//                       child: ModalFormField(
//                         title: "City",
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: ModalFormField(
//                         title: "District",
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: ModalFormField(
//                         title: "State",
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: const [
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Country",
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Land Mark",
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }
//
// class _BusinessDetails extends StatelessWidget {
//   const _BusinessDetails({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ModalAccordion(
//           title: "Business Details",
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 30),
//             child: Column(
//               children: [
//                 Row(
//                   children: const [
//                     Expanded(
//                       flex: 2,
//                       child: ModalFormField(
//                         title: "GSTIN",
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Pan no.",
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: const [
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Area",
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Route",
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: const [
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Group",
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Landline no.",
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }
//
// class _Licences extends StatelessWidget {
//   const _Licences({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ModalAccordion(
//           title: "Licences",
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 30),
//             child: Column(
//               children: [
//                 Row(
//                   children: const [
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Food licence no.",
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Drug licence no.",
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }
//
// class _BankDetails extends StatelessWidget {
//   const _BankDetails({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ModalAccordion(
//           title: "Bank details",
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 30),
//             child: Column(
//               children: [
//                 Row(
//                   children: const [
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Bank Name",
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       flex: 2,
//                       child: ModalFormField(
//                         title: "Account no.",
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: const [
//                     Expanded(
//                       flex: 2,
//                       child: ModalFormField(
//                         title: "IFSC Code",
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Opening Balance",
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: const [
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Bill credit limit",
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: ModalFormField(
//                         title: "No. of credit days",
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: const [
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Credit Limit",
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: ModalFormField(
//                         title: "No. of pending bills",
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }
//
// class _AdditionalInformation extends StatelessWidget {
//   const _AdditionalInformation({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ModalAccordion(
//           title: "Additional Information",
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 30),
//             child: Column(
//               children: [
//                 Row(
//                   children: const [
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Short Name",
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: ModalFormField(
//                         title: "Contact Person",
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _Footer extends StatelessWidget {
//   const _Footer({
//     Key? key,
//     required this.onCancel,
//     required this.onSave,
//   }) : super(key: key);
//   final VoidCallback onCancel;
//   final VoidCallback onSave;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 20),
//         const Divider(),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             TextButton(
//               onPressed: onCancel,
//               style: ButtonStyle(
//                 padding: const MaterialStatePropertyAll(
//                   EdgeInsets.symmetric(vertical: 18, horizontal: 35),
//                 ),
//                 shape: MaterialStatePropertyAll(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//               ),
//               child: const Text(
//                 "Cancel",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 20),
//             ElevatedButton(
//               onPressed: onSave,
//               style: ButtonStyle(
//                 padding: const MaterialStatePropertyAll(
//                   EdgeInsets.symmetric(vertical: 18, horizontal: 45),
//                 ),
//                 shape: MaterialStatePropertyAll(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//               ),
//               child: const Text(
//                 "Save",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
