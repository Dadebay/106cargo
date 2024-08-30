import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:kargo_app/src/screens/auth/components/custom_text_fild.dart';
import 'package:kargo_app/src/screens/clientHome/clientHome_controller.dart';
import 'package:kargo_app/src/screens/clientHome/components/custom_button.dart';
import 'package:kargo_app/src/screens/clientHome/data/models/getOneOrder_model.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/getOneOrder_service.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/region_service.dart';
import 'package:kargo_app/src/screens/clientHome/info_order_mine.dart';
import 'package:kargo_app/src/screens/initial/model/order_by_id_model.dart';

import '../../../design/app_colors.dart';
import '../../../design/custom_icon.dart';
import '../model/orders_model.dart';

class CartMain extends StatefulWidget {
  final TripModel model;

  const CartMain({required this.model, super.key});

  @override
  State<CartMain> createState() => _CartMainState();
}

class _CartMainState extends State<CartMain> {
  @override
  Widget build(BuildContext context) {
    int t = 0;
    final int l = widget.model.points!.length;
    if (widget.model.points != null) {
      for (var i = 0; i < widget.model.points!.length; i++) {
        if (widget.model.points?[i].isCurrent != 0) {
          t = i;
        }
      }
    }

    var name = widget.model.ticketCode;
    var trNumber2 = widget.model.transportNumber;
    name = name.replaceAll('', '\u200B');
    trNumber2 = trNumber2.replaceAll('', '\u200B');

    final double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      margin: const EdgeInsets.only(top: 8),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          idPart(context, name, trNumber2),
          senePart(deviceWidth, context),
          trackWidget(deviceWidth, context, t, l),
          placeCubePrice(deviceWidth, context),
          trackCode(context),
          locationPart(context),
        ],
      ),
    );
  }

  Widget locationPart(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
              Expanded(
                child: Text(
                  widget.model.location,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: MediaQuery.of(context).size.width / 32,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  showPayOneCargo(context, widget.model.summaryPrice.toString(), widget.model.id.toString());
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: AppColors.blueColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: const Text(
                    'Töle',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              CustomButton(
                mini: true,
                backColor: Colors.white,
                textColor: AppColors.blueColor,
                onTap: () {
                  final List<PointSS> points = [];
                  widget.model.points?.forEach((element) {
                    points.add(PointSS(point: element.point ?? '', isCurrent: element.isCurrent ?? 0, date: element.date ?? ''));
                  });
                  final TripDataIdModel modell = TripDataIdModel(
                    id: widget.model.id,
                    summaryPrice: widget.model.summaryPrice,
                    ticketCode: widget.model.ticketCode,
                    location: widget.model.location,
                    date: widget.model.date,
                    summaryKg: widget.model.summaryKg,
                    summaryCube: widget.model.summaryCube,
                    summarySeats: widget.model.summarySeats,
                    trackCode: widget.model.trackCode,
                    danhaoCode: widget.model.danhaoCode,
                    pointFrom: widget.model.pointFrom,
                    pointTo: widget.model.pointTo,
                    transport_number: widget.model.transportNumber,
                    points: points,
                    images: widget.model.images!,
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => InfoOrderMine(
                        orderInfo: modell,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row trackCode(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.model.danhaoCode.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width / 26,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
          widget.model.trackCode.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width / 26,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget textMine(String text1, String text2) {
    return Row(
      children: [
        Text(
          text1,
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width / 26,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          child: Text(
            text2,
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
    );
  }

  Widget placeCubePrice(double deviceWidth, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textMine('place'.tr(), widget.model.summarySeats.toString()),
        textMine('cub'.tr(), widget.model.summaryCube.toString()),
        textMine('cost'.tr(), widget.model.summaryPrice.toString()),
      ],
    );
  }

  Widget trackWidget(double deviceWidth, BuildContext context, int t, int l) {
    if (widget.model.points!.isNotEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.width / 10,
        child: ListView.builder(
          itemCount: widget.model.points?.length,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (con, index) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: index == 0 ? false : true,
                  child: FittedBox(
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
                            width: MediaQuery.of(context).size.width / 10,
                            color: index <= t && t >= 0 ? AppColors.mainColor : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                index != t
                    ? Container(
                        height: deviceWidth / 38,
                        width: deviceWidth / 37,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index <= t && t >= 0 ? AppColors.mainColor : Colors.grey,
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.mainColor.withOpacity(0.1),
                        ),
                        child: Container(
                          height: deviceWidth / 14.5,
                          width: deviceWidth / 14.5,
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.mainColor,
                          ),
                          child: CustomIcon(
                            title: t == 0
                                ? 'assets/icons/home.svg'
                                : t == l - 1
                                    ? 'assets/icons/check_circle.svg'
                                    : 'assets/icons/truck_delivery.svg',
                            height: deviceWidth / 40,
                            width: deviceWidth / 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      );
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.width / 10,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                        width: deviceWidth / 10,
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
                                width: deviceWidth / 45,
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
                                      padding: const EdgeInsets.all(
                                        5.0,
                                      ),
                                      child: CustomIcon(
                                        title: t == 0
                                            ? 'assets/icons/home.svg'
                                            : t == l - 1
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
      );
    }
  }

  Widget senePart(double deviceWidth, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.model.date,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.authTextColor,
                fontSize: MediaQuery.of(context).size.width / 29,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: deviceWidth / 5.9,
              child: Text(
                widget.model.pointFrom,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width / 26,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 35,
          width: 35,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.mainColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: CustomIcon(
            title: 'assets/icons/arrow_right.svg',
            height: 20,
            width: 20,
            color: AppColors.mainColor,
          ),
        ),
        Text(
          widget.model.pointTo,
          maxLines: 1,
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width / 26,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Future showPayOneCargo(BuildContext context, String text, String ID) async {
    final TextEditingController controller = TextEditingController();
    controller.text = text;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Tölegi tassykläň',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomTextFild(hint: '', controller: controller),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.redColor,
                        ),
                        child: const Center(
                          child: Text(
                            'Ýap',
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        final instance = RegionService();
                        await instance.payOneCargoPOST(id: ID, amount: controller.text);
                        final ClientHomeController clientHomeController = Get.put(ClientHomeController());
                        print(clientHomeController.showOrderIDList);
                        clientHomeController.showOrderIDList.clear();

                        await GetOneOrderService().fetchOneOrderFromFilter(userId: clientHomeController.userId.value.toString(), ticketID: [], controller: '', controller1: '').then((a) {
                          print(a);
                          final List<Datum> list = a;

                          clientHomeController.showOrderIDList.addAll(list);
                        });
                        print(clientHomeController.showOrderIDList);

                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.mainColor,
                        ),
                        child: const Center(
                          child: Text(
                            'Tassykla',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
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
        );
      },
    );
  }

  Widget idPart(BuildContext context, String name, String trNumber2) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
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
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
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
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'transport_number'.tr() + trNumber2,
                  softWrap: false,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width / 29,
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
    );
  }
}
