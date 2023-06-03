// import 'package:air_proj_comp/pages/Administration/login/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/application/index.dart';
import '../../pages/sessionPages/sigin/index.dart';
import '../../pages/sessionPages/sigin/sign_up_view.dart';
import '../../pages/sessionPages/splashScreen/index.dart';
import '../../pages/sessionPages/welcome/bindings.dart';
import '../../pages/sessionPages/welcome/view.dart';
import 'names.dart';
import 'observers.dart';

class AppPages {
  static const Welcome = AppRoutes.Welcome;
  static const APPlication = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [

    GetPage(
      name: AppRoutes.SplashScreen,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
      // middlewares: [
      //   RouteWelcomeMiddleware(priority: 1),
      // ],
    ),

    GetPage(
      name: AppRoutes.Welcome,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
      // middlewares: [
      //   RouteWelcomeMiddleware(priority: 1),
      // ],
    ),
    //
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),
    //
    //
    //
    // GetPage(
    //   name: AppRoutes.Forgot_Password,
    //   page: () => ForgotPasswordView(),
    //   binding: ForgotPassBinding(),
    // ),
    GetPage(
      name: AppRoutes.SIGN_UP,
      page: () => SignUpView(),

    ),
    //
    // // check if needed to login or not
    GetPage(
      name: AppRoutes.Application,
      page: () =>  ApplicationPage(),
      binding: ApplicationBinding(),
      // middlewares: [
      //   // RouteAuthMiddleware(priority: 1),
      // ],
    ),
    //
    //
    //
    // // Admin Pages
    // GetPage(
    //   name: AppRoutes.Admin_Login,
    //   page: () => AdminLoginView(),
    //   binding: AdminLoginBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.Admin_Home,
    //   page: () => AdminHomeView(),
    //   binding: AdminHomeBinding(),
    // ),
    //
    //
    //
    // // Tourist Pages
    // GetPage(
    //   name: AppRoutes.Tourist_Login,
    //   page: () => TouristLoginView(),
    //   binding: TouristLoginBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.Tourist_Home,
    //   page: () => TouristHomeView(),
    //   binding: TouristHomeBinding(),
    // ),
    //
    // GetPage(
    //   name: AppRoutes.Add_Tour,
    //   page: () => AddTourView(),
    //   binding: AddTourBinding(),
    // ),




/*
    // 最新路由
    // 首页
    GetPage(name: AppRoutes.Contact, page: () => ContactPage(), binding: ContactBinding()),
    //消息
    GetPage(name: AppRoutes.Message, page: () => MessagePage(), binding: MessageBinding()),
    //我的
    GetPage(name: AppRoutes.Me, page: () => MePage(), binding: MeBinding()),
    //聊天详情
    GetPage(name: AppRoutes.Chat, page: () => ChatPage(), binding: ChatBinding()),

    GetPage(name: AppRoutes.Photoimgview, page: () => PhotoImgViewPage(), binding: PhotoImgViewBinding()),*/
  ];
}
