// ignore_for_file: always_declare_return_types, use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kargo_app/src/core/send_token.dart';
import 'package:kargo_app/src/screens/clientHome/clientHome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bottom_nav/bottom_nav_screen.dart';
import '../../core/firebase_setup.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    fetchRemote();

    FirebaseSetup.init(context);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      checkUser();
    });
    sendToken();
  }

  Future<void> checkUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final bool? val = preferences.getBool('is_collector');
    if (val ?? false) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const ClientHomeScreen(),
        ),
      );
    } else {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const BottomNavScreen(),
        ),
      );
    }
  }

  fetchRemote() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.fetchAndActivate();
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
    });
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 1),
      ),
    );
  }

  sendToken() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final String? token = await firebaseMessaging.getToken();
    // print('fffffffcccmm');
    // print(token);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tokenAuth = prefs.getString('token');
    await prefs.setString('tokenFcm', token!);
    if (tokenAuth != null) {
      final String? tokenFcm = prefs.getString('tokenFcm');
      if (token != tokenFcm) {
        await SendFcmTokenRepository().sendToken(token);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Center(
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
