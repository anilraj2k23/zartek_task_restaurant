import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_task_restaurant/providers/cart_provider.dart';
import 'package:zartek_task_restaurant/providers/dishes_provider.dart';

class ScreenCheckout extends StatelessWidget {
  const ScreenCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Summary')),
      body: SafeArea(
        child: Consumer<CartProvider>(builder: (context, value, child) {
          return
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  margin: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.w),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        child: Center(
                          child: Text(
                            '2 Dishes ${value.orderCount} Items',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.5.sh,
                        child: ListView.separated(
                          itemCount: 10,
                          // Replace with your actual data
                          itemBuilder: (context, index) =>
                              Container(
                                width: double.infinity,
                                height: 200.h,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15.h, horizontal: 12.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.h),
                                            child: Image.network(
                                              'https://cdn-icons-png.flaticon.com/512/1971/1971034.png',
                                              width: 20.h,
                                              height: 20.w,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.w),
                                            child: Text(
                                              'Gopi\nManchurian\nDry',
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 0.3.sw,
                                          ),
                                          Text(
                                            'INR 20.00',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                            left: 0.4.sw,
                                          ),
                                          child: Container(
                                            width: 130.w,
                                            height: 45.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(30.r),
                                                color:
                                                Theme
                                                    .of(context)
                                                    .primaryColor),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      value.decrementOrder();
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    )),
                                                Text(
                                                  value.orderCount.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17.sp),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      value.incrementOrder();
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            ),
                                          )

                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(left: 30.w),
                                        child: Text(
                                          'INR 45.00',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 30.w, top: 5.h),
                                        child: Text(
                                          '250 calories',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              indent: 15.w,
                              endIndent: 15.w,
                            );
                          },
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount',
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'INR 100',
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  fontSize: 19),
                            ),
                            // Replace with your actual total amount
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: FilledButton(
                    style:
                    FilledButton.styleFrom(minimumSize: Size(0.7.sw, 0.065.sh)),
                    onPressed: () {
                      showDialog(
                        //show confirm dialogue
                        //the return value will be from "Yes" or "No" options
                        context: context,
                        builder: (context) =>
                            AlertDialog(
                              title: const Text('Order Status'),
                              content: const Text(
                                'Order successfully placed',
                                style: TextStyle(fontSize: 15),
                              ),
                              actions: [
                                Center(
                                  child: FilledButton(
                                    style: FilledButton.styleFrom(
                                        minimumSize: Size(0.3.sw, 0.05.sh)),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    //Todo: redirect the user to the homepage with all the selected products cleared.

                                    child: const Text(
                                      'OK',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      );
                    },
                    child: Text(
                      'Place Order',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ],
            );

        }
        ),
      ),
    );
  }
}
