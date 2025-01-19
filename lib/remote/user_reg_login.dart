import 'dart:convert';

import 'package:chatify/UserDTO.dart';
import 'package:chatify/remote/authentication_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class RemoteServices{

  Future<UserDTO> sendOTP(String phoneNumber) async{
    Authentication().getTokenFromSP().then((token) async {
      if(token != null) {
        try {
          var client = http.Client();
          var uri = Uri.parse(
              "https://spring-boot-app-872353977685.us-central1.run.app/api/v1/users/sendOTP");
          var reqDTO = jsonEncode({"phoneNumber": phoneNumber});
          var response = await client.post(uri,
              headers: {
            'Content-Type': 'application/json',
            'User-Agent' : 'Android',
            'Authorization' : token
              }, body: reqDTO);
          print(response.body.toString());
          if (response.statusCode == 200) {
            var reply = json.decode(response.body);
            Authentication().setTokenToSP(reply["token"].toString());
            UserDTO userDTO; // TO GET DATA
            if (reply["flag"] == 1) {
              userDTO = UserDTO();
              reply["data"] == null ? UserDTO() : UserDTO.fromJson(
                  reply["data"]);
            } else {
              userDTO = UserDTO();
              userDTO.errorMessage = reply["messages"][0];
            }
            Future<UserDTO> future = Future<UserDTO>.value(userDTO);
            return future;
          }
        } catch (e) {
          print(e.toString());
          var userDTO = UserDTO();
          userDTO.errorMessage = e.toString();
          return userDTO;
        }
      }
    });
    return UserDTO();
  }

  Future<UserDTO> verifyOTP(String phoneNumber, String otp) async {
    String? token = await Authentication().getTokenFromSP();
    if (token != null) {
      try {
        var client = http.Client();
        var uri = Uri.parse(
            "https://spring-boot-app-872353977685.us-central1.run.app/api/v1/users/verifyOTP");
        var reqDTO = jsonEncode({"phoneNumber": phoneNumber, "otp": otp});
        var response = await client.post(uri,
            headers: {
              'Content-Type': 'application/json',
              'User-Agent': 'Android',
              'Authorization': token
            },
            body: reqDTO);
        if (response.statusCode == 200) {
          var reply = json.decode(response.body);
          Authentication().setTokenToSP(reply["token"].toString());
          Authentication().setPhoneNumberToSP(phoneNumber);
          UserDTO userDTO; // TO GET DATA
          if (reply["flag"] == 1) {
            userDTO = UserDTO();
            reply["data"] == null ? UserDTO() : UserDTO.fromJson(reply["data"]);
          } else {
            userDTO = UserDTO();
            userDTO.errorMessage =
                reply["messages"] == null ? '' : reply['messages'][0];
          }
          return userDTO;
        }
        return UserDTO();
      } catch (e) {
        print(e.toString());
        var userDTO = UserDTO();
        userDTO.errorMessage =
            'Check yor internet connection... Retry after some time';
        return userDTO;
      }
    } else {
      UserDTO userDTO = UserDTO();
      userDTO.errorMessage= 'Empty';
      return Future.value(userDTO);
    }
  }
}