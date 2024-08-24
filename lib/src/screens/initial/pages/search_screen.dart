import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kargo_app/src/screens/initial/pages/search_info.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../design/app_colors.dart';
import '../../../design/custom_icon.dart';
import '../../auth/login/login_screen.dart';
import '../../auth/register/register_screen.dart';
import '../model/search_model.dart';
import '../repository/search_repository.dart';
import '../repository/ticket_repository.dart';

class SearchScreen extends StatefulWidget {
  final FocusNode focusNode;
  const SearchScreen({required this.focusNode, super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  SearchModel? searchResult;
  bool isLoadingg = false;

  void performSearch(String query) async {
    isLoadingg = true;
    if (query.isEmpty) {
      setState(() {
        searchResult = null;
        isLoadingg = false;
      });
      return;
    }
    try {
      final results = await Provider.of<SearchProvider>(context, listen: false).seaching(query);
      setState(() {
        searchResult = results;
        isLoadingg = false;
      });
    } catch (error) {
      setState(() {
        const snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Failed to perform search',
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        isLoadingg = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (searchController.text.isEmpty) {
      FocusScope.of(context).requestFocus(widget.focusNode);
    }

    int t = 0;

    final int? l = searchResult?.points.length;
    if (searchResult?.points != null) {
      for (var i = 0; i < searchResult!.points.length; i++) {
        if (searchResult!.points[i].isCurrent != 0) {
          t = i;
        }
      }
    }

    var name = searchResult?.ticketCode;
    name = name?.replaceAll('', '\u200B');
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
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
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
            toolbarHeight: 50,
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    right: 0,
                    bottom: 10,
                  ),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 105,
                    decoration: BoxDecoration(
                      color: AppColors.searchColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22),
                          child: CustomIcon(
                            title: 'assets/icons/searchnormal1.svg',
                            height: 20,
                            width: 20,
                            color: AppColors.profilColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width - 200,
                            child: TextFormField(
                              controller: searchController,
                              focusNode: widget.focusNode,
                              // onChanged: performSearch,
                              onFieldSubmitted: performSearch,
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'search'.tr(),
                                hintStyle: const TextStyle(fontSize: 15),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('cancel'.tr()),
                ),
                // IconButton(
                //     padding: new EdgeInsets.all(0.0),
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                //     icon:
                //     Icon(
                //       Icons.arrow_back,
                //       size: 33,
                //       color: AppColors.profilColor,
                //     )),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: searchResult != null
            ? Selector<SearchProvider, bool>(
                selector: (context, search) => search.isLoading,
                builder: (_, isLoading, __) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: isLoading == true
                        ? const Center(
                            child: SpinKitFadingCircle(
                              color: Colors.grey,
                              size: 50.0,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.borderColor,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            height: MediaQuery.of(context).size.height / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width / 25,
                                    right: MediaQuery.of(context).size.width / 25,
                                    top: MediaQuery.of(context).size.width / 40,
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
                                                fontSize: MediaQuery.of(context).size.width / 26,
                                                fontFamily: 'Roboto',
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width / 2 - 70,
                                              child: Text(
                                                name ?? '',
                                                // maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: MediaQuery.of(context).size.width / 29,
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
                                        width: MediaQuery.of(context).size.width / 2 - 10,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            // Text(
                                            //   'transport_number'.tr(),
                                            //   // 'Maşyn №: ',
                                            //   style: TextStyle(
                                            //       color: Colors.black,
                                            //       fontSize: MediaQuery.of(context).size.width / 26,
                                            //       fontFamily: 'Roboto',
                                            //       fontStyle: FontStyle.normal,
                                            //       fontWeight: FontWeight.w400),
                                            // ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width / 2 - 10,
                                              child: Builder(
                                                builder: (context) {
                                                  final tripData = searchResult;
                                                  if (tripData != null) {
                                                    final trNumber = tripData.transportNumber;
                                                    return Text(
                                                      'transport_number'.tr() + trNumber,
                                                      // maxLines: 2,
                                                      softWrap: false,
                                                      textAlign: TextAlign.end,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: MediaQuery.of(
                                                              context,
                                                            ).size.width /
                                                            29,
                                                        fontFamily: 'Roboto',
                                                        fontStyle: FontStyle.normal,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    );
                                                  } else {
                                                    return const Text('');
                                                  }
                                                },
                                              ),
                                            ),
                                            // CustomIcon(
                                            //     title: 'assets/icons/gps.svg',
                                            //     height: 20,
                                            //     width: 20,
                                            //     color: AppColors.authTextColor),
                                            // const SizedBox(
                                            //   width: 3,
                                            // ),
                                            // Text(
                                            //   'gps'.tr(),
                                            //   style: const TextStyle(
                                            //       color: Colors.black,
                                            //       fontSize: 16,
                                            //       fontFamily: 'Roboto',
                                            //       fontStyle: FontStyle.normal,
                                            //       fontWeight: FontWeight.w400),
                                            // ),
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
                                      //     Text(
                                      //       searchResult?.summarySeats
                                      //               .toString() ??
                                      //           '',
                                      //       style: const TextStyle(
                                      //           color: Colors.black,
                                      //           fontSize: 16,
                                      //           fontFamily: 'Roboto',
                                      //           fontStyle: FontStyle.normal,
                                      //           fontWeight: FontWeight.w400),
                                      //     ),
                                      //   ],
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     CustomIcon(
                                      //         title: 'assets/icons/gps.svg',
                                      //         height: 20,
                                      //         width: 20,
                                      //         color: AppColors.authTextColor),
                                      //     const SizedBox(
                                      //       width: 3,
                                      //     ),
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
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    searchResult?.date ?? '',
                                                    style: TextStyle(
                                                      color: AppColors.authTextColor,
                                                      fontSize: MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          29,
                                                      fontFamily: 'Roboto',
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: deviceWidth / 6,
                                                    child: Text(
                                                      searchResult?.pointFrom ?? '',
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: MediaQuery.of(
                                                              context,
                                                            ).size.width /
                                                            26,
                                                        fontFamily: 'Roboto',
                                                        fontStyle: FontStyle.normal,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          2.5,
                                                    ),
                                                    child: Center(
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
                                                  ),
                                                ],
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
                                                child: Text(
                                                  textAlign: TextAlign.right,
                                                  searchResult?.pointTo ?? '',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(
                                                          context,
                                                        ).size.width /
                                                        26,
                                                    fontFamily: 'Roboto',
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                    bottom: 0,
                                  ),
                                  child: searchResult!.points.isNotEmpty
                                      ? SizedBox(
                                          height: MediaQuery.of(context).size.width / 10,
                                          // width: MediaQuery.of(context)
                                          //         .size
                                          //         .width -
                                          //     60,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: searchResult?.points.length,
                                                    scrollDirection: Axis.horizontal,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemBuilder: (con, index) {
                                                      // if () {
                                                      // t = index;
                                                      // }

                                                      if (searchResult?.points != null) {
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
                                                                          color: index <= t && t >= 0 ? AppColors.mainColor : Colors.grey,
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
                                                                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.mainColor.withOpacity(0.1)),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        height: deviceWidth / 14.5,
                                                                        width: deviceWidth / 14.5,
                                                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.mainColor),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(4.0),
                                                                          child: CustomIcon(
                                                                            title: t == 0
                                                                                ? 'assets/icons/home.svg'
                                                                                : t == searchResult!.points.length
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
                                                      } else {
                                                        return Container();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // : const Text('Fucking'),
                                        )
                                      : SizedBox(
                                          height: MediaQuery.of(context).size.width / 10,
                                          // width: MediaQuery.of(context)
                                          //         .size
                                          //         .width -
                                          //     40,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Center(
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
                                                                          width: MediaQuery.of(context).size.width / 9,
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
                                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.mainColor.withOpacity(0.1)),
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
                                        // width: MediaQuery.of(context).size.width /
                                        //         4 -
                                        //     30,
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
                                                fontSize: MediaQuery.of(context).size.width / 26,
                                                fontFamily: 'Roboto',
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 5,
                                              ),
                                              child: SizedBox(
                                                // width: MediaQuery.of(context).size.width / 4 - 25,
                                                child: Text(
                                                  searchResult?.summarySeats.toString() ?? '',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(
                                                          context,
                                                        ).size.width /
                                                        26,
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
                                                fontSize: MediaQuery.of(context).size.width / 26,
                                                fontFamily: 'Roboto',
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 5,
                                              ),
                                              child: Text(
                                                searchResult?.summaryCube.toString() ?? '',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: MediaQuery.of(context).size.width / 26,
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
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            // const Icon(Icons.attach_money, ),
                                            Text(
                                              'cost'.tr(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context).size.width / 26,
                                                fontFamily: 'Roboto',
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              textAlign: TextAlign.right,
                                              searchResult?.summaryPrice.toString() ?? '',
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
                                          searchResult?.danhaoCode.toString() ?? '',
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
                                              searchResult?.trackCode.toString() ?? '',
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
                                    left: MediaQuery.of(context).size.width / 50,
                                    right: MediaQuery.of(context).size.width / 50,
                                    top: 0,
                                    bottom: MediaQuery.of(context).size.width / 55,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            bottom: MediaQuery.of(context).size.width / 60,
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
                                              SizedBox(
                                                width: deviceWidth / 4,
                                                child: Text(
                                                  searchResult?.location ?? '',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: AppColors.mainColor,
                                                    fontSize: MediaQuery.of(
                                                          context,
                                                        ).size.width /
                                                        32,
                                                    fontFamily: 'Roboto',
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      searchResult?.isOwned == true
                                          ? GestureDetector(
                                              onTap: () async {
                                                final SharedPreferences preferences = await SharedPreferences.getInstance();
                                                final String? val = preferences.getString('token');

                                                if (val != null) {
                                                  await showDalogdOrder(
                                                    searchResult!.id,
                                                  );
                                                } else {
                                                  await showDalogdLogin();
                                                }

                                                // Navigator.of(context)
                                                //     .push(MaterialPageRoute(
                                                //         builder: (context) => SearchInfo(
                                                //               model: searchResult,
                                                //             )));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          55,
                                                      right: MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          55,
                                                      bottom: MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          55,
                                                      top: MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          55,
                                                    ),
                                                    child: Text(
                                                      'add_order'.tr(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                              context,
                                                            ).size.width /
                                                            33,
                                                        fontFamily: 'Roboto',
                                                        fontStyle: FontStyle.normal,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => SearchInfo(
                                                model: searchResult,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 3,
                                            bottom: 3,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.mainColor,
                                              borderRadius: BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.width / 55,
                                                right: MediaQuery.of(context).size.width / 55,
                                                bottom: MediaQuery.of(context).size.width / 55,
                                                top: MediaQuery.of(context).size.width / 55,
                                              ),
                                              child: Text(
                                                'more_info'.tr(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: MediaQuery.of(context).size.width / 33,
                                                  fontFamily: 'Roboto',
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w600,
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
                },
              )
            : Center(
                child: Lottie.asset(
                  'assets/icons/search.json',
                  width: MediaQuery.of(context).size.width - 100,
                  height: 230,
                  fit: BoxFit.fill,
                ),
              ),
      ),
    );
  }

  Future showDalogdOrder(int id) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'add_order_permision'.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          await TicketsRepository().tickedId(context, id);
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Text(
                              'yes'.tr(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 3 - 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text(
                                'no'.tr(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
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
      },
    );
  }

  Future showDalogdLogin() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Icon(
                    Icons.info_sharp,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'add_order_alart'.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    left: 15,
                    right: 15,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Text(
                              'login'.tr(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 3 - 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                              child: Text(
                                'create_account'.tr(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
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
      },
    );
  }
}
