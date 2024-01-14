
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_search_app/presentation/bloc/word_cubit/word_search_cubit.dart';
import 'package:word_search_app/presentation/routes/fade_page_route_builder.dart';
import 'package:word_search_app/presentation/routes/routes.dart';
import 'package:word_search_app/presentation/theme/app_theme.dart';

import '../config/constants/route_constants.dart';
import '../config/screenutil/screenutil.dart';
import 'bloc/word_change_cubit/word_change_cubit.dart';

class WordSearchApp extends StatefulWidget {
  const WordSearchApp({super.key});
  
  @override
  _WordSearchAppState createState() => _WordSearchAppState();
}

class _WordSearchAppState extends State<WordSearchApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late WordSearchCubit wordSearchCubit;
  late WordChangeCubit wordChangeCubit;

  @override
  void initState() {
    super.initState();
    wordSearchCubit = WordSearchCubit();
    wordChangeCubit = WordChangeCubit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => wordSearchCubit,
        ),
        BlocProvider(
          create: (context) => wordChangeCubit,
        )
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "Word Search App",
        theme: AppTheme.getAppTheme(context: context),
        initialRoute: RouteList.initial,
        onGenerateRoute: (RouteSettings settings) {
          final routes = Routes.getRoutes(settings);
          final WidgetBuilder? builder = routes[settings.name];
          return FadePageRouteBuilder(
            builder: builder!,
            settings: settings,
          );
        },
      ),
    );
  }

}
