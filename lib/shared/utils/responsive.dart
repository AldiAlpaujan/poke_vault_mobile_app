import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Responsive {
  static var isMobile = true;
  static var isTablet = false;

  static double getHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double getWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static void getDevice() {
    if (getWidth() < 480) {
      isMobile = true;
      isTablet = false;
    } else {
      isMobile = false;
      isTablet = true;
    }
  }

  static bool isPortrait() {
    return MediaQuery.of(Get.context!).orientation == Orientation.portrait;
  }

  static bool isLandscape() {
    return MediaQuery.of(Get.context!).orientation == Orientation.landscape;
  }
}
