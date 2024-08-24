import 'package:get/get.dart';

class InitialPageController extends GetxController {
  RxInt loading = 0.obs;
  RxInt page = 1.obs;
  RxInt limit = 5.obs;
  RxList showOrders = [].obs;
}
