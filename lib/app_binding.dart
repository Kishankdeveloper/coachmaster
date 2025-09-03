import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'features/login_from_cdmm/controllers/auth_local_storage_provider.dart';
import 'features/login_from_cdmm/controllers/auth_provider.dart';
import 'features/login_from_cdmm/controllers/authenticator.dart';
import 'features/login_from_cdmm/controllers/jwt_helper.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(const FlutterSecureStorage(), permanent: true);
    Get.put(JwtHelper(), permanent: true);
    Get.put(AuthProvider(), permanent: true);
    Get.put(
      AuthLocalStorageProvider(secureStorage: Get.find()),
      permanent: true,
    );
    Get.put(UserAuthenticator(authProvider: Get.find(), localStorageProvider: Get.find(), jwtHelper: Get.find(),), permanent: true);
  }
}
