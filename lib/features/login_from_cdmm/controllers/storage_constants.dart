import 'package:hive/hive.dart';

class StorageConstants {
  // ignore: non_constant_identifier_names
  static final secureKey = Hive.generateSecureKey();
  static const secureStorageHiveKey = 'HiveKey';
  static const cmmStorageBox = 'cmm_storage';
  static const tokenKey = 'USER_TOKEN';
}
