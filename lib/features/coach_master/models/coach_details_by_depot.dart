class EmuCoachByDepo {
  final int coachId;
  final String coachNo;
  final String owningRly;
  final String coachType;
  final String coachCategory;
  final String powerGenerationType;
  final String utilityType;

  EmuCoachByDepo({
    required this.coachId,
    required this.coachNo,
    required this.owningRly,
    required this.coachType,
    required this.coachCategory,
    required this.powerGenerationType,
    required this.utilityType,
  });

  factory EmuCoachByDepo.fromJson(Map<String, dynamic> json) {
    return EmuCoachByDepo(
      coachId: json['coachId'],
      coachNo: json['coachNo'],
      owningRly: json['owningRly'],
      coachType: json['coachType'],
      coachCategory: json['coachCategory'],
      powerGenerationType: json['powerGenerationType'],
      utilityType: json['utilityType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coachId': coachId,
      'coachNo': coachNo,
      'owningRly': owningRly,
      'coachType': coachType,
      'coachCategory': coachCategory,
      'powerGenerationType': powerGenerationType,
      'utilityType': utilityType,
    };
  }
}
