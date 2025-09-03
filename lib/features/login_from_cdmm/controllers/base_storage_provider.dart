import 'dart:convert';
import 'package:coachmaster/features/login_from_cdmm/controllers/storage_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

import 'logger.dart';

abstract class BaseStorageProvider {
  final Logger logger = getLogger((BaseStorageProvider).toString());
  final FlutterSecureStorage secureStorage;

  BaseStorageProvider({required this.secureStorage});

  Future<Box> initBox() async {
    await deleteBox();
    final secureKey = StorageConstants.secureKey;

    var cmmBox = await Hive.openBox(
      StorageConstants.cmmStorageBox,
      encryptionCipher: HiveAesCipher(secureKey),
    );

    _writeSecureKey(secureKey);

    return cmmBox;
  }

  Future<Box> getBox() async {
    List<int> encryptionKey = await _readSecureKey();
    final cmmBox = await Hive.openBox(
      StorageConstants.cmmStorageBox,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    return cmmBox;
  }

  Future<void> deleteBox() async {
    if (await Hive.boxExists(StorageConstants.cmmStorageBox)) {
      await Hive.deleteBoxFromDisk(StorageConstants.cmmStorageBox);
    }
  }

  Future<void> _writeSecureKey(List<int> secureKey) async {
    secureStorage.write(
      key: StorageConstants.secureStorageHiveKey,
      value: json.encode(secureKey),
    );
  }

  Future<List<int>> _readSecureKey() async {
    var secureKey = await secureStorage.read(
      key: StorageConstants.secureStorageHiveKey,
    );

    List<int> encryptionKey;
    if (secureKey != null) {
      encryptionKey = (json.decode(secureKey) as List<dynamic>).cast<int>();
    } else {
      encryptionKey = StorageConstants.secureKey;
    }

    return encryptionKey;
  }
}
