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

  bool isLoading = false;

  bool _validatePhoneNumber(String phoneNumber) {
    // E.164 format: + followed by country code and number
    final regex = RegExp(r'^\+[1-9]\d{1,14}$');

    if (phoneNumber.isEmpty) {
      Uihelper.customShowDialog(context, "Please enter a phone number");
      return false;
    }

    if (!regex.hasMatch(phoneNumber)) {
      Uihelper.customShowDialog(
        context,
        "Please enter a valid phone number with country code\nExample: +919876543210",
      );
      return false;
    }

    return true;
  }

  Future<void> phonenumber(String phonenumber) async {
    if (!_validatePhoneNumber(phonenumber)) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) {
          setState(() {
            isLoading = false; // ← ADD THIS
          });
        },
        verificationFailed: (FirebaseAuthException ex) {
          setState(() {
            isLoading = false; // ← ADD THIS
          });
          Uihelper.customShowDialog(
            context,
            "Verification Failed : ${ex.message}",
          );
        },
        codeSent: (String verificationid, int? resendtoken) {
          setState(() {
            isLoading = false; // ← ADD THIS
          });
          print("Verification ID: $verificationid");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Otppage(verificationid: verificationid),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            isLoading = false; // ← ADD THIS
          });
        },
        phoneNumber: phonenumber,
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Uihelper.customShowDialog(context, "Error: $e");
    }
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
              onPressed: isLoading
                  ? null
                  : () {
                      String phone = phonenumbercontroller.text.trim();
                      print("Phone Number : $phone");
                      phonenumber(phone);
                    },
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text(
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
