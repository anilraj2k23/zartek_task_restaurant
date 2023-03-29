import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zartek_task_restaurant/models/restaurant_data_model.dart';
import 'package:zartek_task_restaurant/providers/cart_provider.dart';
class BuildDishTiles extends StatelessWidget {
  const BuildDishTiles({super.key, required this.salad, required this.cart});

  final List<TableMenuList> salad;
  final CartProvider cart;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          height: 255.h,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 12.w),
              child: Stack(
                children: [
                  Positioned(
                    top: 5.h,
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/1971/1971034.png',
                      width: 20.h,
                      height: 20.w,
                    ),
                  ),
                  Positioned(
                    left: 30.w,
                    child: Text(
                      salad[0].categoryDishes[index].dishName,
                      maxLines: 3,
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    left: 30.w,
                    top: 35.h,
                    child: Text(
                      '${salad[0].categoryDishes[index].dishCurrency} '
                          '${salad[0].categoryDishes[index].dishPrice}',
                      style: TextStyle(fontSize: 17.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, top: 80.h),
                    child: Row(children: [
                      Flexible(
                        child: Text(
                            salad[0].categoryDishes[index].dishDescription),
                        fit: FlexFit.tight,
                      )
                    ]),
                  ),
                  Positioned(
                      top: 35.h,
                      left: 0.5.sw,
                      child: Text(
                        '${salad[0].categoryDishes[index].dishCalories} calories',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )),
                  Positioned(
                      left: 30.w,
                      top: 180.h,
                      child: Container(
                        width: 130.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: Theme.of(context).primaryColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                                onTap: () {
                                  cart.decrementOrder();
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                )),
                            Text(
                              cart.orderCount.toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.sp),
                            ),
                            InkWell(
                                onTap: () {
                                  cart.incrementOrder();
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      )),
                  Positioned(
                      left: 0.76.sw,
                      top: 20.h,
                      child: Image.asset(
                        'assets/diet.png',
                        height: 60.h,
                        width: 60.w,
                      ))
                ],
              )),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: salad[0].categoryDishes.length,
    );
  }
}
