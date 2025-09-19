import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_function/user_info.dart';
import '../controller/menu_controller.dart';

class MasterPage extends StatelessWidget {
  final Widget child;
  MasterPage({super.key, required this.child});
  final UserInfo userInfo = Get.find();

  @override
  Widget build(BuildContext context) {
    final menuCtrl = Get.put(MenuControllerX());
    menuCtrl.updateDeviceType(context);

    return Scaffold(
      body: child
    );
  }
}
