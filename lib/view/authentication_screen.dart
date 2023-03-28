import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAuthentication extends StatelessWidget {
  const ScreenAuthentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/Firebase_Logo_Logomark.png'),
            SizedBox(height: 0.2.sh),
            FilledButton(
              style: FilledButton.styleFrom(
                  minimumSize: Size(0.8.sw, 0.07.sh),
                  backgroundColor: Colors.blueAccent),
              child: Text('Google', style: TextStyle(fontSize: 18.sp)),
              onPressed: () {Navigator.pushNamed(context, '/homeScreen');
                // Add google authentication logic here
              },
            ),
            SizedBox(height: 25.h),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: Size(0.8.sw, 0.07.sh)),
              child: Text(
                'Phone',
                style: TextStyle(fontSize: 18.sp),
              ),
              onPressed: () async {
                // Add phone authentication logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
