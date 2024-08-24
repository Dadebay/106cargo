// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

bool isSkippable = false;
Future<void> showUpdateVersionDialog(
  BuildContext context,
  bool isSkippable,
) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/logo.svg',
              height: 80,
              width: 80,
            ),
            const Text('New version available'),
          ],
        ),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Please update to the latest version of the app.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Skip'),
            onPressed: () async {
              isSkippable = true;
              Navigator.pop(context);
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isSkippable', isSkippable);
            },
          ),
          TextButton(
            child: const Text('Update'),
            onPressed: () {
              _launchAppOrPlayStore();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showUpdateVersionMustDialog(
  BuildContext context,
) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/logo.svg',
                height: 80,
                width: 80,
              ),
              const Text('New version available'),
            ],
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please must update to the latest version of the app.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                _launchAppOrPlayStore();
              },
            ),
          ],
        ),
      );
    },
  );
}

void _launchAppOrPlayStore() {
  final appId = Platform.isAndroid ? 'guwanchaldurdyyewProduct.kargo_app' : 'com.guwanchaldurdyyew.kargoApp';
  final url = Uri.parse(
    Platform.isAndroid ? 'market://details?id=$appId' : 'https://apps.apple.com/app/id$appId',
  );
  launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  );
}
