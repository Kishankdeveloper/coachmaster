import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Assuming you are using GetX for state management

class TextAreaField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final int maxLength;
  final RxInt remainingChars;
  final TextEditingController controller;
  final String? initialValue;
  final Function(String) onChanged;
  final int minLines;
  final String hintText;
  final double width;

  TextAreaField({
    required this.label,
    required this.isRequired,
    required this.maxLength,
    required this.remainingChars,
    required this.controller,
    this.initialValue,
    required this.onChanged,
    required this.minLines,
    required this.hintText,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    if (initialValue != null && controller.text.isEmpty) {
      controller.text = initialValue!;
    }

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel(label, isRequired),
          SizedBox(height: 4),
          Obx(
            () => TextFormField(
              controller: controller, // Set controller to the TextFormField
              maxLength: maxLength,
              maxLines: null,
              minLines: minLines,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter $hintText',
                counterText: "${remainingChars.value} characters left",
              ),

              validator: (value) {
                if ((value == null || value.isEmpty) && isRequired) {
                  return '$hintText required';
                }
                return null;
              },
              onChanged: (val) {
                onChanged(val); // This will send the updated value
                remainingChars.value = maxLength - val.length;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLabel(String text, bool isRequired) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        children: isRequired
            ? [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
              ]
            : [],
      ),
    );
  }
}
