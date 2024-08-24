import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kargo_app/src/design/custom_icon.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
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
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            title: Text(
              'about'.tr(),
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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
            ),
            CustomIconText(
              text: '+8617699509372 Berdi',
              title: 'assets/icons/phone.svg',
              height: 24,
              width: 24,
              color: Colors.red,
            ),
            CustomIconText(
              text: '+8618690868865 Batyr',
              title: 'assets/icons/phone.svg',
              height: 24,
              width: 24,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            CustomIconText(
              text: '+99361 00 00 66 Batyr  ',
              title: 'assets/icons/phone.svg',
              height: 24,
              width: 24,
              color: Colors.green,
            ),
            CustomIconText(
              text: '+99365 67 77 67 Kakajan',
              title: 'assets/icons/phone.svg',
              height: 24,
              width: 24,
              color: Colors.green,
            ),
            CustomIconText(
              text: '+99365 49 94 46 Berdi',
              title: 'assets/icons/phone.svg',
              height: 24,
              width: 24,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
