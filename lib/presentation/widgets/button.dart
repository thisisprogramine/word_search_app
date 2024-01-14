

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_search_app/config/extension/size_extensions.dart';
import 'package:word_search_app/presentation/theme/theme_text.dart';

import '../../config/constants/size_constants.dart';
import '../theme/theme_color.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool isEnabled;
  final double? width;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const ValueKey('main_button'),
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h, horizontal: width != null ? width! : Sizes.dimen_0.w),
        child: Text(
            text, style: Theme.of(context).textTheme.buttonStyle?.copyWith(fontWeight: FontWeight.bold)
        ),
      ),

    );
  }
}
