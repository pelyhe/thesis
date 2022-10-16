import 'package:flutter/cupertino.dart';
import 'package:formula/general/fonts.dart';

//depending on what kind of screen will your app run, you can just comment the unnecessary lines
Widget scaffoldBody(
    {required BuildContext context,
    Widget? mobileBody,
    Widget? tabletBody,
    Widget? desktopBody}) {
  ScreenSize.refresh(context);

  if (ScreenSize.isMobile) {
    return mobileBody!;
  } else if (ScreenSize.isTablet) {
    return tabletBody!;
  } else {
    return desktopBody!;
  }
}
