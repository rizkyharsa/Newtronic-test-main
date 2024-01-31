import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newtronic_test_rizky/configs/constant.dart';
import 'package:newtronic_test_rizky/controllers/beranda_controller.dart';
import 'package:newtronic_test_rizky/view/splash_screen.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: whiteColor,
    )
  );
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug: true,

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Newtronic Mobile Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          return const SplashScreen();
        },
      ),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => BerandaController(),fenix: true);
      }),
    );
  }
}

