import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A reusable key-value info card.
Widget buildInfoCard({
  required String keyLabel,
  required String valueLabel,
  required double width,
}) {
  return Container(
    width: width,
    constraints: const BoxConstraints(minHeight: 90),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(20, 0, 0, 0),
          blurRadius: 4,
          offset: Offset(2, 2),
        ),
      ],
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          keyLabel == 'Base Depot' ? 'Base Depot / Owning Shed' : keyLabel,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          formatDateToDDMMYYYY(valueLabel),
          style: const TextStyle(color: Colors.black87, fontSize: 14),
        ),
      ],
    ),
  );
}

String beautifyKey(String key) {
  final buffer = StringBuffer();

  for (int i = 0; i < key.length; i++) {
    final char = key[i];
    if (i > 0 && char.toUpperCase() == char && char != '_' && char != char.toLowerCase()) {
      buffer.write(' ');
    }
    buffer.write(char);
  }

  return buffer.toString().split(' ').map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1);
  }).join(' ');
}

/// Converts dynamic values to displayable string
String stringifyValue(dynamic value) {
  if (value == null) return '-';
  if (value is DateTime) {
    return DateFormat('yyyy-MM-dd').format(value);
  }
  return value.toString();
}

/// Extracts a map from any object that implements `toJson()`
Map<String, dynamic> extractFields(Object object) {
  try {
    return (object as dynamic).toJson() as Map<String, dynamic>;
  } catch (_) {
    return {};
  }
}

/// convert to DDMMYYYY
dynamic formatDateToDDMMYYYY(dynamic input) {
  try {
    if (input == null) return null;

    if (input is DateTime) {
      return DateFormat('dd-MM-yyyy').format(input);
    }

    if (input is String && RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(input)) {
      final parsed = DateTime.tryParse(input);
      if (parsed != null) {
        return DateFormat('dd-MM-yyyy').format(parsed);
      }
    }
    return input;
  } catch (_) {
    return input;
  }
}

///convert to date only no time or null
String? toDateStringOnlyOrNull(DateTime? date) {
  if (date == null) return null;

  return (DateFormat('yyyy-MM-dd').format(date)).toString();
}

String getCoachImage(String? coachType) {
  final type = coachType?.toUpperCase() ?? '';
  if (type.contains('MC')) return 'assets/images/mc.png';
  if (type.contains('TC')) return 'assets/images/tc.jpeg';
  return 'assets/images/emu_logo.jpg';
}
