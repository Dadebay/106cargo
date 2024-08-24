import 'package:flutter/material.dart';
import 'package:kargo_app/src/core/firebase_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/about/about_us.dart';
import '../screens/initial/initial.dart';
import '../screens/profile/profile.dart';
import '../screens/profile/proofile_logout.dart';
import 'bottom_nav_bar_button.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedIndex = 0;

  bool isvisible = false;
  bool? isSkippable = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    FirebaseSetup.init(context);
    super.initState();
    checkUser();
    // checkAndUpdateSkippable();
    // checkForUpdates();
  }

  int changer = 0;

  Future<void> checkUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? val = preferences.getString('token');

    if (val != null) {
      changer = 1;
    }
  }

  // Future<void> checkForUpdates() async {
  //   final remoteConfig = FirebaseRemoteConfig.instance;

  //   await remoteConfig.fetchAndActivate();
  //   remoteConfig.onConfigUpdated.listen((event) async {
  //     await remoteConfig.activate();
  //   });
  //   await remoteConfig.setConfigSettings(
  //     RemoteConfigSettings(
  //       fetchTimeout: const Duration(minutes: 1),
  //       minimumFetchInterval: const Duration(seconds: 1),
  //     ),
  //   );

  //   final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //   String getUpdateVersion() => remoteConfig.getString('update');

  //   String getMustUpdateVersion() => remoteConfig.getString('must_update');

  //   if (Constants.mustUpdate != getMustUpdateVersion()) {
  //     await showUpdateVersionMustDialog(context);
  //   }

  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   isSkippable = prefs.getBool('isSkippable');

  //   if (isSkippable == false) {
  //     if (packageInfo.version != getUpdateVersion()) {
  //       showUpdateVersionDialog(context, isSkippable!);
  //     }
  //   }
  // }

  // Future<void> checkAndUpdateSkippable() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.containsKey('lastUpdateCheck')) {
  //     final int lastUpdateCheck = prefs.getInt('lastUpdateCheck') ?? 0;
  //     final int currentTime = DateTime.now().millisecondsSinceEpoch;
  //     if (currentTime - lastUpdateCheck >= const Duration(days: 3).inMilliseconds) {
  //       setState(() async {
  //         isSkippable = false;
  //         await prefs.setBool('isSkippable', isSkippable!);
  //       });
  //       await prefs.setInt('lastUpdateCheck', currentTime);
  //     }
  //   } else {
  //     final int currentTime = DateTime.now().millisecondsSinceEpoch;
  //     await prefs.setInt('lastUpdateCheck', currentTime);
  //   }
  // }

  List page = [
    const InitialScreen(),
    const AboutUs(),
    const ProfileLogOut(),
  ];

  List page2 = [
    const InitialScreen(),
    const AboutUs(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 68,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: BottomNavbarButton(
                icon: false,
                index: 0,
                selectedIndex: selectedIndex,
                onTapp: () {
                  onTapp(0);
                },
              ),
            ),
            Expanded(
              child: BottomNavbarButton(
                icon: false,
                index: 1,
                selectedIndex: selectedIndex,
                onTapp: () {
                  onTapp(1);
                },
              ),
            ),
            Expanded(
              child: BottomNavbarButton(
                icon: false,
                index: 2,
                selectedIndex: selectedIndex,
                onTapp: () {
                  onTapp(2);
                },
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        children: [
          Center(
            child: changer == 1 ? page2[selectedIndex] : page[selectedIndex],
          ),
        ],
      ),
    );
  }

  void onTapp(int index) async {
    setState(() {
      selectedIndex = index;
    });
  }
}
