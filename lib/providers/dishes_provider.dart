import 'package:flutter/material.dart';
import 'package:zartek_task_restaurant/models/restaurant_data_model.dart';
import 'package:zartek_task_restaurant/networking/api_request.dart';

class DishesProvider with ChangeNotifier {
  List<RestaurantData>? _dishes;

  List<RestaurantData>? get dishes => _dishes;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

    Future<List<RestaurantData>?>  getDishes(BuildContext context) async{
    _isLoading=true;
    notifyListeners();
    try {
      _dishes = await ApiManagement.getDishes(context);
      _isLoading=false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return _dishes;
  }
}
