import 'package:get/get.dart';
import 'auth_interceptor.dart';
import 'environment.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Environment.baseUrl;
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.timeout = const Duration(seconds: 300);
  }
}
