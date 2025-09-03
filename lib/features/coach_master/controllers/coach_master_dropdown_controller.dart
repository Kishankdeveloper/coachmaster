import 'package:get/get.dart';

import '../../../service/master_services.dart';

class CoachMasterDropDownData extends GetxController {
  var isLoading = false.obs;
  final utilityType = [].obs;
  final coachKind = [].obs;
  final propulsionType = [].obs;
  final propulsionMake = [].obs;
  final emuMaintType = [].obs;
  final emuManufacturer = [].obs;
  final emuShed = [].obs;
  final emuCodalLife = ["25", "30", "35", "40"].obs;
  final emuSpeed = ["100", "110", "120", "130", "160"].obs;
  final emuPowerGeneration = [].obs;
  final services = Get.put(MasterServices());

  @override
  void onInit() {
    super.onInit();
    fetchMasterData();
  }

  void fetchMasterData() async {
    isLoading.value = true;
    print('called............................................');
    try {
      try {
        final data = await services.getEmuData(fieldType: 'UTILITY_TYPE');
        utilityType.value = data
            .map((e) => e['fieldValue'].toString())
            .toList();
      } catch (e) {
        print('UTILITY_TYPE not fetched');
      }
      try {
        final data = await services.getEmuData(fieldType: 'COACH_KIND');
        coachKind.value = data.map((e) => e['fieldValue'].toString()).toList();
      } catch (e) {
        print('COACH_KIND not fetched');
      }
      try {
        final data = await services.getEmuData(fieldType: 'PROPULSTION_TYPE');
        propulsionType.value = data
            .map((e) => e['fieldValue'].toString())
            .toList();
      } catch (e) {
        print('PROPULSTION_TYPE not fetched');
      }
      try {
        final data = await services.getEmuData(fieldType: 'PROPULSTION_MAKE');
        propulsionMake.value = data
            .map((e) => e['fieldValue'].toString())
            .toList();
      } catch (e) {
        print('PROPULSTION_MAKE not fetched');
      }
      try {
        final data = await services.getEmuData(fieldType: 'EMU_MAINT_TYPE');
        emuMaintType.value = data
            .map((e) => e['fieldValue'].toString())
            .toList();
      } catch (e) {
        print('EMU_MAINT_TYPE not fetched');
      }
      try {
        final data = await services.getManufacturerList(fieldType: 'BOGIE');
        emuManufacturer.value = data.map((e) => e.toString()).toList();
      } catch (e) {
        print('BOGIE not fetched');
      }

      try {
      //  final data = await services.getEmuShed(fieldType: 'CS');
        final data = await services.getEmuDepotORShed();

        emuShed.value = data.map((e) => e['orgCode'].toString()).toList();
      } catch (e) {
        print('EMU SHED not fetched');
      }

      try {
        final data = await services.getEmuData(
          fieldType: 'POWER_GENERATION_TYPE',
        );
        emuPowerGeneration.value = data
            .map((e) => e['fieldValue'].toString())
            .toList();
      } catch (e) {
        print('EMU_MAINT_TYPE not fetched');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
