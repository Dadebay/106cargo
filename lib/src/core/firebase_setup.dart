import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kargo_app/src/core/send_token.dart';
import 'package:kargo_app/src/design/app_colors.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class FirebaseSetup {
  static void init(BuildContext context) async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final set = await firebaseMessaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
      provisional: true,
    );
    if (set.authorizationStatus == AuthorizationStatus.authorized || set.authorizationStatus == AuthorizationStatus.provisional) {
      if (context.mounted) {
        await setupInteractedMessage(context);
      }
    }
    final String? token = await firebaseMessaging.getToken();
    await SendFcmTokenRepository().sendToken(token!);
  }

  static Future<void> setupInteractedMessage(BuildContext context) async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null && context.mounted) {
      _handleMessage(initialMessage, context);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessage(message, context);
    });

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = message.notification?.android;
      final AppleNotification? apple = message.notification?.apple;
      if (notification != null && (android != null || apple != null)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.transparent,
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
              duration: const Duration(seconds: 3),
              padding: const EdgeInsets.all(10),
              elevation: 0,
              content: Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderColor, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.1),
                          spreadRadius: 3,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 5),
                            child: Container(
                              color: AppColors.borderColor,
                              height: 60,
                              width: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.notification?.title ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Rubik',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 150,
                                  child: Text(
                                    message.notification?.body ?? '',
                                    maxLines: 4,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Rubik',
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
                  ),
                ),
              ),
            ),
          );
        }
      }
    }).onError((e) {});
  }

  static void _handleMessage(RemoteMessage message, BuildContext context) {}
}
