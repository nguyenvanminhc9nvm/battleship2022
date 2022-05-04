import 'package:battleship2022/ui/prepare/prepare_controller.dart';
import 'package:get/get.dart';

class PrepareBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PrepareController());
  }
}