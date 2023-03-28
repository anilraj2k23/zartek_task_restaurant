import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:zartek_task_restaurant/models/restaurant_data_model.dart';
import 'package:zartek_task_restaurant/utils/constants';

class ApiManagement{
Future< List<RestaurantData>?> getDishes() async{
  try{
    var url= Uri.parse(ApiConstants.apiEndPoint);
    var response= await http.get(url);
    if(response.statusCode==200){
      List <RestaurantData> model = restaurantDataFromJson(response.body);

      print(response.body);
      return model;
    }

  }catch(e){
    log(e.toString());
  }
  return null;

}
}