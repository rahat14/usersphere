import 'package:flutter/material.dart';
import 'app_colors.dart';

class CustomTextStyle {
  final BuildContext context;

  CustomTextStyle._(this.context); // make this constructor private

  static CustomTextStyle of(BuildContext context) =>
      CustomTextStyle._(context); // pass context to above constructor

  //Heading Style (Title & Sections)
  TextStyle headingMediumTextStyle({Color? color}) {
    return Theme.of(context)
        .textTheme
        .headlineMedium!
        .copyWith(fontFamily: 'Onset')
        .copyWith(color: color);
  }
  TextStyle headingSmallTextStyle({Color? color}) {
    return Theme.of(context)
        .textTheme
        .headlineSmall!
        .copyWith(fontFamily: 'Onset')
        .copyWith(color: color);
  }
  //Titles for Buttons & UI Labels
  TextStyle titleMediumStyle({Color? color}) {
    return Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontFamily: 'Onset')
        .copyWith(color: color);
  } //use
  //Body Text
  TextStyle bodyLargeStyle({Color? color}) {
    return Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontFamily: 'Onset')
        .copyWith(color: color);
  } //use

  //Labels for Buttons, Forms and Tags
  TextStyle bodyMediumStyle({Color? color}) {
    return Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontFamily: 'Onset')
        .copyWith(color: color);
  } //use



}