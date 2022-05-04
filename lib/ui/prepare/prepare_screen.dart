import 'package:battleship2022/utils/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PrepareScreen extends StatelessWidget {
  const PrepareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.colorBtn,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Coin"),
                  Align(
                    child: InkWell(
                      child: Container(
                        width: 102.w,
                        height: 38.h,
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: ColorConst.colorBorder,
                            borderRadius: BorderRadius.circular(50.r)),
                        child: Center(
                          child: Text(
                            "done",
                            style: GoogleFonts.k2d(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SvgPicture.asset(
                      ImageConst.icMapRound35,
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
