import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_function/display_items.dart';
import '../../../common_function/widgets/info_rows.dart';
import '../controllers/coach_master_controller.dart';

class CoachCardGrid extends StatelessWidget {
  final CoachMasterController controller = Get.find<CoachMasterController>();
  CoachCardGrid({super.key});
  final List<Color> cardColors = [
    Color(0xFFE3F2FD), // Light Blue
    Color(0xFFF1F8E9), // Light Green
    Color(0xFFFFF3E0), // Light Orange
    Color(0xFFF3E5F5), // Light Purple
    Color(0xFFFFEBEE), // Light Red
    Color(0xFFE0F7FA), // Light Cyan
    Color(0xFFFFFDE7), // Light Yellow
    Color(0xFFE8F5E9), // Light Mint
    Color(0xFFFBE9E7), // Light Peach
    Color(0xFFECEFF1), // Cool  Grey
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                final categories = ["ALL", "MEMU", "DEMU", "EMU"];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: categories.map((cat) {
                    final isSelected = controller.selectedCategory.value == cat;
                    return GestureDetector(
                      onTap: () => controller.setCategory(cat),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.deepPurple : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? Colors.deepPurple : Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: AutoSizeText(
                          cat,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 10
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 220,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        hintText: 'Search Coach No...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        isDense: true,
                        prefixIcon: Icon(Icons.search, size: 20),
                      ),
                      onChanged: (value) => controller.searchQuery.value = value.trim().toLowerCase(),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Note: For only for EMU, MEMU and DEMU", style: TextStyle(fontStyle: FontStyle.italic),),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            final filtered = controller.allcoachList.where((coach) {
              final matchesSearch = coach.coachNo
                  .toLowerCase()
                  .contains(controller.searchQuery.value);

              final matchesCategory = controller.selectedCategory.value == "ALL" ||
                  coach.coachCategory.toUpperCase() ==
                      controller.selectedCategory.value;

              return matchesSearch && matchesCategory;
            }).toList();


            if (filtered.isEmpty) {
              return Center(
                child: Text(
                  "No coach found for your Shed",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  itemCount: filtered.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 330,
                    mainAxisExtent: 210,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final coach = filtered[index];
                    final cardColor = cardColors[index % cardColors.length];
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => controller.hoveredIndex.value = index,
                      onExit: (_) => controller.hoveredIndex.value = -1,
                      child: GestureDetector(
                        onTap: () => controller.onCoachCardTap(coach.coachId),
                        child: Card(
                          color: cardColor,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        getCoachImage(coach.utilityType),
                                        width: 70,
                                        height: 50,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        coach.coachNo,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF263238),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InfoRow("Owning Rly:", coach.owningRly),
                                      InfoRow("Coach Type:", coach.coachType),
                                      InfoRow("Coach Category:", coach.coachCategory,),
                                      InfoRow("Power Generation Type:", coach.powerGenerationType),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
