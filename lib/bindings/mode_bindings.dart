import 'package:battleship2022/ui/select_mode/mode_controller.dart';
import 'package:get/get.dart';

class ModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ModeController());
  }
}