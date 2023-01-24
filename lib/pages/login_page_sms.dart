import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:test_push_notification/pages/login_page_number.dart';

class LoginPageSMS extends StatefulWidget {
  static const id = "/login_page_sms";

  const LoginPageSMS({Key? key}) : super(key: key);

  @override
  State<LoginPageSMS> createState() => _LoginPageSMSState();
}

class _LoginPageSMSState extends State<LoginPageSMS> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: const Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(234, 239, 243, 1),
        ),
        borderRadius: BorderRadius.circular(20.w),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: const Color.fromRGBO(114, 178, 238, 1),
      ),
      borderRadius: BorderRadius.circular(8.w),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code = "";

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () =>
              Navigator.pushReplacementNamed(context, LoginPageNumber.id),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
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
              Pinput(
                length: 6,
                onChanged: (value) {
                  code = value;
                },
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 45.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: LoginPageNumber.verify, smsCode: code);
                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      Navigator.pushNamedAndRemoveUntil(context, "/home_page", (route) => false);
                    } catch(e) {
                      debugPrint("Wrong code: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: const Text("Verify phone number"),
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Edit Phone Number ?",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
