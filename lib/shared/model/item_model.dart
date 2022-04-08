import 'food_model.dart';
import 'resturant_model.dart';

class ItemModel {
  final FoodModel food;
  final ResturantModel resturant;
  final String foodID;

  ItemModel({
    required this.food,
    required this.resturant,
    required this.foodID,
  });

  Map<String, dynamic> toMap() => {
        "food": food.toMap(),
        "resturant": resturant.toMap(),
        "foodID": foodID,
      };
}
