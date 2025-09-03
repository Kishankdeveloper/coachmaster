import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDecimalField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? hintText;
  final int maxLength;
  final TextEditingController controller;
  final double width;

  const CustomDecimalField({
    super.key,
    required this.label,
    required this.maxLength,
    required this.isRequired,
    required this.controller,
    required this.width,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(label, isRequired),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxLength),
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              hintText: hintText != null ? 'Enter $hintText' : null,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if ((value == null || value.isEmpty) && isRequired) {
                return '$label is required';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, bool isRequired) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        children: isRequired
            ? const [
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
