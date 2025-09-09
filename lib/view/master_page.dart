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
     /* appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00ACC1), Color(0xFF80CBC4), Color(0xFF00796B)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Container(
                width: 45 + 230,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              margin: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/app-logo.png',
                    height: 45,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Image.asset(
                      'assets/images/app-name.png',
                      height: 45,
                      width: 45 + 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            leadingWidth: menuCtrl.isMobile.value ? 100 : 0,
            leading: Obx(() {
              return menuCtrl.isMobile.value
                  ? IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: menuCtrl.toggleMenuVisibility,
                    )
                  : const SizedBox.shrink();
            }),
            actions: [
              Obx(() {
                // Only show user info if not mobile
                if (!menuCtrl.isMobile.value) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.person, size: 20),
                        const SizedBox(width: 6),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 350, // Adjust width if needed
                          ),
                          child: Text(
                            '${userInfo.firstName}-${userInfo.level}-${userInfo.location} V-${CommonConstants.version}',
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: AppFonts.appBarUserDetailTextStyle,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink(); // Hide on mobile
                }
              }),
            ],
          ),
        ),
      ),*/
      body:  child
    );
  }
}
