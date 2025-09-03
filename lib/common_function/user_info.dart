import 'dart:convert';
import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String? user_name;
  final String? user;
  final String? firstName;

  final String? orgslno;
  final String? location;
  final String? depot;
  final String? division;
  final String? zone;

  final String? level;

  final String? department;

  final String? client_id;

  final List<String>? authorities;
  final List<String>? scope;
  const UserInfo({
    this.user_name,
    this.user,
    this.firstName,
    this.orgslno,
    this.location,
    this.depot,
    this.division,
    this.zone,
    this.level,
    this.department,
    this.client_id,
    this.authorities,
    this.scope,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_name': user_name,
      'user': user,
      'firstName': firstName,
      'orgslno': orgslno,
      'location': location,
      'depot': depot,
      'division': division,
      'zone': zone,
      'level': level,
      'department': department,
      'client_id': client_id,
      'authorities': authorities,
      'scope': scope,
    };
  }

  static UserInfo? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return UserInfo(
      user_name: map['user_name'],
      user: map['user'],
      firstName: map['firstName'],
      orgslno: map['orgslno'],
      location: map['location'],
      depot: map['depot'],
      division: map['division'],
      zone: map['zone'],
      level: map['level'],
      department: map['department'],
      client_id: map['client_id'],
      authorities: List<String>.from(map['authorities']),
      scope: List<String>.from(map['scope']),
    );
  }

  String toJson() => json.encode(toMap());

  static UserInfo? fromJson(String source) => fromMap(json.decode(source));

  @override
  List<Object?> get props => [user];
}
