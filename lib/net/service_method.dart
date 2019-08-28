import 'dart:async';

import "package:dio/dio.dart";
import 'package:kfc_flutter/config/service_url.dart';

Future request(url) async {
  try {
    Response response;
    Dio dio = new Dio();
//    dio.options.contentType =
//        ContentType.parse("application/x-www-form-urlencoded");
    response = await dio.get(servicePath[url]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}
