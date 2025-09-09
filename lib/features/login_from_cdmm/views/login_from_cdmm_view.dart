import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/login_from_cdmm_controller.dart';

class LoginFromCdmmView extends StatefulWidget {
  final String token;
  final String origin;   // 👈 added

  const LoginFromCdmmView({super.key, required this.token, required this.origin});

  @override
  State<LoginFromCdmmView> createState() => _LoginFromCdmmViewState();
}

class _LoginFromCdmmViewState extends State<LoginFromCdmmView> {
  final LoginFromCdmmController loginFromCdmmController =
  Get.put(LoginFromCdmmController());

  void _initService() async {
    EasyLoading.show(status: 'Authenticating...');
    loginFromCdmmController.token = widget.token;
    loginFromCdmmController.origin = widget.origin;   // 👈 save origin
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
