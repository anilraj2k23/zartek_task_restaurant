import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_task_restaurant/providers/cart_provider.dart';
import 'package:zartek_task_restaurant/providers/dishes_provider.dart';
import 'package:zartek_task_restaurant/view/authentication_methods.dart';
import 'package:zartek_task_restaurant/view/checkout_screen.dart';
import 'package:zartek_task_restaurant/view/phone_auth.dart';
 import 'package:zartek_task_restaurant/view/user_home_screen.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<DishesProvider>(
          create: (context) => DishesProvider()),
        ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider())
      ],
      child: ScreenUtilInit(
          designSize: const Size(392.72, 850.90),
          minTextAdapt: true,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(debugShowCheckedModeBanner: false,
              title: 'Restaurant App',
              theme: ThemeData(colorSchemeSeed:Color(0xFF4CAC52) ,
                 useMaterial3: true,

              ),
              routes: {
                '/': (BuildContext ctx) =>
                    const ScreenAuthentication(),
                '/phoneAuth': (BuildContext ctx) => const PhoneAuthentication(),
                '/homeScreen': (BuildContext ctx) => const ScreenUserHome(),
                '/checkoutScreen': (BuildContext ctx) => const ScreenCheckout(),
              },initialRoute: '/',
            );
          }),
    );
  }
}
