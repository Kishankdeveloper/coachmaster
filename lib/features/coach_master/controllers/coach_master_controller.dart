import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../common_function/custom_snackbar.dart';
import '../../../common_function/user_info.dart';
import '../../../service/master_services.dart';
import '../../login_from_cdmm/controllers/token.dart';
import '../models/coach_details_by_depot.dart';
import '../models/coach_master_models.dart';
import '../views/coach_master_views.dart';

class CoachMasterController extends GetxController {
  var isLoading = false.obs;
  final UserInfo userInfo = Get.find();
  RxList<EmuCoachMaster> coachList = <EmuCoachMaster>[].obs;

  RxList<EmuCoachByDepo> allcoachList = <EmuCoachByDepo>[].obs;

  final RxString searchQuery = ''.obs;
  final hoveredIndex = (-1).obs;
  var selectedCategory = 'ALL'.obs;

  PlutoGridStateManager? gridStateManager;
  final services = Get.put(MasterServices());
  // Rx Variables for all form fields
  var coachNo = RxnString();
  var coachType = RxnString();
  var owningRly = RxnString();
  var coachId = RxnInt();

  final unitNo = ''.obs;
  final localCoachNo = ''.obs;
  final tareWeight = ''.obs;
  final kmEarnedBuilt = ''.obs;
  final kmEarnedLastPoh = ''.obs;

  // Dropdowns
  final utilityType = RxnString();
  final coachKind = RxnString();
  final coachCategory = RxnString();
  final powerGenType = RxnString();
  final propulsionType = RxnString();
  final propulsionMake = RxnString();
  final manufacturer = RxnString();
  final maintType = RxnString();
  final owningShed = RxnString();
  final maintShed = RxnString();
  final bioToilet = RxnString();
  final acFlag = RxnString();
  final cctvAvailable = RxnString();
  final maxSpeed = RxnString();
  final codalLife = RxnString();

  // Dates
  final commissioningDate = Rxn<DateTime>();
  final builtDate = Rxn<DateTime>();
  final condemnationDate = Rxn<DateTime>();

  // Images
  final coachNoWithOwningRlyImage = RxnString();
  final coachTypeImage = RxnString();
  final coachProImage = RxnString();
  final otherBuiltPageImage = RxnString();

