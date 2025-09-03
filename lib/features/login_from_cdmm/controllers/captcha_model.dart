class CaptchaGetModel {
  Null key;
  Null captcha;
  String? hidden;
  String? image;

  CaptchaGetModel({this.key, this.captcha, this.hidden, this.image});

  CaptchaGetModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    captcha = json['captcha'];
    hidden = json['hidden'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['captcha'] = captcha;
    data['hidden'] = hidden;
    data['image'] = image;
    return data;
  }
}
