
import 'package:flutter/material.dart';
import 'package:word_search_app/config/extension/size_extensions.dart';
import '../../config/constants/size_constants.dart';
import 'theme_color.dart';
import 'theme_text.dart';


class AppTheme {
  AppTheme._();

  static ThemeData getAppTheme({required BuildContext context}) {
    return ThemeData(
      unselectedWidgetColor: AppColor.secondary,
      primaryColor: AppColor.primary,
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColor.secondary,
          primary: AppColor.primary,
          brightness: Brightness.light),
      scaffoldBackgroundColor: AppColor.surface,
      cardTheme: const CardTheme(
        // color: AppColor.white.withOpacity(0.1),
        color: AppColor.surface,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: ThemeText.getTextTheme(),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColor.surface
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: AppColor.onSurface,
        elevation: 2
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColor.primary,
      ),
      iconTheme: const IconThemeData(
        color: AppColor.vulcan
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: AppColor.transparent,
        iconTheme: IconThemeData(
            color: AppColor.vulcan
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorMaxLines: 2,
        contentPadding: EdgeInsets.symmetric(vertical: Sizes.dimen_4.h, horizontal: Sizes.dimen_18.w),
        hintStyle: Theme.of(context).textTheme.greyCaption,
        prefixStyle: Theme.of(context).textTheme.greyCaption,
        errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red, fontSize: Sizes.dimen_10.sp),
        labelStyle: Theme.of(context).textTheme.bodySmall,
        alignLabelWithHint: true,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,

      ),
    );
  }


}
