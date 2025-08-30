// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:otp/main.dart';
import 'package:otp/otppage.dart';
import 'package:otp/uiHelper.dart';

class Phoneauth extends StatefulWidget {
  const Phoneauth({super.key});

  @override
  State<Phoneauth> createState() => _PhoneauthState();
}

class _PhoneauthState extends State<Phoneauth> {
  TextEditingController phonenumbercontroller = TextEditingController();

  



  Future<void> phonenumber(String phonenumber) async {
    if (phonenumber.isEmpty) {
      return Uihelper.customShowDialog(context, "enter the phone number");
    }
    await FirebaseAuth.instance.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException ex) {
        Uihelper.customShowDialog(
          context,
          "Verification Failed : ${ex.message}",
        );
      },
      codeSent: (String verificationid, int? resendtoken) {
        print("Verification ID: $verificationid");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Otppage(verificationid: verificationid),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      phoneNumber: phonenumbercontroller.text.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication', style: TextStyle(fontSize: 25)),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),

        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: phonenumbercontroller,
              onTap: () {},
              decoration: InputDecoration(
                hintText: "Enter The Phone No.",
                icon: Icon(Icons.phone_android),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                phonenumber(phonenumbercontroller.text.trim());

                print("Phone number: ${phonenumbercontroller.text.trim()}");
              },
              child: Text(
                'Confirm number',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
