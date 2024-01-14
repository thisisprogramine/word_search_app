


import 'package:flutter/material.dart';
import 'package:word_search_app/config/extension/size_extensions.dart';
import 'package:word_search_app/presentation/theme/theme_color.dart';
import 'package:word_search_app/presentation/widgets/logo.dart';

import '../config/constants/route_constants.dart';
import '../config/constants/size_constants.dart';

class WordSearchAppInit extends StatefulWidget {
  const WordSearchAppInit({Key? key}) : super(key: key);
  @override
  State<WordSearchAppInit> createState() => _WordSearchAppInitState();
}

class _WordSearchAppInitState extends State<WordSearchAppInit> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500)).then((value) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouteList.home,
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primary,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: Sizes.dimen_20.h, horizontal: Sizes.dimen_20.w),
          child: const Center(
            child: Logo(
              isDark: true,
            ),
          ),
        )
    );
  }
}
