import 'package:coachmaster/features/login_from_cdmm/controllers/token.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../common_function/user_info.dart';
import '../errors/exceptions.dart';
import '../errors/failures.dart';
import 'auth_local_storage_provider.dart';
import 'auth_provider.dart';
import 'jwt_helper.dart';
import 'logger.dart';
import 'login_request.dart';

/// Authentication service to check, login, and retrieve token
class UserAuthenticator {
  final AuthProvider authProvider;
  final AuthLocalStorageProvider localStorageProvider;
  final JwtHelper jwtHelper;
  final Logger logger = getLogger((UserAuthenticator).toString());
  UserAuthenticator({
    required this.authProvider,
    required this.localStorageProvider,
    required this.jwtHelper,
  });

  Future<Either<Failure, Token>> authenticate({
    required LoginRequest loginRequest,
  }) async {
    final result = await _authenticate(loginRequest);
    return result.fold((failure) => Left(failure), (token) async {
      try {
        await _initializeSession(token);
        localStorageProvider.persistToken(token);
        return Right(token);
      } on TokenVerificationException catch (e) {
        return Left(Failure(message: 'Failed due to ${e.message}'));
      }
    });
  }

  Future<Either<Failure, Token>> checkAuthentication() async {
    try {
      Token token = await localStorageProvider.retrieveToken();
      logger.d('token==>$token');
      if (token.access_token != null) {
        logger.d('1==>');
        Token? validToken = await _validAcessToken(token);
        logger.d('2==>');
        await _initializeSession(validToken);
        return Right(validToken);
      }
      return Left(Failure(message: 'No token found'));
    } on Exception catch (e) {
      return Left(Failure(message: 'Failed due to ${e.toString()}'));
    }
  }

  Future<Either<Failure, Token>> checkAuthenticationForCdmm(Token token) async {
    try {
      Token? validToken = await _validAcessToken(token);
      logger.d('valid token ====> $validToken');
      await _initializeSession(validToken);
      return Right(validToken);
    } on Exception catch (e) {
      return Left(Failure(message: 'Failed due to ${e.toString()}'));
    }
  }

  Future<Token> getValidTokenRefreshIfExpired() async {
    Token token = Get.find();
    return await _validAcessToken(token);
  }

  Future<void> deleteAuthentication() async {
    await Get.delete<UserInfo>(force: true);
    await Get.delete<Token>(force: true);
    return await localStorageProvider.deleteToken();
  }

  Future<Either<Failure, Token>> _authenticate(
    LoginRequest loginRequest,
  ) async {
    try {
      final response = await authProvider.authenticate(
        loginRequest: loginRequest,
      );
      if (response.statusCode == 200) {
        return Right(Token.fromMap(response.body));
      } else {
        return Left(
          Failure(
            message: 'Authentication Failed Error code ${response.statusCode}',
          ),
        );
      }
    } on Exception catch (e) {
      return Left(Failure(message: 'Authentication Failed ${e.toString()}'));
    }
  }

  Future<Either<Failure, Token>> _refreshToken({
    required String refreshToken,
  }) async {
    try {
      final result = await authProvider.refreshToken(
        refreshToken: refreshToken,
      );
      if (result.statusCode == 200) {
        return Right(Token.fromMap(result.body));
      } else {
        return Left(
          Failure(message: 'Authentication Failed ${result.statusCode}'),
        );
      }
    } on Exception catch (e) {
      return Left(Failure(message: 'Authentication Failed ${e.toString()}'));
    }
  }

  Future<Token> _validAcessToken(Token token) async {
    if (await jwtHelper.isTokenValid(token.access_token!)) {
      return token;
    } else if (await jwtHelper.isTokenValid(token.refresh_token!)) {
      final result = await _refreshToken(refreshToken: token.refresh_token!);
      return result.fold(
        (failure) => throw TokenRefreshException(message: failure.message),
        (token) async {
          try {
            localStorageProvider.updateToken(token);
            return token;
          } on TokenVerificationException {
            rethrow;
          }
        },
      );
    } else {
      throw TokenExpiredException(
        message: 'Token expired! Need to login again',
      );
    }
  }

  Future<void> _initializeSession(Token token) async {
    try {
      UserInfo? userInfo = await jwtHelper.decodeAndVerifyToken(token);
      Get.put<Token>(token, permanent: true);
      Get.put<UserInfo>(userInfo!, permanent: true);
    } on TokenVerificationException {
      rethrow;
    }
  }
}
