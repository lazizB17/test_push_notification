import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoginPageNumber extends StatefulWidget {
  static const id = "/login_page_number";

  const LoginPageNumber({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<LoginPageNumber> createState() => _LoginPageNumberState();
}

class _LoginPageNumberState extends State<LoginPageNumber> {
  TextEditingController countryCode = TextEditingController();
  var phone = "";

  @override
  void initState() {
    countryCode.text = "+998";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 25.w, right: 25.w),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset(
                "assets/lottie/verification.json",
                height: 220.h,
                width: 220.w,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "We need to register your phone\nbefore getting started !",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Container(
                height: 45.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.w, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10.w),
                    SizedBox(
                      width: 40.w,
                      child: TextField(
                        controller: countryCode,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "|",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 35.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                     Expanded(
                      child: TextField(
                        onChanged: (value) {
                          phone = value;
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Your Phone",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 45.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: countryCode.text + phone,
                      verificationCompleted: (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        LoginPageNumber.verify = verificationId;
                        Navigator.pushNamed(context, "/login_page_sms");
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                    // Navigator.pushNamed(context, "/login_page_sms");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: const Text("Send the code"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
