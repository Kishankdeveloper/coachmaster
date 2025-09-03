import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar(String value, {Color? bgColor}) {
  // Default background color if none is provided (e.g., green)
  bgColor ??= Colors.green;

  Get.dialog(
    Center(
      child: Material(
        color: Colors.transparent, // To make the background transparent
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: bgColor.withOpacity(0.7), // Dynamic background color
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    ),
    barrierDismissible: true, // Allow dismissing by tapping outside
  );

  // Auto-dismiss after some time
  Future.delayed(const Duration(seconds: 1), () {
    Get.back(); // Close the dialog
  });
}

void showCustomSnackbarClose(
  String line1,
  String line2, {
  Color? bgColor,
  Color? bgColor1,
}) {
  bgColor ??= Colors.green;
  bgColor1 ??= Colors.brown;

  Get.dialog(
    Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 400, // Responsive max width for large screens
            minWidth: 200,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              Text(
                line1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: bgColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                line2,
                textAlign: TextAlign.center,
                style: TextStyle(color: bgColor1, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: true,
  );
}
