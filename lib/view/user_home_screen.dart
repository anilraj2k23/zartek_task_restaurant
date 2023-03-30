import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:zartek_task_restaurant/models/restaurant_data_model.dart';
import 'package:zartek_task_restaurant/providers/cart_provider.dart';
import 'package:zartek_task_restaurant/providers/dishes_provider.dart';
import 'package:zartek_task_restaurant/widgets/build_dish_tile.dart';

class ScreenUserHome extends StatefulWidget {
  const ScreenUserHome({Key? key}) : super(key: key);

  @override
  State<ScreenUserHome> createState() => _ScreenUserHomeState();
}

class _ScreenUserHomeState extends State<ScreenUserHome>
    with SingleTickerProviderStateMixin {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    var restaurantData = Provider.of<DishesProvider>(context).dishes;

    List<TableMenuList> filtermenu({required String menuId}) {
      List<TableMenuList> filteredMenu = restaurantData![0]
          .tableMenuList
          .where((menu) => menu.menuCategoryId == menuId)
          .toList();
      return filteredMenu;
    }

    return Consumer<DishesProvider>(
      builder: (BuildContext context, restaurant, child) {
        return DefaultTabController(
          length: restaurant.dishes![0].tableMenuList.length,
          child: Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    Padding(
                        padding: EdgeInsets.only(right: 3.w),
                        child: Badge(
                          label: Text(cart.cartDishes.length.toString()),
                          child: IconButton(
                              icon: Icon(
                                Icons.shopping_cart,
                                size: 30.r,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/checkoutScreen');
                              }),
                        )),
                  ],
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: List.generate(
                        restaurant.dishes![0].tableMenuList.length,
                        (index) => Tab(
                              text: restaurant
                                  .dishes![0].tableMenuList[index].menuCategory,
                            )),
                  ),
                ),
                drawer: Drawer(
                  child: ListView(
                    children: [
                      UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor,
                            Colors.green
                          ])),
                          currentAccountPicture: CircleAvatar(
                              foregroundImage: NetworkImage(_user.photoURL ??
                                  'https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_640.png')
                              // AssetImage('assets/profile_vector.jpg')
                              ),
                          accountName: Text(
                              _user.phoneNumber ?? _user.displayName ?? ''),
                          accountEmail:
                              Text('ID: ${_user.uid.substring(0, 3)}')),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          child: ListTile(
                            leading: Icon(
                              Icons.logout_rounded,
                              size: 29.r,
                            ),
                            title: Text(
                              'Log Out',
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            onTap: () async {
                              try {
                                final currentUser =
                                    FirebaseAuth.instance.currentUser;
                                if (currentUser != null) {
                                  if (currentUser.providerData.any((element) =>
                                      element.providerId == 'google.com')) {
                                    await GoogleSignIn().signOut();
                                  } else if (currentUser.providerData.any(
                                      (element) =>
                                          element.providerId == 'phone')) {
                                    await FirebaseAuth.instance.signOut();
                                  }
                                }
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/'));
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                          )),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    BuildDishTiles(
                      menuCategory: filtermenu(menuId: '11'),
                    ),
                    BuildDishTiles(
                      menuCategory: filtermenu(menuId: '12'),
                    ),
                    BuildDishTiles(
                      menuCategory: filtermenu(menuId: '13'),
                    ),
                    BuildDishTiles(
                      menuCategory: filtermenu(menuId: '14'),
                    ),
                    BuildDishTiles(
                      menuCategory: filtermenu(menuId: '15'),
                    ),
                    BuildDishTiles(
                      menuCategory: filtermenu(menuId: '17'),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
