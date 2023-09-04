import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/ReUsable/routes/pages.dart';
import 'package:tours_guide/fucntions_call.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/controller.dart';
import 'package:tours_guide/pages/companyScreen/show_tour/controller.dart';
import 'package:tours_guide/pages/screens/PersonPage/controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  await Firebase.initializeApp();
  Get.put(CompanyProfileController());
  Get.lazyPut<CompanyShowTourController>(() => CompanyShowTourController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool isDarkMode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _fetchThemeMode();
  }

  Future<void> _fetchThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(Get.isDarkMode.toString());
    // print(Get.is)
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.light(),
          // darkTheme: ThemeData.dark(),
          // themeMode:  isDarkMode ? ThemeMode.dark : ThemeMode.light,

          // home: CallFunction(),
          initialRoute: AppRoutes.SplashScreen,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
