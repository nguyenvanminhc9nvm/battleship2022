import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StartController extends GetxController {
  var width = 361.w.obs;
  var height = 72.h.obs;
  bool isScale = false;

  @override
  void onInit() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      print("start loop");
      if (isScale) {
        width.value = 381.w;
      } else {
        width.value = 341.w;
      }
      if (isScale) {
        height.value = 82.h;
      } else {
        height.value = 62.h;
      }
      isScale = !isScale;
    });
    super.onInit();
  }

  @override
  void onClose() {
    print("stop");
    // TODO: implement onClose
    super.onClose();
  }
}
