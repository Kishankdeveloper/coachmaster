import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/login_from_cdmm/controllers/authenticator.dart';

class SessionOutPage extends StatefulWidget {
  const SessionOutPage({super.key});

  @override
  State<SessionOutPage> createState() => _SessionOutPageState();
}

class _SessionOutPageState extends State<SessionOutPage> {
  final UserAuthenticator userAuthenticator = Get.find();

  @override
  void initState() {
    super.initState();
    _handleSessionOut();
  }

  Future<void> _handleSessionOut() async {
    await userAuthenticator.deleteAuthentication();
    // Clear token/session
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.lock_clock, size: 100, color: Colors.redAccent),
              SizedBox(height: 20),
              Text(
                'Session Expired',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your session has expired due to inactivity.\nPlease log in again to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
