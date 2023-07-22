import 'package:get/get.dart';

class UserController extends GetxController {
  dynamic argumentData = Get.arguments;

  @override
  void onInit() {
    print(argumentData[0]);
    print(argumentData[1]);
    super.onInit();
  }
}
