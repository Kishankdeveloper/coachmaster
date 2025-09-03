import 'package:coachmaster/features/login_from_cdmm/controllers/storage_constants.dart';
import 'package:coachmaster/features/login_from_cdmm/controllers/token.dart';
import 'package:logger/logger.dart';
import 'base_storage_provider.dart';
import 'logger.dart';

class AuthLocalStorageProvider extends BaseStorageProvider {
  @override
  final Logger logger = getLogger((AuthLocalStorageProvider).toString());

  AuthLocalStorageProvider({required super.secureStorage});

  Future<void> persistToken(Token token) async {
    var cmmBox = await initBox();
    await cmmBox.put(StorageConstants.tokenKey, token.toMap());

    cmmBox.close();
  }

  Future<void> updateToken(Token token) async {
    var cmmBox = await getBox();
    await cmmBox.put(StorageConstants.tokenKey, token.toMap());

    cmmBox.close();
  }

  Future<Token> retrieveToken() async {
    final cmmBox = await getBox();

    var t = cmmBox.get(StorageConstants.tokenKey);

    Token token = Token.fromMap(t);

    cmmBox.close();
    print("## Hello I'm returing token---------> $token >>>>>>>>>>>>>");
    return token;
  }

  Future<void> deleteToken() async {
    await super.deleteBox();
  }
}
