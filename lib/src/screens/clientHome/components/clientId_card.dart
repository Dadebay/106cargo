// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:kargo_app/src/design/app_colors.dart';
import 'package:kargo_app/src/screens/clientHome/clientHome_controller.dart';
import 'package:kargo_app/src/screens/clientHome/components/custom_button.dart';
import 'package:kargo_app/src/screens/clientHome/data/models/getOneOrder_model.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/getOneOrder_service.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/region_service.dart';
import 'package:kargo_app/src/screens/custom_widgets/widgets.dart';

class ClientIdCard extends StatefulWidget {
  final User user;
  const ClientIdCard({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<ClientIdCard> createState() => _ClientIdCardState();
}

class _ClientIdCardState extends State<ClientIdCard> with AutomaticKeepAliveClientMixin {
  final ClientHomeController clientHomeController = Get.put(ClientHomeController());
  String tickedIDMine = '';
  @override
  bool get wantKeepAlive => true;
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();

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
      await GetOneOrderService().fetchOneOrderFromFilter(userId: clientHomeController.userId.value, ticketID: selectedIndices, controller: controller.text, controller1: controller1.text).then((a) {
        final List<Datum> list = a;
        clientHomeController.showOrderIDList.addAll(list);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.grey5Color),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.4),
            offset: const Offset(3, 3),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width / 2.2,
                child: Text(
                  widget.user.userName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Obx(() {
                return Text(
                  clientHomeController.totalDebt.value == '' ? '${widget.user.totalDebt}' : clientHomeController.totalDebt.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.redColor,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                );
              }),
            ],
          ),
          idShowingField(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: clientTextField(),
          ),
          Center(
            child: CustomButton(
              onTap: () {
                FlutterPhoneDirectCaller.callNumber(
                  '+993${widget.user.phone}',
                );
              },
              withIcon: true,
              backColor: AppColors.lightBlue1Color,
              textColor: AppColors.blueColor,
            ),
          ),
        ],
      ),
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
                        if (tickedIDMine == '') {
                          showSnackBar('Ýalňyşlyk', 'ID saýlaň', Colors.red);
                        } else {
                          if (controller.text.isNotEmpty && controller1.text.isNotEmpty) {
                            final String oneOrderUrl = 'ticket_id=$selectedIndices&from_transport_id=${controller.text}&to_transport_id=${controller1.text}&per_page=50&page=1';
                            print(oneOrderUrl);
                            final instance = RegionService();
                            await instance.payManyCargoPOST(id: clientHomeController.userId.value, urlParams: oneOrderUrl).then((e) async {
                              clientHomeController.loadingOrders.value = 0;
                              clientHomeController.showOrderIDList.clear();
                              await GetOneOrderService()
                                  .fetchOneOrderFromFilter(userId: clientHomeController.userId.value, ticketID: selectedIndices, controller: controller.text, controller1: controller1.text)
                                  .then((a) {
                                final List<Datum> list = a;
                                clientHomeController.showOrderIDList.addAll(list);
                              });
                            });
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

  final List<int> selectedIndices = [];
  Widget clientTextField() {
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
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: const Text(
                'Töle',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget idShowingField() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.user.tickets!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 4 / 1.4,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () async {
          final int indexMine = int.parse(widget.user.tickets![index].id.toString());
          if (selectedIndices.contains(indexMine)) {
            selectedIndices.remove(indexMine);
          } else {
            selectedIndices.add(indexMine);
            tickedIDMine = widget.user.tickets![index].id.toString();
          }
          clientHomeController.showOrderIDList.clear();
          await GetOneOrderService()
              .fetchOneOrderFromFilter(userId: clientHomeController.userId.value, ticketID: selectedIndices, controller: controller.text, controller1: controller1.text)
              .then((a) {
            final List<Datum> list = a;
            clientHomeController.showOrderIDList.addAll(list);
          });
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: selectedIndices.contains(int.parse(widget.user.tickets![index].id.toString())) ? AppColors.blueColor.withOpacity(0.1) : Colors.transparent,
            border: Border.all(
              width: selectedIndices.contains(int.parse(widget.user.tickets![index].id.toString())) ? 2 : 1,
              color: selectedIndices.contains(int.parse(widget.user.tickets![index].id.toString())) ? AppColors.blueColor : Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'ID: ${widget.user.tickets![index].code}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: selectedIndices.contains(int.parse(widget.user.tickets![index].id.toString())) ? AppColors.blueColor : AppColors.blackColor,
              fontFamily: 'Roboto',
              fontWeight: selectedIndices.contains(int.parse(widget.user.tickets![index].id.toString())) ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
