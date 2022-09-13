import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:rtl/controller/GetxNetworkManager.dart';
import 'package:rtl/controller/leave_controller.dart';

import '../controller/notification_controller.dart';

class StoreBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => GetXNetworkManager());
    Get.lazyPut(() => LeaveController());
    Get.lazyPut(() => NotificationController());
  }
}
