import 'package:coachmaster/features/coach_purification/views/coach_purification_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/coach_master/views/coach_master_view_page.dart';
import '../../features/coach_master/views/coach_master_views.dart';
import '../../features/coach_master/views/coach_view_only_page.dart';
import '../../features/login_from_cdmm/bindings/login_from_cdmm_binding.dart';
import '../../features/login_from_cdmm/views/login_from_cdmm_view.dart';
import '../../view/master_page.dart';
import '../../view/session_expires.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.RSMS_COACH_MASTER;

  //static const INITIAL = Routes.checkUser;
  static const coachMaster = Routes.coachMaster;

  static final routes = [
    GetPage(name: '/session-expired', page: () => SessionOutPage()),

   /* GetPage(
      name: '/rsms-coachmaster/:token',
      page: () => LoginFromCdmmView(token: Get.parameters['token'] ?? ''),
      binding: LoginFromCdmmBinding(),
    ),*/

    GetPage(
      name: '/rsms-coachmaster/:token',
      page: () => LoginFromCdmmView(
        token: Get.parameters['token'] ?? '',
        origin: Routes.RSMS_COACH_MASTER,   // 👈 pass origin
      ),
      binding: LoginFromCdmmBinding(),
    ),

    GetPage(
      name: '/cp-coachpurification/:token',
      page: () => LoginFromCdmmView(token: Get.parameters['token'] ?? '',
      origin: Routes.coachPurification,),
      binding: LoginFromCdmmBinding(),
    ),

    GetPage(
      name: '/reports',
      page: () => MasterPage(child: const Center(child: Text("Reports"))),
    ),

    GetPage(
      name: '/coachMaster',
      page: () => MasterPage(child: Center(child: CoachMasterView())),
    ),

    GetPage(
      name: '/coachpurification',
      page: () => MasterPage(child: Center(child: CoachPurificationView())),
    ),

    GetPage(
      name: '/',
      page: () => const Scaffold(body: Center(child: Text("Enter Token"))),
    ),

    GetPage(
      name: '/coachMaster/coachDetails',
      page: () => MasterPage(child: Center(child: CoachDetailsPage())),
    ),

    GetPage(
      name: '/coachMaster/coachDetails/viewOnly',
      page: () => MasterPage(child: Center(child: CoachDetailsPageViewOnly())),
    ),

  ];
}
