// ignore_for_file: file_names, library_prefixes

import 'package:get/get.dart';
import 'package:kargo_app/src/screens/clientHome/data/models/getOneOrder_model.dart' as oneOrder;
import 'package:kargo_app/src/screens/clientHome/data/models/meRegions_model.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/meRegions_service.dart';
import 'package:kargo_app/src/screens/clientHome/data/services/region_service.dart';

class ClientHomeController extends GetxController {
  RxString locationName = ''.obs;
  RxString urlParamsString = ''.obs;
  RxString locationId = ''.obs;
  RxString userId = ''.obs;
  RxString sumPaid = ''.obs;
  RxString totalDebt = ''.obs;
  RxInt loading = 0.obs;
  RxInt page = 0.obs;
  RxInt limit = 10.obs;
  RxList<Point> regionNames = <Point>[].obs;
  RxList showUsersList = [].obs;
  RxList<oneOrder.PaymentModel> paymentHistory = <oneOrder.PaymentModel>[].obs;
  RxList<oneOrder.Datum> showOrderIDList = <oneOrder.Datum>[].obs;
  RxBool valueList = false.obs;
  Future<void> selectLocation({
    required String selectedLocation,
    required String regionId,
  }) async {
    locationName.value = selectedLocation;
    locationId.value = regionId;
    page.value = 1;
    loading.value = 0;
    showUsersList.clear();

    await RegionService().fetchRegion(id: locationId.value, limit: limit.value, page: page.value);
  }

  void selectUserId({required String value}) {
    userId.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    fetchRegions();
  }

//this is fetched data for tabbar
  void fetchRegions() async {
    List<Point> fetchedRegions = [];
    try {
      fetchedRegions = await MeRegionService().fetchRegionNames();
      regionNames.assignAll(fetchedRegions);
    } finally {
      if (regionNames.isNotEmpty) {
        locationName.value = regionNames.first.name ?? '';
        locationId.value = regionNames.first.id.toString();
      } else if (fetchedRegions.isNotEmpty) {
        locationName.value = fetchedRegions.first.name ?? '';
        locationId.value = regionNames.first.id.toString();
      } else {
        locationName.value = '';
      }
      await RegionService().fetchRegion(id: locationId.value, limit: limit.value, page: page.value);
    }
  }
}
