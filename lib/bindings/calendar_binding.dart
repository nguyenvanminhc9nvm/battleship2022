import 'package:battleship2022/ui/calendar/calendar_custom_controller.dart';
import 'package:get/get.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CalendarCustomController());
  }

}