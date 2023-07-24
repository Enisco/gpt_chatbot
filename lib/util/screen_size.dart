import 'package:flutter/cupertino.dart';

class ScreenSize {
  double width;
  double height;

  ScreenSize(this.height, this.width);
}

ScreenSize screenSize(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  final bottomNavBar = MediaQuery.of(context).padding.bottom;
  final topStatusBar = MediaQuery.of(context).padding.top;
  final totalBarsHeight = bottomNavBar + topStatusBar;
  final totalWidth = size.width;
  final totalHeight = size.height;
  final usableHeight = totalHeight - totalBarsHeight;
  ScreenSize thisSize = ScreenSize(usableHeight, totalWidth);

  return thisSize;
}

double screenWidth(BuildContext context) {
  return screenSize(context).width;
}

double screenHeight(BuildContext context) {
  return screenSize(context).height;
}
