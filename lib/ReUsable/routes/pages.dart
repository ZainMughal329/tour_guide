// import 'package:air_proj_comp/pages/Administration/login/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/pages/admin/index.dart';

// import 'package:tours_guide/pages/companyScreen/add_tour/bindings.dart';
import 'package:tours_guide/pages/companyScreen/add_tour/index.dart';
import 'package:tours_guide/pages/companyScreen/bookings/bindings.dart';
import 'package:tours_guide/pages/companyScreen/bookings/view.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/index.dart';
import 'package:tours_guide/pages/companyScreen/homeScreen/index.dart';
import 'package:tours_guide/pages/companyScreen/show_tour/index.dart';
import 'package:tours_guide/pages/screens/booking_screen/bindings.dart';
import 'package:tours_guide/pages/screens/booking_screen/view.dart';
import 'package:tours_guide/pages/screens/catogery_screen/index.dart';
import 'package:tours_guide/pages/screens/user_bookings/bindings.dart';
import 'package:tours_guide/pages/screens/user_bookings/view.dart';

// import 'package:tours_guide/pages/sessionPages/companySignUp/bindings.dart';
import 'package:tours_guide/pages/sessionPages/signup_login/index.dart';

import '../../pages/application/index.dart';
import '../../pages/sessionPages/splashScreen/index.dart';
import '../../pages/sessionPages/welcome/bindings.dart';
import '../../pages/sessionPages/welcome/view.dart';
import 'names.dart';
import 'observers.dart';

class AppPages {
  static const Welcome = AppRoutes.Welcome;
  static const APPlication = AppRoutes.Application;
  static const Company = AppRoutes.Company_Home;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.SplashScreen,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),

    ),


    GetPage(
      name: AppRoutes.Welcome,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),

    ),

    GetPage(
      name: AppRoutes.LOGIN_SIGN_UP,
      page: () => SignupLoginView(),
      binding: SignupLoginBinding(),

    ),


    GetPage(
      name: AppRoutes.Company_Home,
      page: () => CompanyHome(),
      binding: CompanyHomeBinding(),
    ),

    //
    // // check if needed to login or not
    GetPage(
      name: AppRoutes.Application,
      page: () => ApplicationPage(),
      binding: ApplicationBinding(),
      // middlewares: [
      //   // RouteAuthMiddleware(priority: 1),
      // ],
    ),
    GetPage(
      name: AppRoutes.Admin,
      page: () => AdminHomePage(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: AppRoutes.Company_profile,
      page: () => CompanyProfileView(),
      binding: CompanyProfileBinding(),
    ),

    GetPage(
      name: AppRoutes.Company_AddTour,
      page: () => CompanyAddTourScreen(),
      binding: CompanyAddTourBinding(),
    ),

    GetPage(
      name: AppRoutes.Company_ShowTour,
      page: () => CompanyShowTourScreen(),
      binding: CompanyShowTourBinding(),
    ),



    GetPage(
      name: AppRoutes.Booking_Screen,
      page: () => BookingView(tourId: '',
      name: '',
        phoneNumber: '',
        companyName: '',
        companyId: '',
      ),
      binding: BookingBindings(),
    ),

    GetPage(
      name: AppRoutes.all_Tours,
      page: () => UserBookingView(),
      binding: UserBookingBindings(),
    ),
    GetPage(
      name: AppRoutes.Company_Bookings,
      page: () => CompanyBookingsView(uid: '',),
      binding: CompanyBookingBindings(),
    ),

   ];
}
