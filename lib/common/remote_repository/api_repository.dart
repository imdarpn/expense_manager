import 'package:expense_manager/common/models/exchange_rate_model.dart';
import 'package:get/get.dart';

import '../../api_service/api_constant.dart';
import '../../api_service/dio_client.dart';
import '../enum/method_type.dart';


abstract class ApiRepository {
  Future<ExchangeRateModel> getExchangeRateAPI();
}

class ApiRepositoryImpl extends ApiRepository {
  late DioClient _dioClient;

  ApiRepositoryImpl() {
    _dioClient = Get.find();
  }

  @override
  Future<ExchangeRateModel> getExchangeRateAPI() async {
    try {


      var response = await _dioClient.request("/latest/${ApiConstant.baseCode}",
          MethodType.get, {});

      return ExchangeRateModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }


}
