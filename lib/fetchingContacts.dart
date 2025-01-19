import 'package:flutter/cupertino.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';


class FetchingContacts extends StatefulWidget {
  @override
  State<FetchingContacts> createState() => _FetchingContactsState();
}
class _FetchingContactsState extends State<FetchingContacts> {
  List<Contact> contacts = []; bool isLoading = true;
  @override void initState() {
    super.initState();
    getContactPermission();
  }
  void getContactPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      fetchContacts();
    } else if (status.isDenied) {
      if (await Permission.contacts.request().isGranted) {
        fetchContacts();
      }
    }
  }
  void fetchContacts() async {
    contacts = (await ContactsService.getContacts()).toList();
    setState(() {
      isLoading = false;
    });
    print('Contacts fetched: ${contacts.length}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Contacts"), ),
      body: isLoading ? Center( child: CircularProgressIndicator(), ) : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [ BoxShadow(
                  blurRadius: 7,
                  color: Colors.white.withOpacity(0.1),
                  offset: const Offset(-3, -3), ),
                  BoxShadow( blurRadius: 7, color: Colors.black.withOpacity(0.7),
                    offset: const Offset(3, 3), ), ],
                borderRadius: BorderRadius.circular(6), color: Color(0xff262626), ),
              child: Text( contacts[index].givenName != null && contacts[index].givenName!.isNotEmpty ? contacts[index].givenName![0] : '?', style: TextStyle( fontSize: 23, color: Colors.primaries[Random().nextInt(Colors.primaries.length)], fontFamily: "Poppins", fontWeight: FontWeight.w500, ), ), ),
            title: Text( contacts[index].givenName ?? 'No Name', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle( fontSize: 16, color: Colors.orange.shade300, fontFamily: "Poppins", fontWeight: FontWeight.w500, ), ),
            subtitle: Text( contacts[index].phones != null && contacts[index].phones!.isNotEmpty ? contacts[index].phones![0].value ?? 'No Phone' : 'No Phone', style: TextStyle( fontSize: 11, color: Colors.black, fontFamily: "Poppins", fontWeight: FontWeight.w400, ), ),
            horizontalTitleGap: 12,
          );
          },
      ),
    );
  }
}