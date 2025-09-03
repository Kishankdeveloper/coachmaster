import 'package:flutter/material.dart';

Widget InfoRow(String label, String? value) {
  return Row(
    children: [
      Flexible(
        flex: 7, // 70%
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF37474F),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      SizedBox(width: 8), // spacing between columns
      Flexible(
        flex: 3, // 30%
        child: Text(
          value?.isNotEmpty == true ? value! : '-',
          style: TextStyle(fontSize: 14, color: Color(0xFF546E7A)),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    ],
  );
}

Widget InfoRowFull(String label) {
  return Row(
    children: [
      Flexible(
        flex: 1, // 70%
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF37474F),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    ],
  );
}

Widget InfoRowExpended(String label, String? value) {
  return Row(
    children: [
      Flexible(
        flex: 7, // 70%
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF37474F),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      SizedBox(width: 8), // spacing between columns
      Flexible(
        flex: 3, // 30%
        child: Text(
          value?.isNotEmpty == true ? value! : '-',
          style: TextStyle(fontSize: 14, color: Color(0xFF546E7A)),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    ],
  );
}
