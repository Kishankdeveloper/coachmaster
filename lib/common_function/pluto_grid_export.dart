import 'dart:html' as html;
import 'package:pdf/pdf.dart'; // Ensure this import is added
import 'package:pdf/widgets.dart' as pw;
import 'package:pluto_grid/pluto_grid.dart';

class PlutoGridExporter {
  /// Export PlutoGrid to CSV (Excel-compatible) with columns to exclude
  static void exportToCsv({
    required PlutoGridStateManager stateManager,
    String fileName = 'pluto_export',
    List<String> columnsToExclude = const [],
    String moduleName = 'pluto_export', // Columns to exclude from export
  }) {
    final columns = stateManager.columns
        .where(
          (column) => !columnsToExclude.contains(column.field),
        ) // Exclude specified columns
        .toList();
    final rows = stateManager.rows;

    final buffer = StringBuffer();

    // Add a fixed header
    buffer.writeln(moduleName);

    // Add empty line after the fixed header
    buffer.writeln();

    // Add table headers
    buffer.writeln(columns.map((c) => c.title).join(','));

    // Add rows
    for (final row in rows) {
      final values = columns
          .map((c) => '"${row.cells[c.field]?.value}"')
          .join(',');
      buffer.writeln(values);
    }

    final blob = html.Blob([buffer.toString()], 'text/csv');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', '$fileName.csv')
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  /// Export PlutoGrid to PDF with landscape orientation, smaller text size, and columns to exclude
  static Future<void> exportToPdf({
    required PlutoGridStateManager stateManager,
    String fileName = 'pluto_export',
    bool isLandscape = true, // Default to landscape orientation
    double fontSize = 8.0, // Smaller text size for PDF
    List<String> columnsToExclude = const [],
    String moduleName = 'pluto_export', // Columns to exclude from export
  }) async {
    final pdf = pw.Document();

    final columns = stateManager.columns
        .where(
          (column) => !columnsToExclude.contains(column.field),
        ) // Exclude specified columns
        .toList();
    final rows = stateManager.rows;

    final headers = columns.map((c) => c.title).toList();

    final data = rows.map((row) {
      return columns
          .map((c) => row.cells[c.field]?.value.toString() ?? '')
          .toList();
    }).toList();

    // Set the PDF page format to landscape
    final pageFormat = isLandscape
        ? PdfPageFormat
              .a4
              .landscape // Landscape format
        : PdfPageFormat.a4; // Portrait format

    pdf.addPage(
      pw.Page(
        pageFormat: pageFormat,
        build: (context) {
          return pw.Column(
            children: [
              // Add a fixed header at the top
              pw.Text(
                moduleName,
                style: pw.TextStyle(
                  fontSize: 18, // Adjust font size
                  fontWeight: pw.FontWeight.bold, // Make it bold
                ),
              ),
              pw.SizedBox(height: 10), // Space after the header
              // Add table
              pw.Table.fromTextArray(
                headers: headers,
                data: data,
                headerStyle: pw.TextStyle(
                  fontSize: fontSize,
                ), // Smaller text size for header
                cellStyle: pw.TextStyle(
                  fontSize: fontSize,
                ), // Smaller text size for cells
              ),
            ],
          );
        },
      ),
    );

    final pdfBytes = await pdf.save();
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', '$fileName.pdf')
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
