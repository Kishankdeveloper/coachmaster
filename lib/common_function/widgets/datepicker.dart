import 'package:flutter/material.dart';

class CustomDateField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final DateTime? date;
  final VoidCallback onTap;
  final double width;
  final String? hintText;

  const CustomDateField({
    super.key,
    required this.label,
    required this.isRequired,
    required this.date,
    required this.onTap,
    required this.width,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FormField<DateTime>(
        validator: (_) {
          if (isRequired && date == null) {
            return '$label is required';
          }
          return null;
        },
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel(label, isRequired),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  onTap();
                  state.didChange(date); // update the state after selection
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    hintText: hintText ?? 'Select Date',
                    border: const OutlineInputBorder(),
                    errorText: state.errorText,
                  ),
                  child: Text(
                    date != null
                        ? "${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}"
                        : (hintText ?? 'Select Date'),
                    style: TextStyle(
                      color: date == null ? Colors.grey[600] : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
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
