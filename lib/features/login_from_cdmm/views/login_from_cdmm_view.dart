// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/authenticator.dart';
// import '../controllers/login_from_cdmm_controller.dart';
//
// class LoginFromCdmmView extends GetView<LoginFromCdmmController> {
//   LoginFromCdmmView({super.key});
//   LoginFromCdmmController loginFromCdmmController = Get.put(LoginFromCdmmController());
//   UserAuthenticator userAuthenticator = Get.put(UserAuthenticator(authProvider: Get.find(), localStorageProvider: Get.find(), jwtHelper: Get.find()));
//
//   @override
//   Widget build(BuildContext context) {
//     log("where is i am?");
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//             style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
//             onPressed: () async {
//               await loginFromCdmmController.checkAuthFormCdmm();
//               // await userAuthenticator.checkAuthenticationForCdmm(Token(
//               //     access_token: loginFromCdmmController.token,
//               //     refresh_token: loginFromCdmmController.token));
//               // Get.toNamed(Routes.CMM_HOME_VIEW);
//             },
//             child: const Text('Click here to go to CMM Dashboard',
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             )),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../controllers/login_from_cdmm_controller.dart';

class LoginFromCdmmView extends StatefulWidget {
  final String token;
  const LoginFromCdmmView({super.key, required this.token});

  @override
  State<LoginFromCdmmView> createState() => _LoginFromCdmmViewState();
}

class _LoginFromCdmmViewState extends State<LoginFromCdmmView> {
  final LoginFromCdmmController loginFromCdmmController = Get.put(LoginFromCdmmController());

  void _initService() async {
    EasyLoading.show(status: 'Authenticating...');
    loginFromCdmmController.token = widget.token;
    await loginFromCdmmController.checkAuthFormCdmm();
  }

  @override
  Widget build(BuildContext context) {
    _initService();
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

