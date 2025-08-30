// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp/main.dart';

class Otppage extends StatefulWidget {
  final String verificationid;
  const Otppage({super.key, required this.verificationid});

  @override
  State<Otppage> createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {
  TextEditingController otpcontroller = TextEditingController();
  Future<void> otp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationid,
      smsCode: otpcontroller.text.toString(),
    );
   await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MyHomePage(title: "Successfully LogIN through Otp Verification"),
      ),
    );
    } catch (e) {
      print("OTP verification failed: $e");

    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otp Verification', style: TextStyle(fontSize: 26)),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),

        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: otpcontroller,
              onTap: () {},
              decoration: InputDecoration(
                hintText: "Enter The OTP",
                icon: Icon(Icons.phone_android),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                otp();
              },
              child: Text(
                'Confirm Otp',
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
