import 'dart:convert';
import 'package:coachmaster/features/login_from_cdmm/controllers/token.dart';
import 'package:jose/jose.dart';
import '../../../common_function/user_info.dart';
import '../errors/exceptions.dart';

class JwtHelper {
  final _key =
      'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApLUByBCh94oMXBJMceoeJuoLt8+VyOq2Nd/nY7xmuLFkRGLiniXlt/hPBTUuKXgU6qCteMPwF0CAAAvvBlabQNsWYXaPCY2VNv2GYBDTF4mxNF75FImFAl/R8QlzuDvU0NiBjQjHXk6yVdDhgQecnXyqHBEIsJuJyHVtimo7xsBDkryUqRLLOZvXvgpH6oftQ5c4fHCv6Zo6R8y1mXlm1BcMneLEsr3zpnM2HUYKwdHTKfpUq93s4YQ54YXzh2KMhkFCFtxyItIHXEEAIUsxZxLB2Hi+uvEhdPy7gFW0BiBDGWHNM0EZ88ZAH4EUg/0qL/b+bkIIF/uGyMejMfqS4QIDAQAB';
  JsonWebKeyStore? _keyStore;

  JwtHelper() {
    final key = base64.encode(utf8.encode(_key));
    _keyStore = JsonWebKeyStore()
      ..addKey(JsonWebKey.fromJson({"kty": "oct", "k": key, "algo": "RSA256"}));
  }

  Future<bool> isTokenValid(String tokenValue) async {
    var jwt = JsonWebToken.unverified(tokenValue);
    // var verified = await jwt.verify(
    // _keyStore!); //Result not currently being used as cannot be verified.
    return jwt.claims.validate().isEmpty;
  }

  /// Returns user information from [token] or throws [TokenVerificationException]
  Future<UserInfo?> decodeAndVerifyToken(Token token) async {
    try {
      var jwt = JsonWebToken.unverified(
        token.access_token!,
      ); //signature verification to be added.
      var validate = jwt.claims.validate();
      if (validate.isNotEmpty) {
        throw TokenVerificationException(
          message:
              'Token verification failed due: ${(validate.first as JoseException).message}',
        );
      }
      var userInfo = UserInfo.fromMap(jwt.claims.toJson());
      return userInfo;
    } on JoseException catch (e) {
      throw TokenVerificationException(
        message: 'Token verification failed due: ${e.message}',
      );
    }
  }
}
