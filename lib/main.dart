import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/smart_management.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'app_binding.dart';
import 'core/routes/app_pages.dart';
import 'features/login_from_cdmm/controllers/environment.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.level = Level.wtf;
  Environment.setEnvironment(EnvironmentEnum.prod);
  FlutterCryptography.enable();
  Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      title: "CoachMaster",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      routingCallback: (routing) {
        // if (routing?.current == '/user_Dashboard') {
        //   if (Get.isRegistered<DashboardController>()) {
        //     Get.find<DashboardController>().fetchDashboardData();
        //   }
        // }
        // if (routing?.current == '/AllTasksPage') {
        //   if (Get.isRegistered<AllTasksController>()) {
        //     Get.find<AllTasksController>().reloadDataIfChanged();
        //   }
        // }
      },
      defaultTransition: Transition.fade,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      builder: EasyLoading.init(),
    );
  }
}
