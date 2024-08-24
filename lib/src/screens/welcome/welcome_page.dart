import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kargo_app/src/design/app_colors.dart';
import 'package:kargo_app/src/design/custom_icon.dart';

import '../../bottom_nav/bottom_nav_screen.dart';
import 'welcome_page_items.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  final _pageController = PageController(initialPage: 0);

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
        child: PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const BottomNavScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(
                          'next'.tr(),
                          style: const TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      Items.WelcomeData[index]['image']!,
                      height: MediaQuery.of(context).size.height / 2 - 20,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 30,
                      right: 30,
                      bottom: 40,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SafeArea(
                        child: Column(
                          children: [
                            Text(
                              Items.WelcomeData[index]['title']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            Text(
                              Items.WelcomeData[index]['text']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xff485068),
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List<Widget>.generate(
                                      3,
                                      (indicator) => Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 3.0,
                                        ),
                                        height: 10.0,
                                        width: indicator == index ? 20 : 10.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: indicator == index ? const Color(0xff347af0) : const Color(0xffedf1f9),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (index < 2) {
                                      _pageController.animateToPage(
                                        index + 1,
                                        duration: const Duration(microseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    } else {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => const BottomNavScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: CustomIcon(
                                        title: 'assets/icons/arrow_right.svg',
                                        height: 10,
                                        width: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: 3,
        ),
      ),
    );
  }
}
