

import 'package:flutter/material.dart';
import 'package:word_search_app/presentation/screens/create_grid/create_grid_screen.dart';
import 'package:word_search_app/presentation/screens/home/home_screen.dart';
import 'package:word_search_app/presentation/word_search_app_init.dart';

import '../../config/constants/route_constants.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => const WordSearchAppInit(),
        RouteList.home: (context) => const HomeScreen(),
        RouteList.createGrid: (context) => const CreateGridScreen(),

      };
}
