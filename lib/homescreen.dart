import 'package:chatify/ChatDTO.dart';
import 'package:chatify/fetchingContacts.dart';
import 'package:chatify/remote/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';


import 'camera.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   late Future<List<ChatDTO>> _chatListFuture;
  final ChatService _chatService = ChatService();
  @override
  void initState() {
    super.initState();
    _chatListFuture = _chatService.getChatList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //
      // ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 35.0),
            child: Row(
              children: [
                Text("Chat Junction", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'MyFonts',
                    color: Colors.red.shade300),),
                Container(
                    margin: EdgeInsets.only(left: 181),
                    child: Lottie.asset('assets/animation/chat_bubble.json', fit: BoxFit.contain, width: 50,height: 50)),
              ],
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(margin: EdgeInsets.only(left: 5),child: CircleAvatar(radius: 15, child: Container(child: Text('...'), margin: EdgeInsets.only(bottom: 11),),backgroundColor: Colors.deepOrangeAccent.shade100,)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Container(margin: EdgeInsets.only(right: 18) ,child: CircleAvatar(radius: 15,child: Icon(Icons.camera_alt_rounded, size: 18,),backgroundColor: Colors.deepOrangeAccent.shade100,)),
                    onTap: () async{
                      /*// Request storage permission
                            var status = await Permission.storage.status;
                            if (!status.isGranted) {
                                await Permission.storage.request();
                            }*/
                      // Request camera permission
                      var cameraStatus = await Permission.camera.status;
                      if (!cameraStatus.isGranted) {
                        await Permission.camera.request();
                      } else {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (
                            context) => CameraScreen()));
                      }

                    },
                  ),
                  GestureDetector(child: Container(margin: EdgeInsets.only(right: 11) ,child: CircleAvatar(radius: 15, child: Icon(Icons.add,),backgroundColor: Colors.red.shade300,)),
                    onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => FetchingContacts()));
                    },
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 21,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 7),
                child: Text('Chats', style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'MyFonts',
                    color: Colors.red.shade300),),
              ),
            ],
          ),
          SizedBox(height: 21,),
          Container(
            height: 40,
            width: 375,
            child: TextField(
              decoration: InputDecoration(
                label: Text('Search'),
                prefixIcon: Icon(Icons.search),
                iconColor: Colors.black87,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(11),
                ),
              ),
              onTap: () {

              },
            ),
          ),
          Flexible(
            child: FutureBuilder<List<ChatDTO>>(
            future: _chatListFuture, builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData && (snapshot.data == null || snapshot.data!.isEmpty)) {
                return Center(child: Text('No chats available'));
              } else if (snapshot.hasData){
                List<ChatDTO> chatList = snapshot.data!;
                return ListView.separated(
                  itemCount: chatList.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (context, index) {
                    ChatDTO chatMessage = chatList[index];
                    return ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(
                          chatMessage.profilePictureUrl),),
                      title: Text(chatMessage.receiverId, style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(chatMessage.message),
                      trailing: Text(DateFormat('HH:mm a').format(chatMessage.timestamp), style: TextStyle(fontSize: 15),),
                      onTap: () {},
                    );
                  },
                );
              } else {
                return Center(child: Text('Unexpected state'));
              }
            }),
          ),
        ],
      ),
    );
  }
}
