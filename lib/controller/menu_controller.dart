import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../features/login_from_cdmm/controllers/authenticator.dart';
import '../features/login_from_cdmm/controllers/token.dart';

class MenuControllerX extends GetxController {
  var isCollapsed = false.obs;
  var isVisible = true.obs;
  var isMobile = false.obs;
  var token = ''.obs;
  void toggleCollapse() => isCollapsed.value = !isCollapsed.value;
  void toggleMenuVisibility() => isVisible.value = !isVisible.value;

  void updateDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    isMobile.value = width < 700;
    isVisible.value = width >= 700;
  }

  @override
  void onInit() {
    super.onInit();
    updateToken();
  }

  Future<void> updateToken() async {
    final userAuthenticator = Get.find<UserAuthenticator>();
    final Token fetchedToken = await userAuthenticator
        .getValidTokenRefreshIfExpired();
    token.value = '${fetchedToken.access_token}';
  }
}
