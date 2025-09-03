import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:html' as html;

import '../../../common_function/display_items.dart';
import '../../../common_function/export_pdf.dart';
import '../../../common_function/widgets/base64ToImage.dart';
import '../../../common_function/widgets/header.dart';
import '../../login_from_cdmm/controllers/token.dart';
import '../controllers/coach_master_controller.dart';
import '../controllers/coach_master_dropdown_controller.dart';

class CoachDetailsPage extends StatelessWidget {
  final CoachMasterController controller = Get.find<CoachMasterController>();
  final CoachMasterDropDownData dropdownController = Get.put(
    CoachMasterDropDownData(),
  );
  CoachDetailsPage({super.key});

  String? getFieldValue(dynamic model, String fieldName) {
    try {
      final Map<String, dynamic> map = extractFields(model);
      return map[fieldName]?.toString();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dynamic model = Get.arguments;

    // Extract optional lists
    final List<String> hiddenFields =
        model is Map && model.containsKey('hiddenFields')
        ? List<String>.from(model['hiddenFields'])
        : [];

    final List<String> imageFields =
        model is Map && model.containsKey('imageFields')
        ? List<String>.from(model['imageFields'])
        : [];

    final List<String> imageBase64Fields =
        model is Map && model.containsKey('imageBase64Fields')
        ? List<String>.from(model['imageBase64Fields'])
        : [];

    // Extract actual model (EmuCoachMaster)
    final dynamic actualModel = model is Map && model.containsKey('model')
        ? model['model']
        : model;

    // Get all fields except hidden ones
    final Map<String, dynamic> fields = extractFields(actualModel)
      ..removeWhere((key, _) => hiddenFields.contains(key));

    // Prepare image list
    final List<Base64ImageWithTitle> imageList = [];

    for (int i = 0; i < imageFields.length; i++) {
      final String imageField = imageFields[i];
      final String base64Field = imageBase64Fields.length > i
          ? imageBase64Fields[i]
          : '';

      final String title = imageField;
      final String? base64Data = getFieldValue(actualModel, base64Field);

      if (base64Data != null && base64Data.isNotEmpty) {
        imageList.add(
          Base64ImageWithTitle(base64Data: base64Data, title: title),
        );
      }
    }
    // const String redDotBase64 =
    //     'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/wIAAgMBApWFC0kAAAAASUVORK5CYII=';

    // imageList.add(
    //   Base64ImageWithTitle(base64Data: redDotBase64, title: "Test Data"),
    // );
    // print(imageList);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(
              context,
              'Coach Details',
              Icons.directions_bus,
              true,
              true,
              actualModel,
              () {
                controller.openAddEditCoachDetailsPopup(coach: actualModel);
              },
              () {
                exportToPdfCommanToView(
                  actualModel.toJson(),
                  "Coach Master Details",
                  excludedFields: [
                    "coachId",
                    "coachNoWithOwningRlyImage",
                    "coachTypeImage",
                    "coachProImage",
                    "otherBuiltPageImage",
                    "fileDataBase64ForEmuFrontImage",
                    "fileDataBase64ForEmuBackImage",
                    "fileDataBase64ForEmuEndPannelImage",
                    "fileDataBase64ForEmuBuiltPlateImage",
                  ],
                );
              },
              onOpenWindow: () async {
                final Token token = await controller.services.userAuthenticator.getValidTokenRefreshIfExpired();
                html.window.open(
                  'https://prodmcf.indianrailways.gov.in/MCFRBL/rollingStockCertificateCMM?coachNo=${actualModel.coachNo}&authToken=${token.access_token}',
                  '_blank',
                );
              },
            ),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isSmallScreen = constraints.maxWidth < 600;
                        final boxWidth = isSmallScreen
                            ? constraints.maxWidth
                            : (constraints.maxWidth / 3) - 24;

                        return Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: fields.entries.map((entry) {
                            return buildInfoCard(
                              keyLabel: beautifyKey(entry.key),
                              valueLabel: stringifyValue(entry.value),
                              width: boxWidth,
                            );
                          }).toList(),
                        );
                      },
                    ),

                    // const SizedBox(height: 16),

                    // // Uploaded Images Section Title
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Text(
                    //       "Uploaded Images",
                    //       style: Theme.of(context).textTheme.titleMedium
                    //           ?.copyWith(
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.blueGrey[800],
                    //           ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 16),

                    // Image Grid or "No image uploaded"
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: imageList.isNotEmpty
                          ? Base64ImageGrid(images: imageList)
                          : Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Text(
                                "No image uploaded",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
