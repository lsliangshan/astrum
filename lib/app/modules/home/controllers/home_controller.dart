import 'package:astrum/types/types.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<TabName> currentTabName = TabName.home.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void changeTab(TabName tabName) {
    currentTabName.value = tabName;
    update(['update-selected-tab']);
  }
}
