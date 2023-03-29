import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  @override
  Widget build(BuildContext context) {
    var restaurantData =
        Provider.of<DishesProvider>(context, listen: false).dishes;


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
                          label: Text(cart.orderCount.toString()),
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
                      const UserAccountsDrawerHeader(
                          currentAccountPicture: CircleAvatar(
                              foregroundImage:
                                  AssetImage('assets/profile_vector.jpg')),
                          accountName: Text('Muhammed Naseem'),
                          accountEmail: Text(
                            'ID : 410',
                          )),
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
                            onTap: () {
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/'));

                              // Add drawer item 1 logic here
                            },
                          )),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    BuildDishTiles(
                      salad: filtermenu(menuId: '11'),
                      cart: cart,
                    ),
                    BuildDishTiles(
                      salad: filtermenu(menuId: '12'),
                      cart: cart,
                    ),
                    BuildDishTiles(
                      salad: filtermenu(menuId: '13'),
                      cart: cart,
                    ),
                    BuildDishTiles(
                      salad: filtermenu(menuId: '14'),
                      cart: cart,
                    ),
                    BuildDishTiles(
                      salad: filtermenu(menuId: '15'),
                      cart: cart,
                    ),
                    BuildDishTiles(
                      salad: filtermenu(menuId: '17'),
                      cart: cart,
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

