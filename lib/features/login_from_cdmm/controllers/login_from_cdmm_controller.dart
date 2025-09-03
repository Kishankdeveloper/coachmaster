import 'package:coachmaster/features/login_from_cdmm/controllers/token.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_pages.dart';
import 'authenticator.dart';

class LoginFromCdmmController extends GetxController {
  UserAuthenticator userAuthenticator = Get.put(
    UserAuthenticator(
      authProvider: Get.find(),
      localStorageProvider: Get.find(),
      jwtHelper: Get.find(),
    ),
  );

  var token = '';
  final count = 0.obs;
  @override
  void onInit() {
    EasyLoading.show(status: 'Loading Dashboard...');
    var uriArr = Uri.base.toString().split('/');
    token = uriArr[uriArr.length - 1];
    checkAuthFormCdmm();
    super.onInit();
  }

  Future<void> checkAuthFormCdmm() async {
    var res = await userAuthenticator.checkAuthenticationForCdmm(
      Token(access_token: token, refresh_token: token),
    );
    res.fold(
      (failure) {
        EasyLoading.dismiss();
        Get.back();
        Get.snackbar(
          "Failed Authentication",
          "Please checked token, failed to Authenticate!",
        );
      },
      (result) {
        EasyLoading.dismiss();
        Get.offAllNamed(Routes.coachMaster);
      },
    );
  }

  void increment() => count.value++;
}
