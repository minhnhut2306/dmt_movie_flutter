import 'package:flutter/material.dart';
import '../../presentation/features/test/test_screen.dart';
import '../../presentation/features/auth/screens/login_screen.dart';
import '../../presentation/features/auth/screens/otp_screen.dart';
import '../../presentation/features/profile/screens/select_profile_screen.dart';
import '../../presentation/features/profile/screens/profile_management_screen.dart';
import '../../presentation/features/movie/screens/detail_screen.dart';
import '../../presentation/common/navigation/main_navigation.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static const String initialRoute = RouteNames.main;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.test:
        return _buildRoute(const TestScreen());

      case RouteNames.login:
        return _buildRoute(const LoginRegisterScreen());

      case RouteNames.otp:
        final email = settings.arguments as String?;
        return _buildRoute(OtpScreen(email: email));

      case RouteNames.selectProfile:
        return _buildRoute(const SelectProfileScreen());

      case RouteNames.profileManagement:
        return _buildRoute(const ProfileManagementScreen());

      case RouteNames.main:
        return _buildRoute(const MainNavigation());

      case RouteNames.movieDetail:
        return _buildRoute(const DetailScreen());

      default:
        return _buildRoute(
          Scaffold(
            body: Center(
              child: Text('Route không tồn tại: ${settings.name}'),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _buildRoute(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }

  static Map<String, WidgetBuilder> get routes => {
        RouteNames.test: (_) => const TestScreen(),
        RouteNames.login: (_) => const LoginRegisterScreen(),
        RouteNames.otp: (_) => const OtpScreen(),
        RouteNames.selectProfile: (_) => const SelectProfileScreen(),
        RouteNames.profileManagement: (_) => const ProfileManagementScreen(),
        RouteNames.main: (_) => const MainNavigation(),
        RouteNames.movieDetail: (_) => const DetailScreen(),
      };
}