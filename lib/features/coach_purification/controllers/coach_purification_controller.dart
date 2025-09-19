import 'package:coachmaster/features/coach_purification/models/coach_purification_model.dart';
import 'package:get/get.dart';
import '../../../common_function/user_info.dart';
import '../../../service/master_services.dart';
import '../../coach_master/models/coach_master_models.dart';

class CoachPurificationController extends GetxController {
  var isLoading = false.obs;
  final UserInfo userInfo = Get.find();
  RxString searchQuery = "".obs;
  RxList<CoachPurificationModel> coachPList = <CoachPurificationModel>[].obs;
  RxList<CoachPurificationModel> filteredList = <CoachPurificationModel>[].obs;
  RxList<EmuCoachMaster> coachList = <EmuCoachMaster>[].obs;
  final services = Get.put(MasterServices());


  @override
  void onInit() {
    fetchPurificationData();
    super.onInit();
  }

  void fetchPurificationData() async {
    isLoading.value = true;
    try {
      final data = await services.fetchCoachPurificationList();
      coachPList.assignAll(data);
      filteredList.assignAll(data);
    } catch (e) {
      Get.snackbar("Error", "Failed to load Coach List" );
    } finally {
      isLoading.value = false;
    }
  }

  Future<EmuCoachMaster?> fetchCoachImage(int coachId) async {
    isLoading.value = true;
    try {
      final data = await services.fetchCoachMasterByCoachID(coachId: coachId.toString());
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

  void applyFilter() {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      filteredList.value = coachPList;
    } else {
      filteredList.value = coachPList.where((coach) {
        return coach.coachNo?.toLowerCase().contains(query) ?? false;
      }).toList();
    }
  }
}