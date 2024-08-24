import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kargo_app/src/screens/initial/model/search_model.dart';
import 'package:kargo_app/src/screens/initial/pages/invoice_new.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../design/app_colors.dart';
import '../../../design/custom_icon.dart';

// ignore: must_be_immutable
class SearchInfo extends StatefulWidget {
  SearchModel? model;
  SearchInfo({required this.model, super.key});

  @override
  State<SearchInfo> createState() => _SearchInfoState();
}

class _SearchInfoState extends State<SearchInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int t = 0;

    final int? l = widget.model?.points.length;
    if (widget.model?.points != null) {
      for (var i = 0; i < widget.model!.points.length; i++) {
        if (widget.model?.points[i].isCurrent != 0) {
          t = i;
        }
      }
    }

    final double deviceWidth = MediaQuery.of(context).size.width;
    var name = widget.model?.ticketCode;
    name = name?.replaceAll('', '\u200B');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 70,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: AppColors.profilColor, size: 30),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            title: Text(
              'order_info'.tr(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.borderColor, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height / 3.2,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: deviceWidth / 25,
                          right: deviceWidth / 25,
                          top: deviceWidth / 30,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2 - 40,
                              child: Row(
                                children: [
                                  Text(
                                    'id'.tr(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: deviceWidth / 26,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      final tripData = widget.model;
                                      if (tripData != null) {
                                        return SizedBox(
                                          width: MediaQuery.of(context).size.width / 2 - 70,
                                          child: Text(
                                            name.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: deviceWidth / 29,
                                              fontFamily: 'Roboto',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const Text('Null');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child: Row(
                                children: [
                                  Builder(
                                    builder: (context) {
                                      final tripData = widget.model;
                                      if (tripData != null) {
                                        var trNumber = tripData.transportNumber;
                                        trNumber = trNumber.replaceAll('', '\u200B');
                                        return SizedBox(
                                          width: MediaQuery.of(context).size.width / 2 - 10,
                                          child: Text(
                                            'transport_number'.tr() + trNumber,
                                            softWrap: false,
                                            textAlign: TextAlign.end,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: deviceWidth / 29,
                                              fontFamily: 'Roboto',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const Text('Null');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),

                            // Row(
                            //   children: [
                            //     CustomIcon(
                            //         title: 'assets/icons/boxh.svg',
                            //         height: 20,
                            //         width: 20,
                            //         color: AppColors.authTextColor),
                            //     Text(
                            //       'box'.trs,
                            //       style: const TextStyle(
                            //           color: Colors.black,
                            //           fontSize: 16,
                            //           fontFamily: 'Roboto',
                            //           fontStyle: FontStyle.normal,
                            //           fontWeight: FontWeight.w400),
                            //     ),
                            //     Builder(builder: (context) {
                            //       final ordersId = widget.model;
                            //       if (ordersId != null) {
                            //         return Text(
                            //           ordersId.summarySeats.toString(),
                            //           style: const TextStyle(
                            //               color: Colors.black,
                            //               fontSize: 16,
                            //               fontFamily: 'Roboto',
                            //               fontStyle: FontStyle.normal,
                            //               fontWeight: FontWeight.w400),
                            //         );
                            //       }
                            //       {
                            //         return const Text('NULL');
                            //       }
                            //     }),
                            //   ],
                            // ),
                            // Row(
                            //   children: [
                            //     CustomIcon(
                            //         title: 'assets/icons/gps.svg',
                            //         height: 20,
                            //         width: 20,
                            //         color: AppColors.authTextColor),
                            //     Text(
                            //       'gps'.trs,
                            //       style: const TextStyle(
                            //           color: Colors.black,
                            //           fontSize: 16,
                            //           fontFamily: 'Roboto',
                            //           fontStyle: FontStyle.normal,
                            //           fontWeight: FontWeight.w400),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: deviceWidth / 26 - 1,
                          right: deviceWidth / 26 - 1,
                          top: deviceWidth / 50,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        final ordersDate = widget.model;
                                        if (ordersDate != null) {
                                          return Text(
                                            ordersDate.date,
                                            style: TextStyle(
                                              color: AppColors.authTextColor,
                                              fontSize: deviceWidth / 26,
                                              fontFamily: 'Roboto',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          );
                                        } else {
                                          return const Text('Null');
                                        }
                                      },
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final ponitForms = widget.model;
                                        if (ponitForms != null) {
                                          return Text(
                                            ponitForms.pointFrom,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: deviceWidth / 26,
                                              fontFamily: 'Roboto',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        } else {
                                          return const Text('Null');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width / 2.5,
                                  ),
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                      color: AppColors.searchColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CustomIcon(
                                        title: 'assets/icons/arrow_right.svg',
                                        height: 20,
                                        width: 20,
                                        color: AppColors.authTextColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: deviceWidth / 22,
                                ),
                                SizedBox(
                                  width: 80,
                                  child: Builder(
                                    builder: (context) {
                                      final pointsTo = widget.model;
                                      if (pointsTo != null) {
                                        return Text(
                                          pointsTo.pointTo,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        );
                                      } else {
                                        return const Text('Null');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: deviceWidth / 26 - 1,
                          right: deviceWidth / 26 - 1,
                          top: 0,
                        ),
                        child: widget.model!.points.isNotEmpty
                            ? SizedBox(
                                height: 40,
                                // width: MediaQuery.of(context).size.width - 50,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Builder(
                                          builder: (context) {
                                            final pointsL = widget.model;
                                            if (pointsL != null) {
                                              return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: pointsL.points.length,
                                                scrollDirection: Axis.horizontal,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (con, index) {
                                                  // setState(() {
                                                  //   orderById.loc;
                                                  // });
                                                  return Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Visibility(
                                                        visible: index == 0 ? false : true,
                                                        child: Row(
                                                          children: [
                                                            Row(
                                                              children: List.generate(
                                                                1,
                                                                (ii) => Padding(
                                                                  padding: EdgeInsets.only(
                                                                    left: deviceWidth / 120,
                                                                    right: deviceWidth / 120,
                                                                    top: deviceWidth / 80,
                                                                    bottom: deviceWidth / 100,
                                                                  ),
                                                                  child: Container(
                                                                    height: 2.5,
                                                                    width: MediaQuery.of(context).size.width / 9,
                                                                    color: index <= t ? AppColors.mainColor : Colors.grey,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      index != t
                                                          ? Container(
                                                              height: deviceWidth / 38,
                                                              width: deviceWidth / 38,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                color: index < t ? AppColors.mainColor : Colors.grey,
                                                              ),
                                                            )
                                                          : Stack(
                                                              alignment: Alignment.center,
                                                              children: [
                                                                Center(
                                                                  child: Container(
                                                                    height: deviceWidth / 11,
                                                                    width: deviceWidth / 11,
                                                                    decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: AppColors.mainColor.withOpacity(0.1),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: deviceWidth / 14.5,
                                                                  width: deviceWidth / 14.5,
                                                                  decoration: const BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: AppColors.mainColor,
                                                                  ),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(
                                                                      4.0,
                                                                    ),
                                                                    child: CustomIcon(
                                                                      title: t == 0
                                                                          ? 'assets/icons/home.svg'
                                                                          : t == pointsL.points.length
                                                                              ? 'assets/icons/check_circle.svg'
                                                                              : 'assets/icons/truck_delivery.svg',
                                                                      height: deviceWidth / 40,
                                                                      width: deviceWidth / 40,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              return const SpinKitFadingCircle(
                                                color: Colors.grey,
                                                size: 50.0,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                height: deviceWidth / 10,
                                // width: MediaQuery.of(context).size.width - 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 0,
                                            right: 0,
                                            top: 3,
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 6,
                                            scrollDirection: Axis.horizontal,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (con, index) {
                                              return Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Visibility(
                                                    visible: index == 0 ? false : true,
                                                    child: Row(
                                                      children: [
                                                        FittedBox(
                                                          child: Row(
                                                            children: List.generate(
                                                              1,
                                                              (ii) => Padding(
                                                                padding: EdgeInsets.only(
                                                                  left: deviceWidth / 120,
                                                                  right: deviceWidth / 120,
                                                                  top: deviceWidth / 80,
                                                                  bottom: deviceWidth / 100,
                                                                ),
                                                                child: Container(
                                                                  height: 2.5,
                                                                  width: MediaQuery.of(
                                                                        context,
                                                                      ).size.width /
                                                                      9,
                                                                  color: index <= t && t >= 0 ? AppColors.mainColor : Colors.grey,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  index != t
                                                      ? Container(
                                                          height: deviceWidth / 38,
                                                          width: deviceWidth / 38,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: index <= t && t >= 0 ? AppColors.mainColor : Colors.grey,
                                                          ),
                                                        )
                                                      : Stack(
                                                          alignment: Alignment.center,
                                                          children: [
                                                            Center(
                                                              child: Container(
                                                                height: deviceWidth / 11,
                                                                width: deviceWidth / 11,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: AppColors.mainColor.withOpacity(
                                                                    0.1,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: deviceWidth / 14.5,
                                                              width: deviceWidth / 14.5,
                                                              decoration: const BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                color: AppColors.mainColor,
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(4.0),
                                                                child: CustomIcon(
                                                                  title: t == 0
                                                                      ? 'assets/icons/home.svg'
                                                                      : t == l! - 1
                                                                          ? 'assets/icons/check_circle.svg'
                                                                          : 'assets/icons/truck_delivery.svg',
                                                                  height: deviceWidth / 40,
                                                                  width: deviceWidth / 40,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: deviceWidth / 26 - 1,
                          right: deviceWidth / 26 - 1,
                          top: 7,
                          bottom: deviceWidth / 40,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              // width: MediaQuery.of(context).size.width / 4 - 30,
                              child: Row(
                                children: [
                                  // CustomIcon(
                                  //     title: 'assets/icons/boxh.svg',
                                  //     height: 20,
                                  //     width: 20,
                                  //     color: Colors.black),
                                  Text(
                                    'place'.tr(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: deviceWidth / 26,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: SizedBox(
                                      // width: MediaQuery.of(context).size.width / 4 - 25,
                                      child: Text(
                                        widget.model?.summarySeats.toString() ?? '',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: deviceWidth / 26,
                                          fontFamily: 'Roboto',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width / 4 - 25,
                            //   child: Row(
                            //     children: [
                            //       SizedBox(
                            //           height: 24,
                            //           width: 25,
                            //           child: Image.asset('assets/images/kg.png')),
                            //       Padding(
                            //         padding: const EdgeInsets.only(left: 5),
                            //         child: Text(
                            //           widget.model.summaryKg.toString(),
                            //           style: const TextStyle(
                            //               color: Colors.black,
                            //               fontSize: 16,
                            //               fontFamily: 'Roboto',
                            //               fontStyle: FontStyle.normal,
                            //               fontWeight: FontWeight.w400),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              // width: MediaQuery.of(context).size.width / 4,
                              child: Row(
                                children: [
                                  // SizedBox(
                                  //     height: 22,
                                  //     width: 22,
                                  //     child: Image.asset('assets/images/cube_new.png')),
                                  Text(
                                    'cub'.tr(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: deviceWidth / 26,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      widget.model?.summaryCube.toString() ?? '',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: deviceWidth / 26,
                                        fontFamily: 'Roboto',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // width: MediaQuery.of(context).size.width / 4,
                              child: Row(
                                children: [
                                  // const Icon(Icons.attach_money, ),
                                  Text(
                                    'cost'.tr(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: deviceWidth / 26,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    widget.model?.summaryPrice.toString() ?? '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: deviceWidth / 26,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: deviceWidth / 26 - 1,
                          right: deviceWidth / 26 - 1,
                          bottom: deviceWidth / 100,
                        ),
                        child: SizedBox(
                          // width: MediaQuery.of(context).size.width / 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.model?.danhaoCode.toString() ?? '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.width / 26,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // const Icon(Icons.attach_money, ),
                                  // Text(
                                  //   'Getiriji kod: ',
                                  //   style: TextStyle(
                                  //       color: Colors.black,
                                  //       fontSize: MediaQuery.of(context).size.width / 26,
                                  //       fontFamily: 'Roboto',
                                  //       fontStyle: FontStyle.normal,
                                  //       fontWeight: FontWeight.w400),
                                  // ),
                                  Text(
                                    widget.model?.trackCode.toString() ?? '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: MediaQuery.of(context).size.width / 26,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: deviceWidth / 50,
                          right: deviceWidth / 50,
                          top: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // color: AppColors.initialButtonColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 65,
                                  top: MediaQuery.of(context).size.width / 60,
                                  bottom: MediaQuery.of(context).size.width / 40,
                                  right: MediaQuery.of(context).size.width / 60,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomIcon(
                                      title: 'assets/icons/map_pin.svg',
                                      height: 18,
                                      width: 18,
                                      color: AppColors.mainColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final locations = widget.model;
                                        if (locations != null) {
                                          return Text(
                                            locations.location,
                                            style: const TextStyle(
                                              color: AppColors.mainColor,
                                              fontSize: 12,
                                              fontFamily: 'Roboto',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        } else {
                                          return const Text('Null');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 5,
                  right: 5,
                ),
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width - 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.borderColor, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Builder(
                      builder: (context) {
                        final imagesL = widget.model;
                        if (imagesL != null) {
                          return ListView.builder(
                            shrinkWrap: true,
                            // physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: imagesL.images?.length,
                            itemBuilder: (BuildContext context, int indexx) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: MediaQuery.of(context).size.height,
                                        child: PhotoViewGallery.builder(
                                          itemCount: widget.model!.images?.length,
                                          loadingBuilder: (context, event) {
                                            return const Center(
                                              child: SizedBox(
                                                width: 20.0,
                                                height: 20.0,
                                                child: SpinKitFadingCircle(
                                                  color: Colors.grey,
                                                  size: 50.0,
                                                ),
                                              ),
                                            );
                                          },
                                          builder: (
                                            BuildContext context,
                                            int index,
                                          ) {
                                            return PhotoViewGalleryPageOptions(
                                              imageProvider: CachedNetworkImageProvider(
                                                imagesL.images?[index] ?? '',
                                              ),
                                              // imageProvider: NetworkImage(
                                              // orderById.ordersById!
                                              //     .images[index]),
                                              minScale: PhotoViewComputedScale.contained * 0.8,
                                              maxScale: PhotoViewComputedScale.covered * 2,
                                            );
                                          },
                                          scrollPhysics: const BouncingScrollPhysics(),
                                          backgroundDecoration: const BoxDecoration(
                                            color: Colors.black,
                                          ),
                                          onPageChanged: (int index) {
                                            setState(() {
                                              index = indexx;
                                            });
                                          },
                                          pageController: PageController(
                                            initialPage: indexx,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                    right: 5,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                        imagesL.images?[indexx] ?? '',
                                        fit: BoxFit.cover,
                                        // loadingBuilder: (context, child,
                                        //         loadingProgress) =>
                                        //     const SpinKitCircle(
                                        //   color: AppColors.mainColor,
                                        //   size: 50,
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Text('Null');
                        }
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.borderColor, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10, bottom: 20),
                        child: Text(
                          'track_order'.tr(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        child: SizedBox(
                          child: Builder(
                            builder: (context) {
                              final poitss = widget.model;
                              if (poitss != null) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: poitss.points.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (con, index) {
                                    return Stack(
                                      children: [
                                        Row(
                                          children: [
                                            Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                    left: 15,
                                                    bottom: 0,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        widget.model?.points[index].date.toString() ?? '',
                                                        // '12.03.2333',
                                                        style: TextStyle(
                                                          color: index > t ? AppColors.authTextColor : AppColors.mainColor,
                                                          fontSize: 14,
                                                          fontFamily: 'Montserrat',
                                                          fontStyle: FontStyle.normal,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          CustomIcon(
                                                            title: 'assets/icons/truck_delivery.svg',
                                                            height: 24,
                                                            width: 24,
                                                            color: index > t ? AppColors.authTextColor : AppColors.mainColor,
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 5),
                                                            child: Text(
                                                              widget.model!.points[index].point,
                                                              style: TextStyle(
                                                                color: index > t ? Colors.black : AppColors.mainColor,
                                                                fontSize: 16,
                                                                fontFamily: 'Montserrat',
                                                                fontStyle: FontStyle.normal,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 2.5,
                                            right: 10,
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 12,
                                                width: 12,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: index <= t ? AppColors.mainColor : Colors.grey,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 15,
                                                ),
                                                child: Visibility(
                                                  visible: index == widget.model!.points.length - 1 ? false : true,
                                                  child: Column(
                                                    children: List.generate(
                                                      5,
                                                      (ii) => Padding(
                                                        padding: const EdgeInsets.only(
                                                          left: 4,
                                                          right: 5,
                                                          top: 0,
                                                          bottom: 3,
                                                        ),
                                                        child: Container(
                                                          height: 6,
                                                          width: 3,
                                                          color: index < t ? AppColors.mainColor : Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: SpinKitFadingCircle(
                                    color: Colors.grey,
                                    size: 50.0,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => const Invoice()));
                  //   },
                  //   child: Container(
                  //     height: 50,
                  //     width: MediaQuery.of(context).size.width / 2 - 25,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: AppColors.mainColor.withOpacity(0.1)),
                  //     child: Center(
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           CustomIcon(
                  //             title: 'assets/icons/image.svg',
                  //             height: 22,
                  //             width: 22,
                  //             color: AppColors.mainColor,
                  //           ),
                  //           const Padding(
                  //             padding: EdgeInsets.only(left: 5),
                  //             child: Text(
                  //               'Harydyň suraty',
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                   color: AppColors.mainColor,
                  //                   fontSize: 16,
                  //                   fontFamily: 'Roboto',
                  //                   fontStyle: FontStyle.normal,
                  //                   fontWeight: FontWeight.w500),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => InvoiceNew(
                              id: widget.model!.id,
                            ),
                            // Invoice(
                            //       id: widget.id,
                            //     )
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2 - 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.mainColor,
                        ),
                        child: Center(
                          child: Text(
                            'invoice'.tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
