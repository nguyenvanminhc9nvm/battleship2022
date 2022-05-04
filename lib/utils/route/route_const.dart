import 'package:battleship2022/bindings/calendar_binding.dart';
import 'package:battleship2022/bindings/chart_binding.dart';
import 'package:battleship2022/bindings/mode_bindings.dart';
import 'package:battleship2022/bindings/prepare_binding.dart';
import 'package:battleship2022/bindings/setting_binding.dart';
import 'package:battleship2022/bindings/start_bindings.dart';
import 'package:battleship2022/ui/calendar/calendar_custom_screen.dart';
import 'package:battleship2022/ui/chart/chart_screen.dart';
import 'package:battleship2022/ui/flutter_google_chart/google_chart_screen.dart';
import 'package:battleship2022/ui/health_calendar/health_calendar.dart';
import 'package:battleship2022/ui/prepare/prepare_screen.dart';
import 'package:battleship2022/ui/select_mode/mode_screen.dart';
import 'package:battleship2022/ui/setting/setting_screen.dart';
import 'package:battleship2022/ui/start/start_screen.dart';
import 'package:get/get.dart';

class RouteConst {
  static const String start = "/";
  static const String mode = "/mode";
  static const String setting = "/mode/setting";
  static const String prepare = "/mode/setting/prepare";
  static final routes = [
    GetPage(
      name: start,
      page: () => const ChartScreen(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: mode,
      page: () => const ModeScreen(),
      binding: ModeBinding(),
    ),
    GetPage(
      name: setting,
      page: () => const SettingScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: prepare,
      page: () => const PrepareScreen(),
      binding: PrepareBinding(),
    ),
  ];
}
