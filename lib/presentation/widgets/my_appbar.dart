import 'dart:io';

import 'package:flutter/material.dart';
import 'package:word_search_app/config/extension/size_extensions.dart';

import '../../config/constants/size_constants.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool elevation;
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;

  MyAppBar({
    this.elevation = true,
    this.title,
    this.leading,
    this.actions
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation ? 1.0 : 0.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: title != null ? Text(title ?? '',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold),
      ) : Icon(Icons.abc, size: Sizes.dimen_32.h),
      leading: leading ?? IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}