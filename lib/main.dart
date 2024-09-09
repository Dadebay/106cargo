import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:kargo_app/firebase_options.dart';
import 'package:kargo_app/src/application/settings_singleton.dart';
import 'package:kargo_app/src/core/language_delegates.dart';
import 'package:kargo_app/src/screens/auth/register/repository_register.dart';
import 'package:kargo_app/src/screens/initial/providers/invoice_providers.dart';
import 'package:kargo_app/src/screens/initial/providers/orders_provider.dart';
import 'package:kargo_app/src/screens/initial/repository/search_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/screens/auth/login/repository_login.dart';
import 'src/screens/auth/providers/me_provider.dart';
import 'src/screens/initial/providers/orders_byid_provider.dart';
import 'src/screens/language/language.dart';
import 'src/screens/welcome/splash_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

int? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  final pref = await SharedPreferences.getInstance();
  initScreen = pref.getInt('initScreen');

  await pref.setInt('initScreen', 1);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

  SingletonSharedPreference(pref);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tk'), Locale('ru')],
      path: 'assets/languages',
      fallbackLocale: const Locale('tk'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => SettingsSingleton(),
          ),
          ChangeNotifierProvider(create: (_) => LoginRepository()),
          ChangeNotifierProvider(create: (_) => OrdersProvider()),
          ChangeNotifierProvider(create: (_) => GetOrderByIdProvider()),
          ChangeNotifierProvider(create: (_) => GetMeProvider()),
          ChangeNotifierProvider(create: (_) => InvoiceProvider()),
          ChangeNotifierProvider(create: (_) => RegisterRepository()),
          ChangeNotifierProvider(create: (_) => SearchProvider()),
        ],
        child: const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyApp(),
          // MyApp(),
          //     UpgradeAlert(
          //   barrierDismissible: true,
          //   showIgnore: false,
          //   showLater: false,
          //   showReleaseNotes: false,
          //   upgrader: Upgrader(
          //     languageCode: 'ru',
          //     countryCode: 'ru',
          //     debugDisplayAlways: true,
          //     messages: UpgraderMessages(code: 'ru'),
          //   ),
          //   child: const MyApp(),
          // ),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsSingleton>(
      builder: (_, settings, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              // primarySwatch: Colors.blue,
              ),
          initialRoute: initScreen == 0 || initScreen == null ? 'first' : '/',
          routes: {
            '/': (context) => const SpalshScreen(),
            'first': (context) => const LanguageScreen(),
          },
          builder: (context, childd) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ), //set desired text scale factor here
              child: childd!,
            );
          },
          localizationsDelegates: [
            ...context.localizationDelegates,
            MaterialLocalizationTkDelegate(),
            CupertinoLocalizationTkDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
