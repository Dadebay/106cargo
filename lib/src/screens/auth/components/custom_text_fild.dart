// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: always_declare_return_types, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:kargo_app/src/screens/clientHome/data/models/getOneOrder_model.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/getOneOrder_service.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/region_service.dart';
import 'package:kargo_app/src/screens/custom_widgets/widgets.dart';

import '../../../design/app_colors.dart';
import '../../clientHome/clientHome_controller.dart';

// ignore: must_be_immutable
class CustomTextFild extends StatelessWidget {
  String hint;
  TextEditingController controller;
  CustomTextFild({required this.hint, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.textFildColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Center(
          child: TextFormField(
            controller: controller,
            maxLines: 1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColors.authTextColor,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFildWithText extends StatelessWidget {
  String hint;
  String text;
  Function() onTap;
  bool showOnTap;
  TextEditingController controller;
  CustomTextFildWithText({
    required this.hint,
    required this.text,
    required this.onTap,
    required this.showOnTap,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 5),
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.blackColor,
              fontSize: 18,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.textFildColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: TextFormField(
              onTap: showOnTap == true ? onTap : null,
              controller: controller,
              maxLines: 1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                  color: AppColors.authTextColor,
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
    );
  }
}

class CustomTextFildMINE extends StatefulWidget {
  const CustomTextFildMINE({required this.tickedID, super.key});
  final String tickedID;
  @override
  State<CustomTextFildMINE> createState() => _CustomTextFildMINEState();
}

class _CustomTextFildMINEState extends State<CustomTextFildMINE> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  final ClientHomeController clientHomeController = Get.put(ClientHomeController());

  Timer? searchOnStoppedTyping;

  _onChangeHandler(value) {
    const duration = Duration(milliseconds: 800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTyping = Timer(duration, () => search(value)));
  }

  search(value) async {
    if (controller.text.isNotEmpty && controller1.text.isNotEmpty) {
      clientHomeController.showOrderIDList.clear();
      await GetOneOrderService().fetchOneOrderFromFilter(userId: clientHomeController.userId.value, ticketID: widget.tickedID, controller: controller.text, controller1: controller1.text).then((a) {
        final List<Datum> list = a;
        clientHomeController.showOrderIDList.addAll(list);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.textFildColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: controller,
              onChanged: _onChangeHandler,
              maxLines: 1,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: -2),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Ulag No',
                hintStyle: TextStyle(
                  color: AppColors.authTextColor,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.textFildColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              onChanged: _onChangeHandler,
              controller: controller1,
              maxLines: 1,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: -2),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Ulag No',
                hintStyle: TextStyle(
                  color: AppColors.authTextColor,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              // showPayOneCargo(context, snapshot.data![index].summaryPrice.toString(), snapshot.data![index].id.toString());
              await showManyPayCargo(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.blueColor,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: const Text(
                'Töle',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future showManyPayCargo(BuildContext context) async {
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
                        if (widget.tickedID == '') {
                          showSnackBar('Ýalňyşlyk', 'ID saýlaň', Colors.red);
                        } else {
                          if (controller.text.isNotEmpty && controller1.text.isNotEmpty) {
                            final String oneOrderUrl = 'ticket_id=${widget.tickedID}&from_transport_id=${controller.text}&to_transport_id=${controller1.text}&per_page=50&page=1';

                            final instance = RegionService();
                            await instance.payManyCargoPOST(id: clientHomeController.userId.value, urlParams: oneOrderUrl);
                          }
                        }
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
