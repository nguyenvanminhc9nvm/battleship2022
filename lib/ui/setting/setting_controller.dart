import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  var widthPlayBtn = 270.w.obs;
  var heightPlayBtn = 72.h.obs;
  bool isScale = false;
  var mapSelected = 35.obs;
  var shipCount = 1.obs;

  @override
  void onInit() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isScale) {
        widthPlayBtn.value = 270.w;
      } else {
        widthPlayBtn.value = 260.w;
      }
      if (isScale) {
        heightPlayBtn.value = 72.h;
      } else {
        heightPlayBtn.value = 62.h;
      }
      isScale = !isScale;
    });
    super.onInit();
  }
}