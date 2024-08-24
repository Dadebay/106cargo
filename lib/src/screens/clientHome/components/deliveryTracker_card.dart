// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names, non_constant_identifier_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kargo_app/src/design/app_colors.dart';
import 'package:kargo_app/src/screens/auth/components/custom_text_fild.dart';
import 'package:kargo_app/src/screens/clientHome/components/custom_button.dart';
import 'package:kargo_app/src/screens/clientHome/components/numberStepper.dart';
import 'package:kargo_app/src/screens/clientHome/data/models/getOneOrder_model.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/region_service.dart';

import '../../initial/model/order_by_id_model.dart';
import '../info_order_mine.dart';

class DeliveryTrackerCard extends StatelessWidget {
  final AsyncSnapshot<List<Datum>> snapshot;
  final int index;
  const DeliveryTrackerCard({
    required this.snapshot,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int currentStepIndex = snapshot.data![index].points!.indexWhere((point) => point.isCurrent == 1);
    final int curStep = (currentStepIndex == -1 ? 1 : currentStepIndex + 1).clamp(1, snapshot.data![index].points!.length + 1);
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(20).copyWith(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grey5Color),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.4),
            offset: const Offset(3, 3),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ID and car number
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'ID: ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: snapshot.data![index].ticketCode.toString(),
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Maşyn №',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: snapshot.data![index].transportNumber ?? '',
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Date
          Text(
            snapshot.data![index].date ?? '',
            style: const TextStyle(
              color: AppColors.lightBlueColor,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          // Transport and location
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                snapshot.data![index].pointFrom ?? '',
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () {},
                iconSize: 20,
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.grey4Color),
                ),
                icon: SvgPicture.asset('assets/icons/arrow_right.svg'),
              ),
              Text(
                snapshot.data![index].pointTo ?? '',
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          // Number stepper
          NumberStepper(
            totalSteps: snapshot.data![index].points!.length,
            width: MediaQuery.of(context).size.width,
            curStep: curStep,
            stepCompleteColor: AppColors.blueColor,
            currentStepColor: const Color(0xffdbecff),
            inactiveColor: AppColors.grey3Color,
            lineWidth: 3.5,
          ),
          // Summary details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Ýer: ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: snapshot.data![index].summarySeats.toString(),
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Kub: ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    snapshot.data![index].summaryCube.toString(),
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Baha: ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    snapshot.data![index].summaryPrice.toString(),
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: deviceWidth / 100,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    snapshot.data![index].danhaoCode.toString() == 'null' ? '' : snapshot.data![index].danhaoCode.toString(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  snapshot.data![index].trackCode.toString() == 'null' ? '' : snapshot.data![index].trackCode.toString(),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Current location and custom button
          if (currentStepIndex != -1)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/map_pin.svg',
                        color: AppColors.blueColor,
                      ),
                      Expanded(
                        child: Text(
                          snapshot.data![index].points![currentStepIndex].point.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.blueColor,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
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
                          showPayOneCargo(context, snapshot.data![index].summaryPrice.toString(), snapshot.data![index].id.toString());
                        },
                        child: Container(
                          height: 36,
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
                        backColor: Colors.white,
                        textColor: AppColors.blueColor,
                        onTap: () {
                          final TripDataIdModel model = TripDataIdModel.fromJson(snapshot.data![index].toJson());
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => InfoOrderMine(
                                orderInfo: model,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
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
}
