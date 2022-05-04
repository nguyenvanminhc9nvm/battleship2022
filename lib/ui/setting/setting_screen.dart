import 'package:battleship2022/ui/setting/setting_controller.dart';
import 'package:battleship2022/utils/route/route_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constant/constant.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConst.icSetting), fit: BoxFit.cover),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black]),
            ),
            padding: EdgeInsets.all(21.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "map".tr,
                  style: GoogleFonts.k2d(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 40.sp,
                  ),
                ),
                SizedBox(height: 12.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.mapSelected.value = 35;
                      },
                      child: SvgPicture.asset(
                        ImageConst.icMap35,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.mapSelected.value = 45;
                      },
                      child: SvgPicture.asset(
                        ImageConst.icMap45,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.mapSelected.value = 55;
                      },
                      child: SvgPicture.asset(
                        ImageConst.icMap55,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 38.h,),
                Text(
                  "select_ship".tr,
                  style: GoogleFonts.k2d(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 40.sp,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 4,
                      child: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(ImageConst.icShip2),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      flex: 6,
                      child: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(ImageConst.icShip3),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(ImageConst.icShip1),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      flex: 8,
                      child: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(ImageConst.icShip4),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 53.h,),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(RouteConst.prepare);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      width: controller.widthPlayBtn.value,
                      height: controller.heightPlayBtn.value,
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
                      child: Center(
                        child: Text("play".tr, style: GoogleFonts.k2d(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 20.sp,
                        ),),
                      ),
                    ),
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
