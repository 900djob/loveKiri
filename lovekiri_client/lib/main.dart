import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:lovekiri_client/screens/login.dart';
import 'package:lovekiri_client/state/app_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await MongoDb.connect();

  //firebase initialize
  await Firebase.initializeApp();
  //kakao login
  KakaoSdk.init(nativeAppKey: '11e5ffc5e93d8bbb4f3641ae066c865b');

  Get.put(AppState());

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ko'),
        Locale('en', 'US'),
      ],
      path: 'assets/langs.csv',
      fallbackLocale: const Locale('en', 'US'),
      saveLocale: false,
      assetLoader: CsvAssetLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'lovekiri',
        theme: ThemeData(
          textTheme: GoogleFonts.breeSerifTextTheme(),
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen());
  }
}
