import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../service/master_services.dart';
import '../models/coach_master_models.dart';

class CoachMasterControllerForSearch extends GetxController {
  final services = Get.put(MasterServices());

  var coachList = <EmuCoachMaster>[].obs; // Original API data
  var searchResults = <PlutoRow>[].obs;
  var isLoading = false.obs;
  var hasSearched = false.obs;

  late List<PlutoColumn> columns;

  CoachMasterControllerForSearch() {
    columns = _getColumns();
  }
  @override
  void onInit() {
    super.onInit();
    coachList.value = [];
  }

  void searchCoach(String query) async {
    isLoading.value = true;
    hasSearched.value = true;

    try {
      final data = await services.fetchCoachMasterByCoachNumber(coachNo: query);
      coachList.clear();
      coachList.assignAll(data);
      // final filteredList = coachList.where((u) {
      //   final value = u.coachNo?.toLowerCase() ?? '';
      //   return value.contains(query.toLowerCase());
      // }).toList();

      searchResults.assignAll(
        coachList.map((u) {
          return PlutoRow(
            cells: {
              'edit': PlutoCell(value: u),
              'coach_no': PlutoCell(value: u.coachNo ?? ''),
              'owning_rly': PlutoCell(value: u.owningRly ?? ''),
              'coach_type': PlutoCell(value: u.coachType ?? ''),
              'coach_kind': PlutoCell(value: u.coachKind ?? ''),
              'coach_category': PlutoCell(value: u.coachCategory ?? ''),
              'power_generation_type': PlutoCell(
                value: u.powerGenerationType ?? '',
              ),
           //   'unit_no': PlutoCell(value: u.unitNo ?? ''),
              'local_coach_no': PlutoCell(value: u.localCoachNo ?? ''),
              'manufacturer': PlutoCell(value: u.manufacturer ?? ''),
              'maint_type': PlutoCell(value: u.maintType ?? ''),
            //  'owning_shed': PlutoCell(value: u.owningShed ?? ''),
            },
          );
        }).toList(),
      );
    } finally {
      coachList.clear();
      refreshPlutoGrid();
      isLoading.value = false;
    }
  }

  List<PlutoColumn> _getColumns() {
    return [
      PlutoColumn(
        title: 'Edit',
        field: 'edit',
        type: PlutoColumnType.text(),
        renderer: (ctx) {
          final coach = ctx.row.cells['edit']!.value;
          return IconButton(
            icon: const Icon(Icons.remove_red_eye, color: Colors.blueGrey),
            onPressed: () async {
              Get.back();
              await openAddEditCoachPopup(coach: coach);
              refreshPlutoGrid();
              searchCoach(coach.coachNo ?? '');
            },
          );
        },
      ),
      PlutoColumn(
        title: 'Coach No',
        field: 'coach_no',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Owning Rly',
        field: 'owning_rly',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Coach Type',
        field: 'coach_type',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Coach Kind',
        field: 'coach_kind',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Coach Category',
        field: 'coach_category',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Power Gen Type',
        field: 'power_generation_type',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Unit No',
        field: 'unit_no',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Local Coach No',
        field: 'local_coach_no',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Manufacturer',
        field: 'manufacturer',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Maint Type',
        field: 'maint_type',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Owning Shed',
        field: 'owning_shed',
        type: PlutoColumnType.text(),
      ),
    ];
  }

  void refreshPlutoGrid() {
    update();
  }

  Future<void> openAddEditCoachPopup({required EmuCoachMaster coach}) async {
    Get.toNamed(
      '/coachMaster/coachDetails',
      arguments: {
        "model": coach,
        "hiddenFields": [
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
        "imageFields": [
          "coachNoWithOwningRlyImage",
          "coachTypeImage",
          "coachProImage",
          "otherBuiltPageImage",
        ],
        "imageBase64Fields": [
          "fileDataBase64ForEmuFrontImage",
          "fileDataBase64ForEmuBackImage",
          "fileDataBase64ForEmuEndPannelImage",
          "fileDataBase64ForEmuBuiltPlateImage",
        ],
      },
    );
  }
}
