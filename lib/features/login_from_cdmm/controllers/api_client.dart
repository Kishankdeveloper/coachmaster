import 'package:coachmaster/features/login_from_cdmm/controllers/token.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:get/get_connect/http/src/request/request.dart';
import '../errors/exceptions.dart';
import 'authenticator.dart';

class ApiClient extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://roams.cris.org.in/emumaintenanceservices/'; // <-- prod base URL
    //httpClient.baseUrl = 'https://roams.cris.org.in/trgemumaintenanceservices/'; // <-- test base URL
    httpClient.timeout = const Duration(seconds: 60);
    httpClient.addRequestModifier(requestInterceptor);
    super.onInit();
  }

  FutureOr<Request> requestInterceptor(Request request) async {
    final userAuthenticator = Get.find<UserAuthenticator>();
    final Token token = await userAuthenticator.getValidTokenRefreshIfExpired();
    request.headers['Authorization'] = 'Bearer ${token.access_token}';
    request.headers['x-auth-token'] = token.access_token!;

    return request;
  }
}

class ApiClientFullUrl extends GetConnect {

  @override
  void onInit() {
    httpClient.timeout = const Duration(seconds: 60);
    httpClient.addRequestModifier(requestInterceptor);
    super.onInit();
  }

  FutureOr<Request> requestInterceptor(Request request) async {
    final userAuthenticator = Get.find<UserAuthenticator>();
    final Token token = await userAuthenticator.getValidTokenRefreshIfExpired();
    request.headers['Authorization'] = 'Bearer ${token.access_token}';
    request.headers['x-auth-token'] = token.access_token!;

    return request;
  }



}
