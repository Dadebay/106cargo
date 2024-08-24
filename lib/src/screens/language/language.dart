import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kargo_app/src/screens/welcome/welcome_page.dart';

import '../../design/app_colors.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 340,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
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
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text(
                        'app_title'.tr(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  turkmenButton(context),
                  englishButton(context),
                  const SizedBox(
                    height: 30,
                  ),
                  nextButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell englishButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        await context.setLocale(const Locale('en'));
        print(context.locale);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 15),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.locale.languageCode == 'en' ? AppColors.mainColor : Colors.grey,
                  width: 1.5,
                ),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.locale.languageCode == 'en' ? AppColors.mainColor : Colors.grey,
                      width: 1.5,
                    ),
                    color: context.locale.languageCode == 'en' ? AppColors.mainColor : Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 30,
                width: 30,
                child: Image.asset(
                  'assets/images/united-kingdom.png',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'English',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell turkmenButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        await context.setLocale(const Locale('tk'));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 30),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.locale.languageCode == 'tk' ? AppColors.mainColor : Colors.grey,
                  width: 1.5,
                ),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: context.locale.languageCode == 'tk' ? AppColors.mainColor : Colors.white,
                    border: Border.all(
                      color: context.locale.languageCode == 'tk' ? AppColors.mainColor : Colors.grey,
                      width: 1.5,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset('assets/images/turkman.png'),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Türkmen',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell nextButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => WelcomePage(),
          ),
          (route) => false,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          right: 20,
          left: 20,
          bottom: 30,
        ),
        child: Container(
          height: 45,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              'next_to'.tr(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
