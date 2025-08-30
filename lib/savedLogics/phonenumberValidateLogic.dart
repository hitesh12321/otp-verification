// bool _validatePhoneNumber(String phoneNumber) {
//   // E.164 format: + followed by country code and number
//   final regex = RegExp(r'^\+[1-9]\d{1,14}$');
  
//   if (phoneNumber.isEmpty) {
//     Uihelper.customShowDialog(context, "Please enter a phone number");
//     return false;
//   }
  
//   if (!regex.hasMatch(phoneNumber)) {
//     Uihelper.customShowDialog(context, 
//         "Please enter a valid phone number with country code\nExample: +919876543210");
//     return false;
//   }
  
//   return true;
// }

// // Update phonenumber function:
// Future<void> phonenumber(String phonenumber) async {
//   if (!_validatePhoneNumber(phonenumber)) {
//     return;
//   }
  
//   // Rest of your code...
// }