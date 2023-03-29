import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_task_restaurant/providers/dishes_provider.dart';

class ScreenAuthentication extends StatelessWidget {
  const ScreenAuthentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loadDishes = Provider.of<DishesProvider>(context);
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
              onPressed: () {
                Navigator.pushNamed(context, '/homeScreen');
                // Add google authentication logic here
              },
            ),
            SizedBox(height: 25.h),
            FilledButton(
              style: FilledButton.styleFrom(
                  minimumSize: Size(0.8.sw, 0.07.sh),
                  backgroundColor: Colors.green), onPressed: () async {
              await loadDishes.getDishes(context);
              if (loadDishes.isLoading==false
              ) {if(  loadDishes.dishes != null) {
                Navigator.pushNamed(context, '/homeScreen');
              }
              }

              // Add phone authentication logic here
            },
              child: loadDishes.isLoading?const CircularProgressIndicator():Text(
                'Phone',
                style: TextStyle(fontSize: 18.sp),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
