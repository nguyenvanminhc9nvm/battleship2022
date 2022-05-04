import 'package:battleship2022/ui/select_mode/mode_screen.dart';
import 'package:battleship2022/ui/start/start_controller.dart';
import 'package:battleship2022/utils/constant/constant.dart';
import 'package:battleship2022/utils/route/route_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends GetView<StartController> {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorConst.colorBtn,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConst.icStart), fit: BoxFit.cover),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black]),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 34.w),
                    child: Text(
                      "title_start".tr,
                      style: GoogleFonts.k2d(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 40.sp,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteConst.mode);
                  },
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      width: controller.width.value,
                      height: controller.height.value,
                      margin: EdgeInsets.symmetric(
                        horizontal: 34.w,
                        vertical: 38.h,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 17.h,
                        horizontal: 27.w,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConst.colorBtn,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: ColorConst.colorBorder,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConst.colorBorder,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageConst.icPlay,
                            width: 30.w,
                            height: 30.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "start".tr,
                            style: GoogleFonts.k2d(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
