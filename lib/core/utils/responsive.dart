import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension BreakpointX on BuildContext {
  bool get isMobile => MediaQuery.sizeOf(this).width < 600;
  bool get isTablet =>
      MediaQuery.sizeOf(this).width >= 600 &&
      MediaQuery.sizeOf(this).width < 900;
  bool get isDesktop => MediaQuery.sizeOf(this).width >= 900;
}

double gridCardAspectRatio(double width) {
  if (width >= 900) return 0.75;
  if (width >= 600) return 0.72;
  return 0.68;
}

int gridColumnCount(double width) {
  if (width >= 900) return 4;
  if (width >= 600) return 3;
  return 2;
}

double detailImageHeight(BuildContext context) {
  if (context.isDesktop) return 420.h;
  if (context.isTablet) return 380.h;
  return 300.h;
}

double gridSpacing(BuildContext context) {
  if (context.isDesktop) return 20.w;
  if (context.isTablet) return 16.w;
  return 12.w;
}
