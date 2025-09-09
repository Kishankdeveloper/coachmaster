import 'dart:convert';
import 'package:coachmaster/features/coach_purification/models/coach_purification_model.dart';
import 'package:get/get.dart';
import '../features/coach_master/models/coach_details_by_depot.dart';
import '../features/coach_master/models/coach_master_models.dart';
import '../features/login_from_cdmm/controllers/api_client.dart';
import '../features/login_from_cdmm/controllers/authenticator.dart';

const String baseUrl = 'https://roams.cris.org.in/emumaintenanceservices/';

class MasterServices extends GetConnect {
  final userAuthenticator = Get.find<UserAuthenticator>();
  final api = Get.put(ApiClient());
  final apiFull = Get.put(ApiClientFullUrl());

  Future<List<EmuCoachMaster>> fetchCoachMaster({String? depot}) async {
    final response = await api.get('coachmaster/coachDetails?depot=$depot');
    if (response.statusCode == 401) {
      Future.microtask(() {
        if (Get.currentRoute != '/session-expired') {
          Get.offAllNamed('/session-expired');
        }
      });
      throw Exception("Session Expires");
    }

    if (response.statusCode == 200 && response.body is List) {
      final List data = response.body as List;
      return data.map((e) => EmuCoachMaster.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return <EmuCoachMaster>[];
    } else {
      throw Exception("Failed to load Coach Data:");
    }
  }

  Future<List<EmuCoachMaster>> fetchCoachMasterByCoachNumber({
    String? coachNo,
  }) async {
    final response = await api.get('coachmaster/emu/$coachNo');

    if (response.statusCode == 401) {
      Future.microtask(() {
        if (Get.currentRoute != '/session-expired') {
          Get.offAllNamed('/session-expired');
        }
      });
      throw Exception("Session Expires");
    }
    if (response.statusCode == 200 && response.body is Map) {
      final data = response.body as Map<String, dynamic>;
      return [EmuCoachMaster.fromJson(data)];
    } else if (response.statusCode == 404) {
      return <EmuCoachMaster>[];
    } else {
      throw Exception("Failed to load Coach Data:");
    }
  }

  Future<int?> saveCoach({Map? input}) async {
    final response = await api.post('emumaintenance/saveOrUpdate', input);
    return response.statusCode;
  }

  Future<List<Map<String, dynamic>>> getEmuShed({String? fieldType}) async {
    {
      final response = await apiFull.get(
        'https://roams.cris.org.in/coachmaster/coachmaster/getCmmMaintenanceLocationDetailsReport?locType=$fieldType',
      );
      List<Map<String, dynamic>> responseData = [];
      if (response.statusCode == 200) {
        if (response.body != null) {
          responseData = List<Map<String, dynamic>>.from(response.body);
        }
        return responseData;
      } else {
        throw Exception("Failed to load Master Data:");
      }
    }
  }

  // new owning shed API -- integrated by kishan kumar --
  Future<List<Map<String, dynamic>>> getEmuDepotORShed() async {
    {
      final response = await apiFull.get(
        'https://roams.cris.org.in/emumaintenanceservices/fmmOrg/filter?orgType=CD',
      );
      List<Map<String, dynamic>> responseData = [];
      if (response.statusCode == 200) {
        if (response.body != null) {
          responseData = List<Map<String, dynamic>>.from(response.body);
        }
        return responseData;
      } else {
        throw Exception("Failed to load Master Data:");
      }
    }
  }

  Future<List<String>> getManufacturerList({String? fieldType}) async {
    {
      final response = await apiFull.get(
        'https://roams.cris.org.in/coachmaster/cmmBogieDrive/getBogieManufacturerList?assemblyType=$fieldType',
      );
      List<String> responseData = [];
      if (response.statusCode == 200) {
        if (response.body != null) {
          responseData = List<String>.from(response.body);
        }
        return responseData;
      } else {
        throw Exception("Failed to load Bogie Data:");
      }
    }
  }

  Future<List<Map<String, dynamic>>> getEmuData({String? fieldType}) async {
    {
      final response = await apiFull.get(
        'https://roams.cris.org.in/coachmaster/coachmaster/getMasterValueList?fieldName=$fieldType',
      );
      List<Map<String, dynamic>> responseData = [];
      if (response.statusCode == 200) {
        if (response.body != null) {
          responseData = List<Map<String, dynamic>>.from(response.body);
        }
        return responseData;
      } else {
        throw Exception("Failed to load Master Data:");
      }
    }
  }

  Future<List<EmuCoachByDepo>> fetchCoachMasterByDepot({String? depot}) async {
    final response = await api.get(
      'coachmaster/getCoachDetailsByDepot?depot=$depot',
    );
    if (response.statusCode == 401) {
      Future.microtask(() {
        if (Get.currentRoute != '/session-expired') {
          Get.offAllNamed('/session-expired');
        }
      });
      throw Exception("Session Expires");
    }

    if (response.statusCode == 200 && response.body is List) {
      final List data = response.body as List;
      return data.map((e) => EmuCoachByDepo.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return <EmuCoachByDepo>[];
    } else {
      throw Exception("Failed to load Coach Data:");
    }
  }

  Future<List<EmuCoachMaster>> fetchCoachMasterByCoachID({
    String? coachId,
  }) async {
    final response = await api.get(
      'coachmaster/getCoachDetailsByCoachId/$coachId',
    );

    if (response.statusCode == 401) {
      Future.microtask(() {
        if (Get.currentRoute != '/session-expired') {
          Get.offAllNamed('/session-expired');
        }
      });
      throw Exception("Session Expires");
    }
    if (response.statusCode == 200 && response.body is Map) {
      final data = response.body as Map<String, dynamic>;
      return [EmuCoachMaster.fromJson(data)];
    } else if (response.statusCode == 404) {
      return <EmuCoachMaster>[];
    } else {
      throw Exception("Failed to load Coach Data:");
    }
  }

  Future<List<CoachPurificationModel>> fetchCoachPurificationList() async {
    final response = await api.get('coachPurification/list');

    if (response.statusCode == 401) {
      Future.microtask(() {
        if (Get.currentRoute != '/session-expired') {
          Get.offAllNamed('/session-expired');
        }
      });
      throw Exception("Session Expires");
    }
    if (response.statusCode == 200 && response.body is List) {
      final List data = response.body as List;
      return data.map((e) => CoachPurificationModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return <CoachPurificationModel>[];
    } else {
      throw Exception("Failed to load Coach Data:");
    }
  }

}
