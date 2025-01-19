import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Authentication {
  Future<String> getToken() async{
    try {
      var client = http.Client();
      var uri = Uri.parse(
          "https://spring-boot-app-872353977685.us-central1.run.app/api/v1/initial/generateToken");
      var response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'User-Agent' : 'Android'
      });
      print(response.body.toString());
      if (response.statusCode == 200) {
        var reply = json.decode(response.body);
        String token = "";
        if (reply["flag"] == 1) {
          token = reply["token"] == null ? "" : reply["token"].toString();
        }
        Future<String> future = Future<String>.value(token);
        return future;
      }
    }catch(e){
      print(e.toString());
      return "";
    }
    return "";
  }
  void setTokenToSP(String token) async{
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("TOKEN", token);
  }

  Future<String ?> getTokenFromSP() async{
  var sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString("TOKEN");
  }

  void setPhoneNumberToSP(String phoneNumber) async{
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("PHONE_NUMBER", phoneNumber);
  }

  Future<String ?> getPhoneNumberFromSP() async{
    var sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString("PHONE_NUMBER");
  }
}