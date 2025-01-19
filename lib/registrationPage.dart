import 'package:chatify/UserDTO.dart';
import 'package:chatify/remote/authentication_service.dart';
import 'package:chatify/splashPage.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:chatify/remote/user_reg_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen.dart';

class Registrationpage extends StatefulWidget {  @override
  State<Registrationpage> createState() => _RegistrationpageState();
}

class _RegistrationpageState extends State<Registrationpage> {
  var name = TextEditingController();
  var phoneNo = TextEditingController();
  var OTP = TextEditingController();
  String selectedCountryCode = "91";
  bool isOtpSent = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _submit(){
    if(_formKey.currentState!.validate()){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        color: Colors.orange.shade200,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text: "Chat", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'MyFonts',
                      color: Colors.red.shade300),
                      children: <TextSpan>[
                        TextSpan(text: "Junction",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'MyFonts',
                              color: Colors.red.shade200),)
                      ]
                  ),
                ),
                SizedBox(height: 21),
                SizedBox(
                  width: 330,
                  child: TextFormField(
                    controller: name,
                    enabled: !isOtpSent,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      label: Text("Enter you name"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(11))
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please enter a valid name';
                      }else{
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                SizedBox(height: 21),
                SizedBox(
                  width: 330,
                  child: IntlPhoneField(
                    enabled: !isOtpSent,
                    controller: phoneNo,
                    initialCountryCode: 'IN',
                    onCountryChanged: ((country){
                      selectedCountryCode = country.dialCode;
                    }),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: "Enter you Phone Number",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(11))
                    ),
                  ),
                ),
                SizedBox(height: 21),
                SizedBox(
                  width: 330,
                  child: Visibility(
                    visible: isOtpSent,
                    child: TextField(
                      controller: OTP,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text("Enter valid OTP"),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(11))
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 21,),
                ElevatedButton(onPressed: () {
                 _submit();
                 if(!isOtpSent) {
                   Future<UserDTO> future = RemoteServices().sendOTP(
                       '+$selectedCountryCode${phoneNo.value.text}');
                   future.then((userDTO) {
                     if(userDTO.errorMessage.trim().isEmpty){
                       setState(() {
                         // otp = userDTO.otp;
                         isOtpSent = true;
                       });
                     }else{
                         print(userDTO.errorMessage);
                         _showErrorSnackbar(context, "Check yor internet connection... Retry after some time");//TODO snackbar
                     }
                   });
                 }else {
                   Future<UserDTO?> future = RemoteServices().verifyOTP(
                       '+$selectedCountryCode${phoneNo.value.text}',OTP.text);
                   future.then((userDTO) {
                     if(userDTO != null && userDTO.errorMessage.trim().isEmpty) {
                       var sharedPrefFuture =  SharedPreferences.getInstance();
                       sharedPrefFuture.then((sharedPref){
                         sharedPref.setBool(SplashPageState.KEYLOGIN, true);
                         sharedPref.setString("PHONE_NUMBER", '+$selectedCountryCode${phoneNo.value.text}');
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home Page')));
                       });
                     }else{
                       print(userDTO != null ? userDTO.errorMessage : "");
                       _showErrorSnackbar(context, userDTO != null ? userDTO.errorMessage : "");//TODO Snackbar
                     }
                   });
                 }
                }, child: Text(!isOtpSent ? 'Get OTP' : 'Verify OTP', style: TextStyle(fontSize: 20, color: Colors.red.shade300),)),
                // CircularProgressIndicator(
                // backgroundColor: Colors.orange.shade100, strokeWidth: 5,)
              ],
            ),
          ),
        ),
      ),
    );

  }}
void _showErrorSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar( content: Text(message),
    backgroundColor: Colors.red, duration: Duration(seconds: 3),
  ); ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

