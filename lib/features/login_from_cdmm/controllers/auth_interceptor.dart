import 'dart:async';
import 'package:coachmaster/features/login_from_cdmm/controllers/token.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'authenticator.dart';

FutureOr<Request> requestInterceptor(request) async {
  UserAuthenticator userAuthenticator = Get.find();
  Token token = await userAuthenticator.getValidTokenRefreshIfExpired();
  request.headers['Authorization'] = 'Bearer ${token.access_token}';
  request.headers['x-auth-token'] = '${token.access_token}';
  return request;
}
