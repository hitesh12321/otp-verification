// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:otp/main.dart';
// import 'package:otp/phoneauth.dart';

// class Usercheck extends StatefulWidget {
//   const Usercheck({super.key});

//   @override
//   State<Usercheck> createState() => _UsercheckState();
// }

// class _UsercheckState extends State<Usercheck> {
//   @override
//   Widget build(BuildContext context) {
//     return checkuser();
//   }

//   checkuser() {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MyHomePage(
//             title:
//                 "user is already identified so directly entered to home page",
//           ),
//         ),
//       );
//     } else {
//       return Phoneauth();
//     }
//   }
// }
