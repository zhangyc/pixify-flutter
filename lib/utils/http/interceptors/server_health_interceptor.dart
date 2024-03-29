import 'package:dio/dio.dart';

class ServerHealthInterceptor extends Interceptor {
  String fsUrl='https://open.feishu.cn/open-apis/bot/v2/hook/3900e81e-5ffd-4b89-beff-23d9c1bf9507';
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.statusCode==200){

      if(response.data['code']!='0'&&response.data['code']!='60010'){
        _dio.post(fsUrl,data: {
          "msg_type": "text",
          "content": {"text": " ${response.toString()}"}
        });
      }
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _dio.post(fsUrl,data: {
      "msg_type": "text",
      "content": {"text": "dio error:${err.toString()}"}
    });
    handler.next(err);
  }
}
Dio _dio=Dio(BaseOptions(
  headers: {
   "Content-Type":"application/json"
  }
));