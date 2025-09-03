import 'dart:convert';
import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String? access_token;
  final String? token_type;
  final String? refresh_token;
  final int? expires_in;
  const Token({
    this.access_token,
    this.token_type,
    this.refresh_token,
    this.expires_in,
  });

  factory Token.fromJson(String source) => Token.fromMap(json.decode(source));

  factory Token.fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return const Token();
    return Token(
      access_token: map['access_token'],
      token_type: map['token_type'],
      refresh_token: map['refresh_token'],
      expires_in: map['expires_in'],
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'access_token': access_token,
      'token_type': token_type,
      'refresh_token': refresh_token,
      'expires_in': expires_in,
    };
  }

  @override
  List<Object?> get props =>
      [access_token, token_type, refresh_token, expires_in];
}