  final fileDataBase64ForEmuFrontImage = RxnString();
  final fileDataBase64ForEmuBackImage = RxnString();
  final fileDataBase64ForEmuEndPannelImage = RxnString();
  final fileDataBase64ForEmuBuiltPlateImage = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchMasterData();
  }

  void fetchMasterData() async {
    isLoading.value = true;
    try {
      final data = await services.fetchCoachMasterByDepot(
        depot: userInfo.depot,
      );
      allcoachList.assignAll(data);
    } catch (e) {
      Get.snackbar("Error", "Failed to load Coach List");
    } finally {
      isLoading.value = false;
    }
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  Future<EmuCoachMaster?> fetchMasterDataById(int coachId) async {
    isLoading.value = true;
    try {
      final data = await services.fetchCoachMasterByCoachID(
        coachId: coachId.toString(),
      );

      if (data.isNotEmpty) {
        coachList.assignAll(data);
        return data.first;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load Coach List");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  void saveCoach(Map<String, dynamic> data) async {
    try {
      final response = await services.saveCoach(input: data);
      Get.back();
      if (response == 200) {
        showCustomSnackbar("Coach saved/updated successfully.");
        await Future.delayed(Duration(seconds: 1));
        fetchMasterData();
        Get.back();
      } else {
        showCustomSnackbar("Internal server error");
      }
      // if (response.isNotEmpty) {
      //   int id = response['id'];
      //   EmuCoachMaster newCoach = EmuCoachMaster(
      //     coachId: id,
      //     coachNo: data['coachNo'] ?? '',
      //     owningRly: data['owningRly'],
      //     coachType: data['coachType'],
      //     coachKind: data['coachKind'],
      //     coachCategory: data['coachCategory'],
      //     powerGenerationType: data['powerGenerationType'],

      //     unitNo: data['unitNo'],
      //     localCoachNo: data['localCoachNo'],
      //     manufacturer: data['manufacturer'],
      //     maintType: data['maintType'],
      //     owningShed: data['owningShed'],
      //   );

      //   final index = coachList.indexWhere(
      //     (c) => c.coachNo == newCoach.coachNo,
      //   );
      //   if (index != -1) {
      //     coachList[index] = newCoach;
      //   } else {
      //     coachList.add(newCoach);
      //   }

      //   refreshPlutoGrid();
      //   showCustomSnackbar("Coach saved/updated successfully.");
      //   await Future.delayed(Duration(seconds: 1));
      //   Get.back();
      // } else {
      //   showCustomSnackbar(
      //     "Error: Failed to save/update coach.",
      //     bgColor: Colors.red,
      //   );
      // }
    } catch (e) {
      showCustomSnackbar(
        "Error: Failed to process coach data",
        bgColor: Colors.red,
      );
    }
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

  Future<void> openAddEditCoachDetailsPopup({
    required EmuCoachMaster coach,
  }) async {
    coachNo.value = coach.coachNo ?? '';
    owningRly.value = coach.owningRly ?? '';
    coachType.value = coach.coachType ?? '';
    // unitNo.value = coach.unitNo ?? '';
    localCoachNo.value = coach.localCoachNo ?? '';
    tareWeight.value = coach.tareWeight != null
        ? coach.tareWeight.toString()
        : '';
    kmEarnedBuilt.value = coach.kmEarnedBuilt != null
        ? coach.kmEarnedBuilt.toString()
        : '';
    kmEarnedLastPoh.value = coach.kmEarnedLastPoh != null
        ? coach.kmEarnedLastPoh.toString()
        : '';
    utilityType.value = coach.utilityType;
    coachKind.value = coach.coachKind;
    coachCategory.value = coach.coachCategory;
    powerGenType.value = coach.powerGenerationType;
    propulsionType.value = coach.propulsionType;
    propulsionMake.value = coach.propulsionMake;
    manufacturer.value = coach.manufacturer;
    maintType.value = coach.maintType;
    //owningShed.value = coach.owningShed;
    maintShed.value = coach.maintShed;
    bioToilet.value = coach.isBiotoiletAvailable;
    acFlag.value = coach.acFlag;
    cctvAvailable.value = coach.cctvAvailable;
    maxSpeed.value = coach.maxSpeed != null ? coach.maxSpeed.toString() : '';
    codalLife.value = coach.codalLife != null ? coach.codalLife.toString() : '';

    commissioningDate.value = coach.coachCommissionDate;
    builtDate.value = coach.builtDate;
    condemnationDate.value = coach.condemnationDate;

    coachNoWithOwningRlyImage.value = coach.coachNoWithOwningRlyImage;
    coachTypeImage.value = coach.coachTypeImage;
    coachProImage.value = coach.coachProImage;
    otherBuiltPageImage.value = coach.otherBuiltPageImage;

    fileDataBase64ForEmuFrontImage.value = coach.fileDataBase64ForEmuFrontImage;
    fileDataBase64ForEmuBackImage.value = coach.fileDataBase64ForEmuBackImage;
    fileDataBase64ForEmuEndPannelImage.value =
        coach.fileDataBase64ForEmuEndPannelImage;
    fileDataBase64ForEmuBuiltPlateImage.value =
        coach.fileDataBase64ForEmuBuiltPlateImage;

    coachId.value = coach.coachId;
    await Get.dialog(FeedbackFormPopup());
    coachType.value = null;
    coachNo.value = null;
    owningRly.value = null;
    coachId.value = null;
  }

  void clearForm() {
    coachNo.value = '';
    owningRly.value = '';
    coachType.value = '';
    unitNo.value = '';
    localCoachNo.value = '';
    tareWeight.value = '';
    kmEarnedBuilt.value = '';
    kmEarnedLastPoh.value = '';

    utilityType.value = null;
    coachKind.value = null;
    coachCategory.value = null;
    powerGenType.value = null;
    propulsionType.value = null;
    propulsionMake.value = null;
    manufacturer.value = null;
    maintType.value = null;
    owningShed.value = null;
    maintShed.value = null;
    bioToilet.value = null;
    acFlag.value = null;
    cctvAvailable.value = null;
    maxSpeed.value = null;
    codalLife.value = null;

    commissioningDate.value = null;
    builtDate.value = null;
    condemnationDate.value = null;

    coachNoWithOwningRlyImage.value = null;
    coachTypeImage.value = null;
    coachProImage.value = null;
    otherBuiltPageImage.value = null;

    fileDataBase64ForEmuFrontImage.value = null;
    fileDataBase64ForEmuBackImage.value = null;
    fileDataBase64ForEmuEndPannelImage.value = null;
    fileDataBase64ForEmuBuiltPlateImage.value = null;
  }

  void onCoachCardTap(int coachId) async {
    try {
      isLoading.value = true;

      final coach = await fetchMasterDataById(coachId);
      isLoading.value = false;

      if (coach != null) {
        await openAddEditCoachPopup(coach: coach);
      } else {
        Get.snackbar(
          "Error",
          "Coach not found.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Something went wrong!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
