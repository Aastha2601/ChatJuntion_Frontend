import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatDTO{
  String _id = '';
  String _senderId ='';
  String _receiverId = '';
  String _message= '';
  DateTime _timestamp = DateTime.now();
  String _profilePictureUrl = '';
  ChatDTO();

  String get id => _id;
  String get senderId => _senderId;
  String get receiverId => _receiverId;
  String get message => _message;
  DateTime get timestamp => _timestamp;
  String get profilePictureUrl => _profilePictureUrl;


  set id(String id) => _id = id;
  set senderId(String senderId) => _senderId = senderId;
  set receiverId(String receiverId) => _receiverId = receiverId;
  set message(String message) => _message = message;
  set timestamp(DateTime timestamp) => _timestamp = timestamp;
  set profilePictureUrl(String profilePictureUrl) => _profilePictureUrl = profilePictureUrl;

  Map<String, dynamic> toJson() => {
    'id': _id,
    'senderId': _senderId,
    'receiverId': _receiverId,
    'message': _message,
    'timestamp': _timestamp.toIso8601String(),
    'profilePictureUrl' : _profilePictureUrl
  };

  factory ChatDTO.fromJson(Map<String, dynamic> json) {
    ChatDTO chatDTO = ChatDTO();
    chatDTO.id = json['id'] ?? '';
    chatDTO.senderId = json['senderId'] ?? '';
    chatDTO.receiverId =  json['receiverId'] ?? '';
    chatDTO.message =  json['message'] ?? '';
    chatDTO.timestamp = DateTime.tryParse(json['timeStamp'].toString()) ?? DateTime.now();
    chatDTO.profilePictureUrl = json['profilePictureUrl'] ?? '';
    return chatDTO;
  }
}

