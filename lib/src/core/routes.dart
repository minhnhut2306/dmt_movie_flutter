import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/src/screens/test_screen.dart';
import 'package:dmt_movie_flutter/src/screens/home_screen.dart';
import 'package:dmt_movie_flutter/src/screens/login_register_screen.dart';
import 'package:dmt_movie_flutter/src/screens/otp_screen.dart';
import 'package:dmt_movie_flutter/src/screens/select_profile_screen.dart';

class AppRoutes {
  static const testScreen = '/test_screen';
  static const main = '/';
  static const home = '/home';
  static const search = '/search';
  static const settings = '/settings';
  static const detail = '/detail';
  static const login = '/login';
  static const otp = '/otp';
  static const selectProfile = '/select_profile';

  static const String defaultRoute = selectProfile;

  static Map<String, WidgetBuilder> map = {
    testScreen: (_) => const TestScreen(),
    login: (_) => const LoginRegisterScreen(),
    otp: (_) => const OtpScreen(),
    selectProfile: (_) => const SelectProfileScreen(),
    main: (_) => const SizedBox(),
    home: (_) => const SizedBox(),
    search: (_) => const SizedBox(),
    settings: (_) => const SizedBox(),
    detail: (_) => const SizedBox(),
  };
}
