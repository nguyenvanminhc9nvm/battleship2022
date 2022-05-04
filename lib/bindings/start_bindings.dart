import 'package:battleship2022/ui/start/start_controller.dart';
import 'package:get/get.dart';

class StartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StartController());
  }
}