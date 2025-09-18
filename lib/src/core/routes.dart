import 'package:dmt_movie_flutter/src/screens/detail_screen.dart';
import 'package:dmt_movie_flutter/src/screens/home_screen.dart';
import 'package:dmt_movie_flutter/src/screens/search_screen.dart';
import 'package:dmt_movie_flutter/src/screens/settings_screen.dart';
import 'package:dmt_movie_flutter/src/widgets/main_navigation.dart';
import 'package:flutter/widgets.dart';


class AppRoutes {
  static const main = '/';
  static const home = '/home';
  static const search = '/search';
  static const settings = '/settings';
  static const detail = '/detail';

  static Map<String, WidgetBuilder> map = {
    main: (_) => const MainNavigation(),
    home: (_) => const HomeScreen(),
    search: (_) => const SearchScreen(),
    settings: (_) => const SettingsScreen(),
    detail: (_) => const DetailScreen(),
  };
}
