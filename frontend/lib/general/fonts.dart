import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//If you dont use ScaffoldBody widget you should call refresh in every build
class ScreenSize {
  ///Sets the width and the height by the [context]
  static void refresh(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    isMobile = width < 600;
    isTablet = width >= 600 && width < 1025;
    isDesktop = width > 1024;
  }

  static double width = 0;
  static double height = 0;
  static bool isMobile = true;
  static bool isTablet = false;
  static bool isDesktop = false;
}

//big, medium, small font size for mobile, tablet, desktop screen
class AppFontSize {
  static var _bigFontSizes = [50, 45, 35];
  static List<int> get bigFontSizes =>
      _bigFontSizes..sort((a, b) => b.compareTo(a));
  static set bigFontSizes(List<int> value) {
    _bigFontSizes = value;
  }

  static var _mediumFontSizes = [35, 30, 25];
  static List<int> get mediumFontSizes =>
      _mediumFontSizes..sort((a, b) => b.compareTo(a));
  static set mediumFontSizes(List<int> value) {
    _mediumFontSizes = value;
  }

  static var _smallFontSizes = [25, 20, 15];
  static List<int> get smallFontSizes =>
      _smallFontSizes..sort((a, b) => b.compareTo(a));
  static set smallFontSizes(List<int> value) {
    _smallFontSizes = value;
  }

  int get big {
    if (ScreenSize.isMobile) {
      return bigFontSizes[2];
    } else if (ScreenSize.isTablet) {
      return bigFontSizes[1];
    }
    return bigFontSizes[0];
  }

  int get medium {
    if (ScreenSize.isMobile) {
      return mediumFontSizes[2];
    } else if (ScreenSize.isTablet) {
      return mediumFontSizes[1];
    }
    return mediumFontSizes[0];
  }

  int get small {
    if (ScreenSize.isMobile) {
      return smallFontSizes[2];
    } else if (ScreenSize.isTablet) {
      return smallFontSizes[1];
    }
    return smallFontSizes[0];
  }
}

// ignore: non_constant_identifier_names
Widget AppText(String text,
    {Color? color,
    double fontSize = 15,
    double? spacing,
    FontWeight? weight = FontWeight.normal,
    int? maxlines = 1,
    double minFontSize = 10,
    double stepGranularity = 1,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextStyle? style}) {
  return AutoSizeText(
    text,
    style: style ??
        GoogleFonts.mavenPro(
            color: color,
            letterSpacing: spacing,
            fontWeight: weight,
            fontSize: fontSize),
    minFontSize: minFontSize,
    stepGranularity: stepGranularity,
    maxLines: maxlines,
  );
}
