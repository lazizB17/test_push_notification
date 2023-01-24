import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_push_notification/pages/login_page_number.dart';

class SplashPage extends StatefulWidget {
  static const id = "/splash_page";
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  initState() {
    super.initState();
    _goto();
  }

  Future<void> _goto() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPageNumber()));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: FlutterLogo(
          size: 200.h,
        ),
      ),
    );
  }
}
