import 'package:coachmaster/features/coach_purification/controllers/coach_purification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_function/widgets/header.dart';
import '../models/coach_purification_model.dart';

class CoachPurificationView extends StatelessWidget {
  CoachPurificationView({super.key});

  final CoachPurificationController controller = Get.put(CoachPurificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildHeader(
            context,
            'Coach Purification',
            Icons.directions_bus,
            false,
            false,
            null,
            null,
            null,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 250,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Coach No",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                    controller.applyFilter();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: _tableWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableWidget() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.filteredList.isEmpty) {
        return const Center(child: Text("No data available"));
      }

      return PaginatedDataTable(
        headingRowColor: MaterialStateColor.resolveWith(
              (states) => Colors.blue.shade100,
        ),
        columns: [
          DataColumn(label: textWidget("S.No.")),
          DataColumn(label: textWidget("Coach No.")),
          DataColumn(label: textWidget("Coach Type")),
          DataColumn(label: textWidget("Coach Category")),
          DataColumn(label: textWidget("Owning Rly")),
          DataColumn(label: textWidget("Depot")),
          DataColumn(label: textWidget("Division")),
          DataColumn(label: textWidget("Zone")),
          DataColumn(label: textWidget("Approved Status")),
          DataColumn(label: textWidget("Approved By")),
          DataColumn(label: textWidget("Rejection Remark")),
        ],
        source: CoachDataSource(controller.filteredList.toList()),
        rowsPerPage: controller.filteredList.length < 10
            ? controller.filteredList.length
            : 10,
        columnSpacing: 20,
        horizontalMargin: 10,
        showCheckboxColumn: false,
        dividerThickness: 1,
      );
    });
  }


  Widget textWidget(String text) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.bold));
  }
}

class CoachDataSource extends DataTableSource {
  final List<CoachPurificationModel> data;
  CoachDataSource(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final coach = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${index + 1}")), // Serial No.
        DataCell(Text(coach.coachNo ?? "")),
        DataCell(Text(coach.coachType ?? "")),
        DataCell(Text(coach.coachCategory ?? "")),
        DataCell(Text(coach.owningRly ?? "")),
        DataCell(Text(coach.depot ?? "")),
        DataCell(Text(coach.division ?? "")),
        DataCell(Text(coach.zone ?? "")),
        DataCell(Text(coach.approvedStatus ?? "")),
        DataCell(Text(coach.approvedBy ?? "")),
        DataCell(Text(coach.rejectionRemarks ?? "")),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
