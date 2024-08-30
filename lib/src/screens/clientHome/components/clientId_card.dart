// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:kargo_app/src/design/app_colors.dart';
import 'package:kargo_app/src/screens/auth/components/custom_text_fild.dart';
import 'package:kargo_app/src/screens/clientHome/clientHome_controller.dart';
import 'package:kargo_app/src/screens/clientHome/components/custom_button.dart';
import 'package:kargo_app/src/screens/clientHome/data/models/getOneOrder_model.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/getOneOrder_service.dart';

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
            child: CustomTextFildMINE(
              tickedID: tickedIDMine,
            ),
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

  final List<int> selectedIndices = [];

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
          await GetOneOrderService().fetchOneOrderFromFilter(userId: clientHomeController.userId.value, ticketID: selectedIndices, controller: ' ', controller1: ' ').then((a) {
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
