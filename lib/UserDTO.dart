import 'package:flutter/foundation.dart';
import 'dart:convert';

// List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));
//
// String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDTO{
  int _pageNo = 0;
  int _numberOfRecords = 20;
  bool _fullData = false;
  String _email = '';
  String _phoneNumber = '';
  String _otp = '';
  String _name = '';
  bool _alreadyRegistered = false;
  String _errorMessage = '';


 UserDTO();


  int get pageNo => _pageNo;

  set pageNo(int value) {
    _pageNo = value;
  }

  int get numberOfRecords => _numberOfRecords;

  bool get alreadyRegistered => _alreadyRegistered;

  set alreadyRegistered(bool value) {
    _alreadyRegistered = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get otp => _otp;

  set otp(String value) {
    _otp = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  bool get fullData => _fullData;

  set fullData(bool value) {
    _fullData = value;
  }

  set numberOfRecords(int value) {
    _numberOfRecords = value;
  }


 String get errorMessage => _errorMessage;

  set errorMessage(String value) {
    _errorMessage = value;
  }

  Map<String,dynamic> toJson() =>{
    "pageNo" : pageNo,
    "numberOfRecords" : numberOfRecords,
    "fullData" : fullData,
    "email" : email,
    "phoneNumber" : phoneNumber,
    "otp" : otp,
    "name" : name,
    "alreadyRegistered" : alreadyRegistered
  };

  factory UserDTO.fromJson(Map<String,dynamic> json){
    UserDTO userDTO = UserDTO();
      userDTO.pageNo = json["pageNo"];
      userDTO.numberOfRecords = json["numberOfRecords"];
      userDTO.fullData = json["fullData"];
      userDTO.email = json["email"] == null ? '' : json['email'];
      userDTO.phoneNumber = json["phoneNumber"] == null ? '' :json['phoneNumber'];
      userDTO.otp = json["otp"] == null ? '' : json['otp'];
      userDTO.name = json["name"] == null ? '' : json['name'];
      userDTO.alreadyRegistered = json["alreadyRegistered"];
    return userDTO;
  }

}