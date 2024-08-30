import 'package:flutter/material.dart';
import 'package:kargo_app/src/screens/clientHome/components/clientInfoCard_slider.dart';
import 'package:kargo_app/src/screens/clientHome/components/location_slider.dart';
import 'package:kargo_app/src/screens/clientHome/components/search_textfield.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SearchTextField(),
        Expanded(
          flex: 1,
          child: LocationSlider(),
        ),
        const Expanded(
          flex: 8,
          child: ClientInfoCardSlider(),
        ),
      ],
    );
  }
}
