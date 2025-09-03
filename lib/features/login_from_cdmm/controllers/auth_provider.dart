import 'package:get/get.dart';
import 'environment.dart';
import 'login_request.dart';

class AuthProvider extends GetConnect {
  final String authPath = '/oauth/token';
  final String captchaPath = '/captcha/';

  @override
  void onInit() {
    httpClient.baseUrl = Environment.authBaseUrl;
  }

  Future<Response> authenticate({required LoginRequest loginRequest}) async {
    FormData formData = FormData({
        "grant_type": "password",
        "username": loginRequest.username,
        "password": loginRequest.password,
      });
    try {
      return _authenticate(authPath, formData);
    } on Exception {
      rethrow;
    }
  }

  Future<Response> getCaptcha() async {
    try {
      return _getCaptcha(authPath);
    } on Exception {
      rethrow;
    }
  }

  Future<Response> verifyCaptcha(String captchaEndPoint) async {
    FormData formData = FormData({});
    try {
      return _verifyCaptcha(authPath, captchaEndPoint, formData);
    } on Exception {
      rethrow;
    }
  }

  Future<Response> refreshToken({
    required String refreshToken,
  }) async {
    FormData formData = FormData(
      {
        "grant_type": "refresh_token",
        "refresh_token": refreshToken,
      },
    );
    try {
      return _authenticate(authPath, formData);
    } on Exception {
      rethrow;
    }
  }

  _authenticate(String path, FormData formData) {
    try {
      return post(
        path,
        formData,
        contentType: 'application/x-www-form-urlencoded',
        headers: {
          "Authorization": "Basic Y21tOmNtbUBjcmlzLm9yZy4xbg==",
        },
      );
    } on Exception {
      rethrow;
    }
  }

  _getCaptcha(String path) {
    try {
      return get(
        path,
      );
    } on Exception {
      rethrow;
    }
  }

  _verifyCaptcha(String path, String captchaEndPoint, FormData formData) {
    try {
      return post(
        '$path/$captchaEndPoint',
          formData,
      );
    } on Exception {
      rethrow;
    }
  }
}
