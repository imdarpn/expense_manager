import 'dart:convert';


import 'package:expense_manager/common/models/exchange_rate_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StorageUtil {
  static const String keyConversionData = "keyConversionData";
  static const String keySelectedCode = "keySelectedCode";
  static const String keySelectedCodePrice = "keySelectedCodePrice";


  static Future<dynamic> setData(String key, dynamic value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (value is String) {
      return pref.setString(key, value);
    } else if (value is int) {
      return pref.setInt(key, value);
    } else if (value is double) {
      return pref.setDouble(key, value);
    } else if (value is bool) {
      return pref.setBool(key, value);
    } else {
      return pref.setString(key, value);
    }
  }

  static Future<dynamic> getData(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }

  static void clearData() {
    SharedPreferences.getInstance().then((value) {
      value.clear();
    });
  }

  static Future<dynamic> clearSpecificKey(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }



  static Future<ExchangeRateModel> getExchangeRateModel() async {
    var exchangeModelData = await StorageUtil.getData(StorageUtil.keyConversionData);

    if (exchangeModelData != null) {
      ExchangeRateModel exchangeRateModel = ExchangeRateModel.fromJson(
        json.decode(exchangeModelData),
      );
      return exchangeRateModel;
    } else {
      return ExchangeRateModel(baseCode: "INR", conversionRates: {},result: "failure");
    }
  }
}
