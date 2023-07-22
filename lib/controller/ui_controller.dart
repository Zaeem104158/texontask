import 'package:get/get.dart';

class UiController extends GetxController {
  RxInt bottomNavigationControlSelectedIndex = 0.obs;

  void setBottomNavigationControlSelectedIndex(int index) {
    bottomNavigationControlSelectedIndex.value = index;
  }
}
