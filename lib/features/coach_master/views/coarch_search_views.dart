import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../controllers/coach_master_search_controller.dart';

class CoachSearchPopup extends StatelessWidget {
  CoachSearchPopup({super.key});

  final TextEditingController searchController = TextEditingController();
  final CoachMasterControllerForSearch controller = Get.put(
    CoachMasterControllerForSearch(),
  );

  @override
  Widget build(BuildContext context) {
    final double popupWidth = MediaQuery.of(context).size.width * 0.9;
    final double popupHeight = MediaQuery.of(context).size.height * 0.85;

    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
        width: popupWidth,
        height: popupHeight,
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.blueGrey.shade50,
              width: double.infinity,
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.blueGrey),
                  const SizedBox(width: 8),
                  const Text(
                    "Search Coach Master",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Enter Coach No",
                        prefixIcon: const Icon(Icons.directions_bus),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      onSubmitted: (value) => controller.searchCoach(value),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.search),
                    label: const Text("Search"),
                    onPressed: () =>
                        controller.searchCoach(searchController.text),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Grid or message
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!controller.hasSearched.value) {
                    return const SizedBox(); // Show nothing before first search
                  }

                  if (controller.searchResults.isEmpty) {
                    return Center(
                      child: Text(
                        'Coach number not found.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade600,
                        ),
                      ),
                    );
                  }

                  return PlutoGrid(
                    columns: controller.columns,
                    rows: controller.searchResults,
                    onLoaded: (event) =>
                        event.stateManager.setShowColumnFilter(true),
                    configuration: PlutoGridConfiguration(
                      style: PlutoGridStyleConfig(
                        activatedBorderColor: Colors.blueGrey,
                        gridBorderColor: Colors.grey.shade300,
                        rowHeight: 40,
                        columnHeight: 45,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
