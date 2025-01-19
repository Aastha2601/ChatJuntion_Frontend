
import 'package:chatify/ChatDTO.dart';
import 'dart:convert';
import 'package:chatify/UserDTO.dart';
import 'package:chatify/remote/authentication_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatService{
  Future<List<ChatDTO>> getChatList() async {
    List<ChatDTO> chatList = [];
    String? token = await Authentication().getTokenFromSP();
    token ??= await Authentication().getToken();
    String? phoneNumber = await Authentication().getPhoneNumberFromSP();
    if (token != null) {
      try {
        var client = http.Client();
        var uri = Uri.parse(
            "https://spring-boot-app-872353977685.us-central1.run.app/api/v1/chats");
        var reqDTO = jsonEncode({
          "phoneNumber" : phoneNumber
        });
        var response = await client.post(uri, headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'Android',
          'Authorization': token
        },body: reqDTO);
        print(response.body.toString());
        if (response.statusCode == 200) {
          var reply = json.decode(response.body);
          Authentication().setTokenToSP(reply["token"].toString());
          if (reply["flag"] == 1) {
            if (reply["data"] != null) {
              var chatJsonList = List.castFrom(reply["data"]);
              for (var chatJson in chatJsonList) {
                ChatDTO chatDTO = ChatDTO.fromJson(chatJson);
                chatList.add(chatDTO);
              }
            }
          }
          return Future.value(chatList);
        }
      } catch (e) {
        print(e.toString());
        return Future.value(chatList);
      }
    } else {
      return Future.value([]);
    }
    return Future.value([]);
  }
}