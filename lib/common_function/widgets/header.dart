import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildHeader(
  BuildContext context,
  String title,
  IconData iconData,
  bool isEditRequired,
  bool isPdfRequired,
  dynamic data,
  VoidCallback? onEdit,
  VoidCallback? onPdf, {
  VoidCallback? onOpenWindow,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isSmall = screenWidth < 600;

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    color: Colors.blueGrey.shade50,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Row: Back, Icon, Title and maybe space filler
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: Get.back,
              tooltip: "Back",
              color: Colors.blueGrey,
            ),
            const SizedBox(width: 4),
            Icon(iconData, color: Colors.blueGrey, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth < 400 ? 18 : 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade800,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (!isSmall)
              _actionButtons(
                isEditRequired,
                isPdfRequired,
                onEdit,
                onPdf,
                onOpenWindow,
              ),
          ],
        ),

        // On small screens, show buttons below title
        if (isSmall) const SizedBox(height: 12),
        if (isSmall)
          _actionButtons(
            isEditRequired,
            isPdfRequired,
            onEdit,
            onPdf,
            onOpenWindow,
          ),
      ],
    ),
  );
}

Widget _actionButtons(
  bool isEditRequired,
  bool isPdfRequired,
  VoidCallback? onEdit,
  VoidCallback? onPdf,
  VoidCallback? openWindow,
) {
  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      if (openWindow != null)
        ElevatedButton.icon(
          onPressed: openWindow,
          icon: const Icon(Icons.workspace_premium, size: 18),
          label: const Text('RSC Cert.'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            textStyle: const TextStyle(fontSize: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

      if (isEditRequired)
        ElevatedButton.icon(
          onPressed: onEdit,
          icon: const Icon(Icons.edit, size: 18),
          label: const Text('Edit'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            textStyle: const TextStyle(fontSize: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      if (isPdfRequired)
        ElevatedButton.icon(
          onPressed: onPdf,
          icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
          label: const Text("Export PDF"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
    ],
  );
}
