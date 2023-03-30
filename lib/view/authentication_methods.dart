import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:zartek_task_restaurant/providers/dishes_provider.dart';

class ScreenAuthentication extends StatefulWidget {
  const ScreenAuthentication({Key? key}) : super(key: key);

  @override
  State<ScreenAuthentication> createState() => _ScreenAuthenticationState();
}

class _ScreenAuthenticationState extends State<ScreenAuthentication> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var loadDishes = Provider.of<DishesProvider>(context, listen: false);
      await loadDishes.getDishes(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    foregroundImage: AssetImage(
                      'assets/google-logo.png',
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Google',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ],
              ),
              onPressed: () async {
                try {
                  final GoogleSignInAccount? googleUser =
                      await GoogleSignIn().signIn();
                  final GoogleSignInAuthentication googleAuth =
                      await googleUser!.authentication;

                  // Get the Firebase credential from the Google user
                  final AuthCredential credential =
                      GoogleAuthProvider.credential(
                    accessToken: googleAuth.accessToken,
                    idToken: googleAuth.idToken,
                  );

                  // Sign in to Firebase with the Google user's credential
                  final UserCredential userCredential = await FirebaseAuth
                      .instance
                      .signInWithCredential(credential);

                  // Navigate to the home page on successful login
                  Navigator.pushNamed(context, '/homeScreen');
                } catch (e) {
                  print(e.toString());
                }
              },
            ),
            SizedBox(height: 25.h),
            FilledButton(
              style: FilledButton.styleFrom(
                  minimumSize: Size(0.8.sw, 0.07.sh),
                  backgroundColor: Colors.green),
              onPressed: () async {
                Navigator.pushNamed(context, '/phoneAuth');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset( height: 30.h,width: 30.w
                    ,
                    'assets/phone-logo.png',
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Phone',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
