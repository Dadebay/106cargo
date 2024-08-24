import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kargo_app/src/design/app_colors.dart';
import 'package:kargo_app/src/screens/initial/providers/invoice_providers.dart';
import 'package:provider/provider.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../../../design/custom_icon.dart';
import '../../custom_widgets/widgets.dart';

// ignore: must_be_immutable
class InvoiceNew extends StatefulWidget {
  int id;
  InvoiceNew({required this.id, super.key});

  @override
  State<InvoiceNew> createState() => _InvoiceNewState();
}

class _InvoiceNewState extends State<InvoiceNew> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  dynamic fetchData() async {
    await Provider.of<InvoiceProvider>(context, listen: false).getInvoice(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final invoice = Provider.of<InvoiceProvider>(context);
    final double deviceWidth = MediaQuery.of(context).size.width;

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
        child: invoice.invoice != null
            ? Consumer<InvoiceProvider>(
                builder: (_, invoicess, __) {
                  if (invoicess.isLoading == false) {
                    return SizedBox(
                      child: Zoom(
                        initTotalZoomOut: true,
                        maxZoomWidth: 1640,
                        maxZoomHeight: 3000,
                        backgroundColor: Colors.white,
                        colorScrollBars: Colors.grey,
                        opacityScrollBars: 0.3,
                        scrollWeight: 5.0,
                        // centerOnScale: true,
                        enableScroll: true,
                        doubleTapZoom: true,
                        zoomSensibility: 0.05,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 100,
                            right: 100,
                            top: 0,
                            bottom: 60,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 200,
                                ),
                                ImageAndIconPart(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: divider(),
                                ),
                                firstTextField(invoice),
                                divider(),
                                secondTextField(invoice, deviceWidth),
                                divider(),
                                thridTextField(deviceWidth),
                                fourthTextField(invoice, deviceWidth),
                                invoice.invoice!.expenses.isEmpty ? const SizedBox.shrink() : divider(),
                                invoice.invoice!.expenses.isEmpty ? const SizedBox.shrink() : fifthTextField(invoice),
                                divider(),
                                lastOne(invoice),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return loading();
                  }
                },
              )
            : loading(),
      ),
    );
  }

  Widget lastOne(InvoiceProvider invoice) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                customTextField(
                  flex: 1,
                  align: TextAlign.end,
                  text: 'all_land'.tr(),
                ),
                customTextField(
                  flex: 1,
                  align: TextAlign.start,
                  text: '  ' '${invoice.invoice?.summarySeats.toString() ?? ''}',
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                customTextField(
                  flex: 1,
                  align: TextAlign.end,
                  text: 'sum_cub'.tr(),
                ),
                customTextField(
                  flex: 1,
                  align: TextAlign.start,
                  text: '  ' '${invoice.invoice?.summaryCube.toString() ?? ''}',
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                customTextField(
                  flex: 1,
                  align: TextAlign.end,
                  text: 'sum_kg'.tr(),
                ),
                customTextField(
                  flex: 1,
                  align: TextAlign.start,
                  text: '  ' '${invoice.invoice?.summaryKg.toString() ?? ''}',
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                customTextField(
                  flex: 1,
                  align: TextAlign.end,
                  text: 'sum_cost'.tr(),
                ),
                customTextField(
                  flex: 1,
                  align: TextAlign.start,
                  text: '  ' '${invoice.invoice?.summaryPrice.toString() ?? ''}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fifthTextField(InvoiceProvider invoice) {
    print(invoice.invoice!.expenses.length);
    return ListView.builder(
      padding: const EdgeInsets.all(18.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: invoice.invoice!.expenses.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: Text(
                invoice.invoice?.expenses[index].name.toString() ?? '',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            invoice.invoice?.expenses[index].price != null
                ? Expanded(
                    flex: 1,
                    child: Text(
                      invoice.invoice?.expenses[index].price.toString() ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : const Text(''),
          ],
        );
      },
    );
  }

  ListView fourthTextField(InvoiceProvider invoice, double deviceWidth) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: invoice.invoice!.cargoItems.length,
      itemBuilder: (BuildContext context, int index) {
        final packingSizeLast = invoice.invoice!.cargoItems[index].packingSizeLast;
        final packingSizeMiddle = invoice.invoice?.cargoItems[index].packingSizeMiddle;
        final packingSizeFirst = invoice.invoice?.cargoItems[index].packingSizeFirst;
        final String cargoItems1 = packingSizeFirst;
        final String cargoItems2 = packingSizeMiddle;
        final String cargoItems3 = packingSizeLast;

        return Column(
          children: [
            divider(),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) {
                      var name = invoice.invoice?.cargoItems[index].packingSizeLast.toString();
                      name = name!.replaceAll(
                        '',
                        '\u200B',
                      );

                      return customTextField(
                        flex: 5,
                        align: TextAlign.start,
                        text: invoice.invoice?.cargoItems[index].productName ?? '',
                      );
                    },
                  ),
                  customTextField(
                    flex: 4,
                    align: TextAlign.center,
                    text: invoice.invoice?.cargoItems[index].typePackagingId ?? '',
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        customTextField(
                          flex: 3,
                          align: TextAlign.start,
                          text: cargoItems1,
                        ),
                        customTextField(
                          flex: 3,
                          align: TextAlign.center,
                          text: cargoItems2,
                        ),
                        customTextField(
                          flex: 3,
                          align: TextAlign.end,
                          text: cargoItems3,
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  customTextField(
                    flex: 3,
                    align: TextAlign.center,
                    text: invoice.invoice?.cargoItems[index].numberOfSeats.toString() ?? '',
                  ),
                  customTextField(
                    flex: 3,
                    align: TextAlign.center,
                    text: invoice.invoice?.cargoItems[index].cube.toString() ?? '',
                  ),
                  customTextField(
                    flex: 3,
                    align: TextAlign.center,
                    text: invoice.invoice?.cargoItems[index].kg.toString() ?? '',
                  ),
                  customTextField(
                    flex: 3,
                    align: TextAlign.center,
                    text: invoice.invoice?.cargoItems[index].totalPrice.toString() ?? '',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Padding thridTextField(double deviceWidth) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTextField(
            flex: 4,
            align: TextAlign.start,
            text: 'name_product'.tr(),
          ),
          customTextField(
            flex: 3,
            align: TextAlign.start,
            text: 'type_of_box'.tr(),
          ),
          customTextField(
            flex: 3,
            align: TextAlign.start,
            text: 'scale'.tr(),
          ),
          customTextField(
            flex: 2,
            align: TextAlign.center,
            text: 'land_number'.tr(),
          ),
          customTextField(
            flex: 2,
            align: TextAlign.center,
            text: 'cub_in'.tr(),
          ),
          customTextField(
            flex: 2,
            align: TextAlign.center,
            text: 'kg'.tr(),
          ),
          customTextField(
            flex: 2,
            align: TextAlign.center,
            text: 'cost_in'.tr(),
          ),
        ],
      ),
    );
  }

  Container divider() {
    return Container(
      height: 1.5,
      color: Colors.black,
    );
  }

  Padding secondTextField(InvoiceProvider invoice, double deviceWidth) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) {
              final tripData = invoice.invoice;
              if (tripData != null) {
                final trNumber = tripData.transport_number;
                return customTextField(flex: 1, align: TextAlign.start, text: 'transport_number'.tr() + trNumber);
              } else {
                return const Text('');
              }
            },
          ),
          customTextField(flex: 1, align: TextAlign.start, text: invoice.invoice?.trackCode ?? ''),
          customTextField(flex: 1, align: TextAlign.start, text: invoice.invoice?.customersName ?? ''),
          customTextField(
            flex: 1,
            align: TextAlign.end,
            text: '+993${invoice.invoice?.customersPhone}',
          ),
        ],
      ),
    );
  }

  dynamic customTextField({required int flex, required TextAlign align, required String text}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: align,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontFamily: 'Roboto',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Padding firstTextField(InvoiceProvider invoice) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customTextField(flex: 1, align: TextAlign.start, text: invoice.invoice?.date ?? ''),
          customTextField(flex: 1, align: TextAlign.start, text: invoice.invoice?.ticketId ?? ''),
          customTextField(flex: 1, align: TextAlign.start, text: invoice.invoice?.pointFrom ?? ''),
          customTextField(flex: 1, align: TextAlign.end, text: invoice.invoice?.pointTo ?? ''),
        ],
      ),
    );
  }

  Row ImageAndIconPart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 300,
                width: 450,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  CustomIcon(
                    title: 'assets/icons/phone.svg',
                    height: 24,
                    width: 24,
                    color: AppColors.profilColor,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '+99361 00 00 66 Batyr',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Row(
                  children: [
                    CustomIcon(
                      title: 'assets/icons/phone.svg',
                      height: 24,
                      width: 24,
                      color: AppColors.profilColor,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        '+99365 67 77 67 Kakajan',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Row(
                  children: [
                    CustomIcon(
                      title: 'assets/icons/phone.svg',
                      height: 24,
                      width: 24,
                      color: AppColors.profilColor,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        '+99365 49 94 46 Berdi',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 60),
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                'Urumçi-Türkmenistan \n 新疆乌鲁木齐市天山区延安路边疆宾馆106库房 \n 收货人：吴慧 +8618699106778 Наташа Урумчи',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                textAlign: TextAlign.center,
                'Guanjou-Urumçi-Türkmenistan \n +8618699106778 广州市 白云区 石井镇 \n 鸦岗大道 安发货运市场 A9栋69-70号 鑫唯达物流 \n 收货人: 吴劲松 +8613352898456 Гуанчжоу',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                textAlign: TextAlign.center,
                'Yiwu - Urumçi - Türkmenistan \n 浙江省义乌市惠民路708号988库 \n 电话:18066232225 \n 电话: 13938015691',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
