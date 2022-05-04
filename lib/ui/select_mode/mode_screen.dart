import 'package:battleship2022/ui/select_mode/mode_controller.dart';
import 'package:battleship2022/utils/route/route_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constant/constant.dart';

class ModeScreen extends GetView<ModeController> {
  const ModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConst.icMode), fit: BoxFit.cover),
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
                      "mode".tr,
                      style: GoogleFonts.k2d(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 40.sp,
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  width: controller.width.value,
                  height: controller.height.value,
                  margin: EdgeInsets.symmetric(
                    horizontal: 34.w,
                    vertical: 38.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConst.colorBtn,
                    border: Border.all(
                      color: ColorConst.colorBorder,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(
                      10.r,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 96.h,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Get.toNamed(RouteConst.setting);
                          },
                          icon: SvgPicture.asset(
                            ImageConst.icPvCo,
                          ),
                          label: Text(
                            "pvco".tr,
                            style: GoogleFonts.k2d(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                horizontal: 36.w,
                                vertical: 19.h,
                              ),
                              primary: Colors.transparent),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 96.h,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            ImageConst.icBluetooh,
                          ),
                          label: Text(
                            "bluetooh".tr,
                            style: GoogleFonts.k2d(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                horizontal: 36.w,
                                vertical: 19.h,
                              ),
                              primary: Colors.transparent),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            ImageConst.icPvp,
                          ),
                          label: Text(
                            "pvp".tr,
                            style: GoogleFonts.k2d(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                horizontal: 36.w,
                                vertical: 19.h,
                              ),
                              primary: Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
