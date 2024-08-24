// // ignore_for_file: always_declare_return_types

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:zoom_widget/zoom_widget.dart';

// import '../../../design/app_colors.dart';
// import '../providers/invoice_providers.dart';

// // ignore: must_be_immutable
// class Invoice extends StatefulWidget {
//   int id;
//   Invoice({required this.id, super.key});

//   @override
//   State<Invoice> createState() => _InvoiceState();
// }

// class _InvoiceState extends State<Invoice> {
//   @override
//   void initState() {
//     fetchData();
//     super.initState();
//   }

//   fetchData() async {
//     await Provider.of<InvoiceProvider>(context, listen: false).getInvoice(context, widget.id);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final invoice = Provider.of<InvoiceProvider>(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.blueGrey.withOpacity(0.1),
//                 spreadRadius: 3,
//                 blurRadius: 8,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: AppBar(
//             backgroundColor: Colors.white,
//             toolbarHeight: 70,
//             elevation: 0,
//             centerTitle: true,
//             iconTheme: const IconThemeData(color: AppColors.profilColor, size: 30),
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.vertical(
//                 bottom: Radius.circular(15),
//               ),
//             ),
//             title: Text(
//               'order_info'.tr(),
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontFamily: 'Roboto',
//                 fontStyle: FontStyle.normal,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: invoice.invoice != null
//             ? Zoom(
//                 initTotalZoomOut: true,
//                 maxZoomWidth: 1800,
//                 maxZoomHeight: 1800,
//                 backgroundColor: Colors.white,
//                 colorScrollBars: Colors.grey,
//                 opacityScrollBars: 0.9,
//                 scrollWeight: 5.0,
//                 centerOnScale: true,
//                 enableScroll: true,
//                 doubleTapZoom: true,
//                 zoomSensibility: 0.05,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     left: 20,
//                     right: 20,
//                     top: 0,
//                     bottom: 30,
//                   ),
//                   child: Column(
//                     children: [
//                       Table(
//                         border: TableBorder.all(color: Colors.black, width: 1),
//                         columnWidths: const {
//                           0: FlexColumnWidth(1.5),
//                           // 1: FlexColumnWidth(4),
//                           // 2: FlexColumnWidth(2),
//                         },
//                         children: const [
//                           TableRow(
//                             decoration: BoxDecoration(),
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Asmanay Cargo 106',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 36,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w900,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Table(
//                         border: TableBorder.all(color: Colors.black, width: 1),
//                         columnWidths: const {
//                           0: FlexColumnWidth(2),
//                           1: FlexColumnWidth(4),
//                           // 2: FlexColumnWidth(2),
//                         },
//                         children: const [
//                           TableRow(
//                             decoration: BoxDecoration(),
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'HYTAÝ ADRES',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'AŞGABAT Tel: +99361000066 Batyr Tel: +99365677767 Döwran Tel: +99362338637 Berdi',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Table(
//                         border: TableBorder.all(color: Colors.black, width: 1),
//                         columnWidths: const {
//                           0: FlexColumnWidth(4),
//                           1: FlexColumnWidth(3),
//                           2: FlexColumnWidth(4),
//                           3: FlexColumnWidth(5.5),
//                           4: FlexColumnWidth(2),
//                           5: FlexColumnWidth(1.5),
//                         },
//                         children: [
//                           TableRow(
//                             decoration: const BoxDecoration(),
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Sene',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 20,
//                                   bottom: 20,
//                                 ),
//                                 child: Center(
//                                   child: Builder(
//                                     builder: (context) {
//                                       final datee = invoice.invoice;
//                                       if (datee != null) {
//                                         return Text(
//                                           datee.date.toString(),
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 24,
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         );
//                                       } else {
//                                         return const Text('');
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Kabul ediji',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 20,
//                                   bottom: 20,
//                                 ),
//                                 child: Center(
//                                   child: Builder(
//                                     builder: (context) {
//                                       final nameC = invoice.invoice;
//                                       if (nameC != null) {
//                                         return Text(
//                                           nameC.customersName,
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 24,
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         );
//                                       } else {
//                                         return const Text('');
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Jemi kub',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 20,
//                                   bottom: 20,
//                                 ),
//                                 child: Center(
//                                   child: Builder(
//                                     builder: (context) {
//                                       final cubs = invoice.invoice;
//                                       if (cubs != null) {
//                                         return Text(
//                                           cubs.summaryCube,
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 24,
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         );
//                                       } else {
//                                         return const Text('Null');
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Table(
//                         border: TableBorder.all(color: Colors.black, width: 1),
//                         columnWidths: const {
//                           0: FlexColumnWidth(4),
//                           1: FlexColumnWidth(3),
//                           2: FlexColumnWidth(4),
//                           3: FlexColumnWidth(5.5),
//                           4: FlexColumnWidth(2),
//                           5: FlexColumnWidth(1.5),
//                         },
//                         children: [
//                           TableRow(
//                             decoration: const BoxDecoration(),
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Getirijiniň telefon belgisi',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 20,
//                                   bottom: 20,
//                                 ),
//                                 child: Center(
//                                   child: Builder(
//                                     builder: (context) {
//                                       final phone = invoice.invoice;
//                                       if (phone != null) {
//                                         return Text(
//                                           phone.providerPhone,
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 24,
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         );
//                                       } else {
//                                         return const Text('Null');
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Kabul edijiniň telefon belgisi',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 20,
//                                   bottom: 20,
//                                 ),
//                                 child: Center(
//                                   child: Builder(
//                                     builder: (context) {
//                                       final phoneC = invoice.invoice;
//                                       if (phoneC != null) {
//                                         return Text(
//                                           phoneC.customersPhone,
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 24,
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         );
//                                       } else {
//                                         return const Text('');
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Jemi kg',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 20,
//                                   bottom: 20,
//                                 ),
//                                 child: Center(
//                                   child: Builder(
//                                     builder: (context) {
//                                       final kg = invoice.invoice;
//                                       if (kg != null) {
//                                         return Text(
//                                           kg.summaryKg,
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 24,
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         );
//                                       } else {
//                                         return const Text('');
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Table(
//                         border: TableBorder.all(color: Colors.black, width: 1),
//                         columnWidths: const {
//                           0: FlexColumnWidth(4),
//                           1: FlexColumnWidth(3),
//                           2: FlexColumnWidth(3),
//                           3: FlexColumnWidth(6),
//                           4: FlexColumnWidth(2.5),
//                           5: FlexColumnWidth(1.5),
//                         },
//                         children: [
//                           TableRow(
//                             decoration: const BoxDecoration(),
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Ugran ýeri',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 20,
//                                   bottom: 20,
//                                 ),
//                                 child: Center(
//                                   child: Builder(
//                                     builder: (context) {
//                                       final pointF = invoice.invoice;
//                                       if (pointF != null) {
//                                         return Text(
//                                           pointF.pointFrom,
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 24,
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         );
//                                       } else {
//                                         return const Text('');
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Gelmeli ýeri',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 20,
//                                   bottom: 20,
//                                 ),
//                                 child: Center(
//                                   child: Builder(
//                                     builder: (context) {
//                                       final pointT = invoice.invoice;
//                                       if (pointT != null) {
//                                         return Text(
//                                           pointT.pointTo,
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 24,
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         );
//                                       } else {
//                                         return const Text('');
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Jemi baha',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   top: 20,
//                                   bottom: 20,
//                                 ),
//                                 child: Center(
//                                   child: Builder(
//                                     builder: (context) {
//                                       final costS = invoice.invoice;
//                                       if (costS != null) {
//                                         return Text(
//                                           costS.summaryPrice.toString(),
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 24,
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         );
//                                       } else {
//                                         return const Text('');
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Table(
//                         border: TableBorder.all(color: Colors.black, width: 1),
//                         columnWidths: const {
//                           0: FlexColumnWidth(4),
//                           1: FlexColumnWidth(6),
//                           2: FlexColumnWidth(2),
//                           3: FlexColumnWidth(2),
//                           4: FlexColumnWidth(2),
//                           5: FlexColumnWidth(2.5),
//                           6: FlexColumnWidth(1.5),
//                         },
//                         children: const [
//                           TableRow(
//                             decoration: BoxDecoration(),
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Gap görnüşi',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Ölçegi',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Ýer sany',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Kub',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'KG',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Harydyň ady',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 20, bottom: 20),
//                                 child: Center(
//                                   child: Text(
//                                     'Bahasy',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 24,
//                                       fontFamily: 'Roboto',
//                                       fontStyle: FontStyle.normal,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: invoice.invoice!.cargoItems.length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return Table(
//                             border: TableBorder.all(
//                               color: Colors.black,
//                               width: 1,
//                             ),
//                             columnWidths: const {
//                               0: FlexColumnWidth(4),
//                               1: FlexColumnWidth(2),
//                               2: FlexColumnWidth(2),
//                               3: FlexColumnWidth(2),
//                               4: FlexColumnWidth(2),
//                               5: FlexColumnWidth(2),
//                               6: FlexColumnWidth(2),
//                               7: FlexColumnWidth(2.5),
//                               8: FlexColumnWidth(1.5),
//                             },
//                             children: [
//                               TableRow(
//                                 decoration: const BoxDecoration(),
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                       top: 20,
//                                       bottom: 20,
//                                     ),
//                                     child: Center(
//                                       child: Builder(
//                                         builder: (context) {
//                                           final iddd = invoice.invoice;
//                                           if (iddd != null) {
//                                             return Text(
//                                               iddd.cargoItems[index].typePackagingId,
//                                               style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 24,
//                                                 fontFamily: 'Roboto',
//                                                 fontStyle: FontStyle.normal,
//                                                 fontWeight: FontWeight.w700,
//                                               ),
//                                             );
//                                           } else {
//                                             return const Text('');
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                       top: 20,
//                                       bottom: 20,
//                                     ),
//                                     child: Center(
//                                       child: Builder(
//                                         builder: (context) {
//                                           final first = invoice.invoice;
//                                           if (first != null) {
//                                             return Text(
//                                               first.cargoItems[index].packingSizeFirst.toString(),
//                                               style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 24,
//                                                 fontFamily: 'Roboto',
//                                                 fontStyle: FontStyle.normal,
//                                                 fontWeight: FontWeight.w700,
//                                               ),
//                                             );
//                                           } else {
//                                             return const Text('');
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                       top: 20,
//                                       bottom: 20,
//                                     ),
//                                     child: Center(
//                                       child: Builder(
//                                         builder: (context) {
//                                           final second = invoice.invoice;
//                                           if (second != null) {
//                                             return Text(
//                                               second.cargoItems[index].packingSizeMiddle.toString(),
//                                               style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 24,
//                                                 fontFamily: 'Roboto',
//                                                 fontStyle: FontStyle.normal,
//                                                 fontWeight: FontWeight.w700,
//                                               ),
//                                             );
//                                           } else {
//                                             return const Text('');
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                       top: 20,
//                                       bottom: 20,
//                                     ),
//                                     child: Center(
//                                       child: Builder(
//                                         builder: (context) {
//                                           final last = invoice.invoice;
//                                           if (last != null) {
//                                             return Text(
//                                               last.cargoItems[index].packingSizeLast.toString(),
//                                               style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 24,
//                                                 fontFamily: 'Roboto',
//                                                 fontStyle: FontStyle.normal,
//                                                 fontWeight: FontWeight.w700,
//                                               ),
//                                             );
//                                           } else {
//                                             return const Text('');
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                       top: 20,
//                                       bottom: 20,
//                                     ),
//                                     child: Center(
//                                       child: Builder(
//                                         builder: (context) {
//                                           final number = invoice.invoice;
//                                           if (number != null) {
//                                             return Text(
//                                               number.cargoItems[index].numberOfSeats.toString(),
//                                               style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 24,
//                                                 fontFamily: 'Roboto',
//                                                 fontStyle: FontStyle.normal,
//                                                 fontWeight: FontWeight.w700,
//                                               ),
//                                             );
//                                           } else {
//                                             return const Text('');
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                       top: 20,
//                                       bottom: 20,
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         invoice.invoice?.cargoItems[index].cube ?? '',
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 24,
//                                           fontFamily: 'Roboto',
//                                           fontStyle: FontStyle.normal,
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                       top: 20,
//                                       bottom: 20,
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         invoice.invoice?.cargoItems[index].kg ?? '',
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 24,
//                                           fontFamily: 'Roboto',
//                                           fontStyle: FontStyle.normal,
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                       top: 20,
//                                       bottom: 20,
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         invoice.invoice?.cargoItems[index].productName ?? '',
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 24,
//                                           fontFamily: 'Roboto',
//                                           fontStyle: FontStyle.normal,
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                       top: 20,
//                                       bottom: 20,
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         invoice.invoice?.cargoItems[index].price ?? '',
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 24,
//                                           fontFamily: 'Roboto',
//                                           fontStyle: FontStyle.normal,
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                       invoice.invoice?.consumptionPrice != null
//                           ? Table(
//                               border: TableBorder.all(
//                                 color: Colors.black,
//                                 width: 1,
//                               ),
//                               columnWidths: const {
//                                 0: FlexColumnWidth(3),
//                                 1: FlexColumnWidth(10),
//                                 2: FlexColumnWidth(2),
//                               },
//                               children: [
//                                 TableRow(
//                                   decoration: const BoxDecoration(),
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                         top: 20,
//                                         bottom: 20,
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           invoice.invoice?.consumptionName ?? '',
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 24,
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const Padding(
//                                       padding: EdgeInsets.only(
//                                         top: 20,
//                                         bottom: 20,
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           '',
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 24,
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                         top: 20,
//                                         bottom: 20,
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           invoice.invoice?.consumptionPrice.toString() ?? '',
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 24,
//                                             fontFamily: 'Roboto',
//                                             fontStyle: FontStyle.normal,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             )
//                           : Container(),
//                     ],
//                   ),
//                 ),
//               )
//             : const Center(child: CircularProgressIndicator()),
//       ),
//     );
//   }
// }
