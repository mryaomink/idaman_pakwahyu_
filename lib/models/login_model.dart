import 'package:idaman/models/Akun.dart';
import 'package:idaman/models/Usaha.dart';

class LoginResponseModel {
  final int apiStatus;
  final String id;
  final String apiMessage;
  final String photo;
  final String displayName;
  final String cmsPrivilegesName;
  final String idCmsPrivileges;
  final String icon;
  final String telp;
  final List<AkunModel> multiPrivs;
  final List<UsahaModel> usaha;

  LoginResponseModel({
    required this.id,
    required this.apiStatus,
    required this.apiMessage,
    required this.photo,
    required this.displayName,
    required this.cmsPrivilegesName,
    required this.idCmsPrivileges,
    required this.icon,
    required this.telp,
    required this.multiPrivs,
    required this.usaha,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      apiStatus: json["api_status"] != null ? json["api_status"] : "",
      apiMessage: json["api_message"] != null ? json["api_message"] : "",
        id: json["id"] != null ? json["id"] : "",
      photo: json["photo"] != null ? json["photo"] : "",
        displayName: json["display_name"] != null ? json["display_name"] : "",
        cmsPrivilegesName: json["cms_privileges_name"] != null ? json["cms_privileges_name"] : "",
        idCmsPrivileges: json["id_cms_privileges"] != null ? json["id_cms_privileges"] : "",
        icon: json["icon"] != null ? json["icon"] : "",
        telp: json["no_telp"] != null ? json["no_telp"] : "",
          multiPrivs: json["multi_privs"] != null ? List<AkunModel>.from(json["multi_privs"].map((x) => AkunModel.fromMap(x))) : List.empty(),
        usaha: json["usaha"] != null ? List<UsahaModel>.from(json["usaha"].map((x) => UsahaModel.fromMap(x))) : List.empty()
    );
  }
}

class LoginRequestModel {
  String nik;
  String password;
  String appId;
  String appToken;
  String modeAkses;

  LoginRequestModel({
    required this.nik,
    required this.password,
    required this.appId,
    required this.appToken,
    required this.modeAkses,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'nik': nik.trim(),
      'password': password.trim(),
      'app_id': appId.trim(),
      'app_token': appToken.trim(),
      'mode_akses': modeAkses.trim(),
    };

    return map;
  }
}