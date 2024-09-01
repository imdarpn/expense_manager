import 'package:expense_manager/utils/logger_util.dart';
import 'package:get/get.dart';

import '../../utils/storage_utils.dart';

class SettingController extends GetxController {

  RxMap todayRateConversationMap = {}.obs;
  RxList<MapEntry<dynamic, dynamic>> currencyList = RxList<MapEntry<dynamic, dynamic>>([]);
  @override
  void onInit() {

    getDefaultData();
    super.onInit();

  }

  Future<void> getDefaultData() async {
    var savedResponse = await StorageUtil.getExchangeRateModel();
    todayRateConversationMap.value = savedResponse.conversionRates ?? {};
    currencyList.value = todayRateConversationMap.value.entries.toList();

    logger.d(todayRateConversationMap.value.runtimeType);
    logger.d(todayRateConversationMap.value.length);
  }
}
