import 'dart:typed_data';
import 'dart:html' as html;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'display_items.dart';

void exportToPdfCommanToView(
  Map<String, dynamic> data,
  String pdfHeader, {
  List<String> excludedFields = const [],
}) async {
  final pdf = pw.Document();

  // Format keys into readable text
  String formatKey(String key) {
    return key
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1)}'
              : '',
        )
        .join(' ');
  }

  final fields = data.entries
      .where(
        (e) =>
            !excludedFields.contains(e.key) &&
            e.key != 'view' &&
            e.key != 'document' &&
            e.key != 'id',
      )
      .toList();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (context) {
        List<pw.Widget> widgets = [];

        // HEADER
        widgets.add(
          pw.Center(
            child: pw.Text(
              pdfHeader,
              style: pw.TextStyle(
                fontSize: 26,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.blue900,
              ),
            ),
          ),
        );

        widgets.add(pw.SizedBox(height: 30));

        // Field Cards
        List<pw.Widget> rowBuffer = [];

        for (int i = 0; i < fields.length; i++) {
          final entry = fields[i];
          final isFullWidth =
              entry.key.toLowerCase().contains('remarks') ||
              entry.key.toLowerCase().contains('comment') ||
              entry.value.toString().length > 60;

          final card = pw.Container(
            padding: const pw.EdgeInsets.all(6),
            margin: const pw.EdgeInsets.only(bottom: 8),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey100,
              border: pw.Border.all(color: PdfColors.grey400, width: 0.5),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  formatKey(entry.key),
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blueGrey800,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  formatDateToDDMMYYYY(entry.value?.toString() ?? '-'),
                  style: const pw.TextStyle(
                    fontSize: 10.5,
                    color: PdfColors.black,
                  ),
                ),
              ],
            ),
          );

          if (isFullWidth) {
            if (rowBuffer.isNotEmpty) {
              widgets.add(
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: rowBuffer.length == 1
                      ? [pw.Expanded(child: rowBuffer[0])]
                      : rowBuffer.map((e) => pw.Expanded(child: e)).toList(),
                ),
              );
              widgets.add(pw.SizedBox(height: 12));
              rowBuffer.clear();
            }

            widgets.add(card);
            widgets.add(pw.SizedBox(height: 6));
          } else {
            rowBuffer.add(card);

            if (rowBuffer.length == 2 || i == fields.length - 1) {
              widgets.add(
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: List.generate(rowBuffer.length, (index) {
                    return pw.Expanded(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.only(
                          right: index != rowBuffer.length - 1
                              ? 8
                              : 0, // 8px space between columns
                        ),
                        child: rowBuffer[index],
                      ),
                    );
                  }),
                ),
              );
              widgets.add(pw.SizedBox(height: 6)); // Reduced space between rows
              rowBuffer.clear();
            }
          }
        }

        return widgets;
      },
    ),
  );

  Uint8List pdfBytes = await pdf.save();

  final blob = html.Blob([pdfBytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..target = 'blank'
    ..download = '${pdfHeader.toLowerCase().replaceAll(" ", "_")}.pdf'
    ..click();
  html.Url.revokeObjectUrl(url);
}

class PdfGeneratorAsTable {
  static Future<void> generateRakeConsistPDF(
    String header,
    List<dynamic> data, {
    List<String> excludedFields = const [],
  }) async {
    final pdf = pw.Document();

    if (data.isEmpty) return;

    // Get the first row's keys for headers
    final firstRow = data.first as Map<String, dynamic>;
    final headers = firstRow.keys
        .where((key) => !excludedFields.contains(key))
        .toList();

    // Format headers
    List<String> formattedHeaders = headers.map((key) {
      return key
          .replaceAll('_', ' ')
          .split(' ')
          .map(
            (word) => word.isNotEmpty
                ? '${word[0].toUpperCase()}${word.substring(1)}'
                : '',
          )
          .join(' ');
    }).toList();

    // Build rows
    final List<List<String>> tableData = data.map<List<String>>((row) {
      final mapRow = row as Map<String, dynamic>;
      return headers.map((key) => _formatValue(mapRow[key])).toList();
    }).toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Center(
            child: pw.Text(
              header,
              style: pw.TextStyle(
                fontSize: 26,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.blue900,
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            border: pw.TableBorder.all(color: PdfColors.grey),
            cellAlignment: pw.Alignment.centerLeft,
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.blue),
            headers: formattedHeaders,
            data: tableData,
            cellStyle: const pw.TextStyle(fontSize: 10),
          ),
        ],
      ),
    );

    final Uint8List pdfBytes = await pdf.save();

    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = '${header.toLowerCase().replaceAll(" ", "_")}.pdf'
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  static String _formatValue(dynamic value) {
    if (value == null) return '-';
    final stringVal = value.toString().trim();
    return stringVal.isEmpty ? '-' : stringVal;
  }
}
