import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ShopDio {
  static Dio dio;

  static defineDio() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true),
    );
  }

  static Future<Response> postData(
      {String url,
      Map<String, dynamic> query,
      Map<String, dynamic> data,
      String token}) {
    dio.options.headers = {
      'Authorization':token
    };
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> getData(
      {@required String url,
      String token,
      Map<String, dynamic> query,
      Map<String, dynamic> data}) async {
    dio.options.headers = {'Authorization': token ?? '', 'lang': 'en'};
    Response<dynamic> get = await dio.get(url);
    //printWrapped(get.toString());
    return get;
  }

  static void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
