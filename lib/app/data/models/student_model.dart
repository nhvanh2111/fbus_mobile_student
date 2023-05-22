import '../../core/utils/hyper_app_settings.dart';

class Student {
  String? id;
  String? fullName;
  String? phone;
  String? email;
  String? address;
  String? photoUrl;
  bool? automaticScheduling;
  bool? isBan;
  int? countBan;

  Student({
    this.id,
    this.fullName,
    this.phone,
    this.email,
    this.address,
    this.photoUrl,
    this.automaticScheduling,
    this.isBan,
    this.countBan,
  });

  Student.fromJson(Map<String, dynamic> json) {
    id = json['StudentId'];
    fullName = json['FullName'];
    phone = json['Phone'];
    email = json['Email'];
    address = json['Address'];
    var photos = (json['PhotoUrl'] ?? '').trim().split(' ');
    photoUrl = AppSettings.get('studentPhotoUrlHost') + '/' + photos.last ?? '';
    automaticScheduling = json['AutomaticScheduling'] == 'True' ? true : false;
    isBan = json['IsBan'] == 'True' ? true : false;
    countBan = int.parse((json['CountBan'] ?? '0').toString());
  }
}
