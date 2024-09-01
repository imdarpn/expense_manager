import 'package:dio/dio.dart';
import 'package:expense_manager/common/constants/string_constants.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import '../common/enum/method_type.dart';
import '../common/methods/common_methods.dart';
import '../common/widgets/common_widgets.dart';
import '../utils/logger_util.dart';
import 'api_constant.dart';
import 'api_interceptor.dart';

class DioClient extends GetxService {
  late Dio _dio;


  Future<DioClient> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl + ApiConstant.exchangeConverterKey,
      ),
    )..interceptors.add(ApiInterceptors());
    return this;
  }

  Future<Map<String, dynamic>> request(
      String url, MethodType method, dynamic params) async {
    try {
      Response response;
      if (await CommonMethods.checkConnectivity()) {
        if (method == MethodType.post) {
          response = await _dio.post(url, data: params);
        } else if (method == MethodType.delete) {
          response = await _dio.delete(url);
        } else if (method == MethodType.patch) {
          response = await _dio.patch(url);
        } else if (method == MethodType.put) {
          response = await _dio.put(url, data: params);
        } else {
          response = await _dio.get(url);
        }

        return response.data;
      } else {
        return {"message": StringConstants.noInternetConnection, "status": false};
      }
    } on DioException catch (dioError) {
      logger.e("DioException -- ${dioError.toString()}");


      CommonWidgets.showSnackBar(dioError.response?.data["message"]);

      return {"message": dioError.response?.data["message"], "status": false};
    } catch (error) {
      return {"message": error.toString(), "status": false};
    }
  }


}
