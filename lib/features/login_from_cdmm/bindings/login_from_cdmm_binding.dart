import 'package:get/get.dart';

import '../controllers/login_from_cdmm_controller.dart';

class LoginFromCdmmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginFromCdmmController>(
      () => LoginFromCdmmController(),
    );
  }
}
