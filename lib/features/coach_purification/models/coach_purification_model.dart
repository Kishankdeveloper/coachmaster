class CoachPurificationModel {
  int? txnId;
  int? coachId;
  String? coachNo;
  String? coachType;
  String? owningRly;
  String? fileNameCoachNoImage;
  String? fileNameCoachProImage;
  String? imageUploadedBy;
  String? imageUploadedTime;
  String? approvedStatus;
  String? approvedBy;
  String? approvedTime;
  String? coachCategory;
  String? newUniqueNo;
  String? rejectionRemarks;
  String? fileNameCoachTypeImage;
  String? depot;
  String? division;
  String? zone;
  String? builtDate;
  String? fileNameOwningRlyImage;
  String? proApprovedStatus;
  String? proRejectionRemarks;
  String? proApprovedBy;
  String? proApprovedTime;
  String? iohDate;
  String? pohDate;
  String? retDate;
  String? coachNoImageUrl;
  String? coachTypeImageUrl;
  String? coachProImageUrl;
  String? owningRlyImageUrl;
  String? latestImage;
  String? entryPersonName;
  String? entryPersonPhone;

  CoachPurificationModel(
      {this.txnId,
        this.coachId,
        this.coachNo,
        this.coachType,
        this.owningRly,
        this.fileNameCoachNoImage,
        this.fileNameCoachProImage,
        this.imageUploadedBy,
        this.imageUploadedTime,
        this.approvedStatus,
        this.approvedBy,
        this.approvedTime,
        this.coachCategory,
        this.newUniqueNo,
        this.rejectionRemarks,
        this.fileNameCoachTypeImage,
        this.depot,
        this.division,
        this.zone,
        this.builtDate,
        this.fileNameOwningRlyImage,
        this.proApprovedStatus,
        this.proRejectionRemarks,
        this.proApprovedBy,
        this.proApprovedTime,
        this.iohDate,
        this.pohDate,
        this.retDate,
        this.coachNoImageUrl,
        this.coachTypeImageUrl,
        this.coachProImageUrl,
        this.owningRlyImageUrl,
        this.latestImage,
        this.entryPersonName,
        this.entryPersonPhone});

  CoachPurificationModel.fromJson(Map<String, dynamic> json) {
    txnId = json['txnId'];
    coachId = json['coachId'];
    coachNo = json['coachNo'];
    coachType = json['coachType'];
    owningRly = json['owningRly'];
    fileNameCoachNoImage = json['fileNameCoachNoImage'];
    fileNameCoachProImage = json['fileNameCoachProImage'];
    imageUploadedBy = json['imageUploadedBy'];
    imageUploadedTime = json['imageUploadedTime'];
    approvedStatus = json['approvedStatus'];
    approvedBy = json['approvedBy'];
    approvedTime = json['approvedTime'];
    coachCategory = json['coachCategory'];
    newUniqueNo = json['newUniqueNo'];
    rejectionRemarks = json['rejectionRemarks'];
    fileNameCoachTypeImage = json['fileNameCoachTypeImage'];
    depot = json['depot'];
    division = json['division'];
    zone = json['zone'];
    builtDate = json['builtDate'];
    fileNameOwningRlyImage = json['fileNameOwningRlyImage'];
    proApprovedStatus = json['proApprovedStatus'];
    proRejectionRemarks = json['proRejectionRemarks'];
    proApprovedBy = json['proApprovedBy'];
    proApprovedTime = json['proApprovedTime'];
    iohDate = json['iohDate'];
    pohDate = json['pohDate'];
    retDate = json['retDate'];
    coachNoImageUrl = json['coachNoImageUrl'];
    coachTypeImageUrl = json['coachTypeImageUrl'];
    coachProImageUrl = json['coachProImageUrl'];
    owningRlyImageUrl = json['owningRlyImageUrl'];
    latestImage = json['latestImage'];
    entryPersonName = json['entryPersonName'];
    entryPersonPhone = json['entryPersonPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['txnId'] = txnId;
    data['coachId'] = coachId;
    data['coachNo'] = coachNo;
    data['coachType'] = coachType;
    data['owningRly'] = owningRly;
    data['fileNameCoachNoImage'] = fileNameCoachNoImage;
    data['fileNameCoachProImage'] = fileNameCoachProImage;
    data['imageUploadedBy'] = imageUploadedBy;
    data['imageUploadedTime'] = imageUploadedTime;
    data['approvedStatus'] = approvedStatus;
    data['approvedBy'] = approvedBy;
    data['approvedTime'] = approvedTime;
    data['coachCategory'] = coachCategory;
    data['newUniqueNo'] = newUniqueNo;
    data['rejectionRemarks'] = rejectionRemarks;
    data['fileNameCoachTypeImage'] = fileNameCoachTypeImage;
    data['depot'] = depot;
    data['division'] = division;
    data['zone'] = zone;
    data['builtDate'] = builtDate;
    data['fileNameOwningRlyImage'] = fileNameOwningRlyImage;
    data['proApprovedStatus'] = proApprovedStatus;
    data['proRejectionRemarks'] = proRejectionRemarks;
    data['proApprovedBy'] = proApprovedBy;
    data['proApprovedTime'] = proApprovedTime;
    data['iohDate'] = iohDate;
    data['pohDate'] = pohDate;
    data['retDate'] = retDate;
    data['coachNoImageUrl'] = coachNoImageUrl;
    data['coachTypeImageUrl'] = coachTypeImageUrl;
    data['coachProImageUrl'] = coachProImageUrl;
    data['owningRlyImageUrl'] = owningRlyImageUrl;
    data['latestImage'] = latestImage;
    data['entryPersonName'] = entryPersonName;
    data['entryPersonPhone'] = entryPersonPhone;
    return data;
  }
}
