import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:kargo_app/src/design/app_colors.dart';
import 'package:kargo_app/src/screens/auth/components/custom_text_fild.dart';
import 'package:kargo_app/src/screens/clientHome/clientHome_controller.dart';
import 'package:kargo_app/src/screens/clientHome/components/custom_button.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/getOneOrder_service.dart';
import 'package:kargo_app/src/screens/custom_widgets/widgets.dart';

class Tolegler extends StatelessWidget {
  Tolegler({required this.totalDebt, super.key});
  final String totalDebt;
  TextEditingController seneController = TextEditingController();
  TextEditingController seneController1 = TextEditingController();
  TextEditingController ulagController = TextEditingController();
  TextEditingController ulagController1 = TextEditingController();
  TextEditingController idController = TextEditingController();
  final ClientHomeController clientHomeController = Get.put(ClientHomeController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        topCard(context),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
            children: [
              topText(),
              Obx(
                () {
                  return Center(
                    child: clientHomeController.paymentHistory.isNotEmpty
                        ? page()
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              child: Text(
                                'Hiç hili maglumat tapylmady',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
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

  ListView page() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: clientHomeController.paymentHistory.length + 1,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (clientHomeController.paymentHistory.length == index) {
          return const SizedBox(height: 50, width: double.infinity);
        } else {
          return Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        clientHomeController.paymentHistory[index].ticketCode.toString(),
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        clientHomeController.paymentHistory[index].transport.toString(),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        clientHomeController.paymentHistory[index].paid.toString(),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showDeletePayment(context, clientHomeController.paymentHistory[index].id.toString(), int.parse(clientHomeController.paymentHistory[index].status.toString()));
                },
                icon: const Icon(
                  IconlyLight.delete,
                  color: AppColors.mainColor,
                ),
              ),
            ],
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey.shade400,
        );
      },
    );
  }

  Future showDeletePayment(BuildContext context, String ID, int statusID) async {
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
                  'Tölegi pozmak isleýärsiňizmi ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
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
                        if (statusID == 1) {
                          showSnackBar('Ýalňyşlyk', 'Siz bu tölegi pozup bilmersiňiz', Colors.red);
                        } else {
                          await GetOneOrderService().deletePayment(id: ID);
                          await GetOneOrderService().getPaymentMethod(
                            dateFrom: seneController.text,
                            dateTo: seneController1.text,
                            ticket_search: idController.text,
                            from_transport_id: ulagController.text,
                            to_transport_id: ulagController1.text,
                          );
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

  Row topText() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'ID',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Ulag №',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Toleg',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(),
      ],
    );
  }

  Future<DateTime?> showDateTimePickerWidget({
    required BuildContext context,
    required TextEditingController controller,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    print(selectedDate);

    controller.text = selectedDate.toString().substring(0, 10);
    return selectedDate;
  }

  Container topCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
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
                child: const Text(
                  'Jemi',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  clientHomeController.sumPaid.toString(),
                  style: const TextStyle(
                    color: AppColors.redColor,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFildWithText(
                  onTap: () {
                    showDateTimePickerWidget(context: context, controller: seneController).then((value) async {
                      if (seneController1.text.isNotEmpty && seneController.text.isNotEmpty) {
                        GetOneOrderService().getPaymentDateSearch(
                          dateFrom: seneController.text,
                          dateTo: seneController1.text,
                        );
                      }
                    });
                  },
                  showOnTap: true,
                  hint: DateTime.now().toString().substring(0, 10),
                  text: 'Sene',
                  controller: seneController,
                ),
              ),
              Expanded(
                child: CustomTextFildWithText(
                  onTap: () async {
                    showDateTimePickerWidget(context: context, controller: seneController1).then((value) async {
                      if (seneController1.text.isNotEmpty && seneController.text.isNotEmpty) {
                        GetOneOrderService().getPaymentDateSearch(
                          dateFrom: seneController.text,
                          dateTo: seneController1.text,
                        );
                      }
                    });
                  },
                  showOnTap: true,
                  hint: DateTime.now().toString().substring(0, 10),
                  text: 'Sene',
                  controller: seneController1,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFildWithText(
                  hint: '90',
                  text: 'Ulag №',
                  onTap: () {},
                  showOnTap: false,
                  controller: ulagController,
                ),
              ),
              Expanded(
                child: CustomTextFildWithText(
                  hint: '110',
                  onTap: () {},
                  showOnTap: false,
                  text: 'Ulag №',
                  controller: ulagController1,
                ),
              ),
            ],
          ),
          CustomTextFildWithText(
            hint: 'BBB',
            onTap: () {},
            showOnTap: false,
            text: 'ID',
            controller: idController,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButtonWithText(
            text: 'Gozle',
            onTap: () async {
              clientHomeController.paymentHistory.clear();
              await GetOneOrderService().getPaymentMethod(
                dateFrom: seneController.text,
                dateTo: seneController1.text,
                ticket_search: idController.text,
                from_transport_id: ulagController.text,
                to_transport_id: ulagController1.text,
              );
            },
          ),
        ],
      ),
    );
  }
}
