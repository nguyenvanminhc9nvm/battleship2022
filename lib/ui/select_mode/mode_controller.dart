import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ModeController extends GetxController {
  var width = 361.w.obs;
  var height = 288.h.obs;
  bool isScale = false;

  @override
  void onInit() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      print("start loop");
      if (isScale) {
        width.value = 381.w;
      } else {
        width.value = 361.w;
      }
      if (isScale) {
        height.value = 288.h;
      } else {
        height.value = 268.h;
      }
      isScale = !isScale;
    });
    super.onInit();
  }
}