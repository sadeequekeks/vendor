import 'package:vendors/core/service_injector/service_injector.dart';
import 'package:vendors/shared/model/cart_model.dart';
import 'package:vendors/shared/model/food_model.dart';
import 'package:vendors/shared/model/item_model.dart';
import 'package:vendors/shared/model/resturant_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VendorService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<List<ItemModel>> getAllFood() async {
    List<ItemModel> items = [];
    try {
      await si.firebaseService.getDocStream('food').then((values) {
        for (var value in values!) {
          Map<String, dynamic> item = value.data();
          dynamic foodValue = item['food'];
          dynamic resturantValue = item['resturant'];
          String foodID = value.id;
          FoodModel food = FoodModel(
            name: foodValue['name'],
            category: foodValue['category'],
            description: foodValue['description'],
            price: foodValue['price'],
          );
          ResturantModel resturant = ResturantModel(
            name: resturantValue['name'],
            address: resturantValue['address'],
            description: resturantValue['description'],
            rating: resturantValue['rating'],
          );
          items.add(
            ItemModel(
              food: food,
              resturant: resturant,
              foodID: foodID,
            ),
          );
        }
      });
    } catch (e) {
      throw 'Error occured $e';
    }

    return items;
  }

  Future<String?> addtoCart(
      {required String userId,
      required String quantity,
      required String price,
      required String name}) async {
    String? message;

    try {
      await si.firebaseService.addDoc(
        collection: 'cart',
        data: {
          "quantity": quantity,
          "price": price,
          "name": name,
          "userId": userId,
        },
      ).then((value) {
        if (value == true) {
          message = "Added to Cart";
        }
      });
    } catch (e) {
      message = "Error occured $e";
      throw 'Error occured $e';
    }
    return message;
  }

  //getting all cart items

  Future<List<CartModel>> getAllCartFood() async {
    List<CartModel> cartList = [];
    try {
      await si.firebaseService.getDocStream('cart').then((values) {
        for (var value in values!) {
          Map<String, dynamic> item = value.data();
          if (value.data()['userId'] ==
              FirebaseAuth.instance.currentUser!.uid) {
            cartList.add(
              CartModel(
                name: item['name'],
                price: item['price'],
                quantity: item['quantity'],
                id: item['userId'],
              ),
            );
          }
        }
      });
    } catch (e) {
      throw 'Error occured $e';
    }

    return cartList;
  }

  // totally cart amount
  Future<int> getTotalCartAmount() async {
    int sum = 0;
    await si.vendorService.getAllCartFood().then((carts) {
      for (CartModel cart in carts) {
        sum += int.parse(cart.price);
      }
    });
    return sum;
  }

  //add food

  Future<String?> addFood({
    required FoodModel food,
    required ResturantModel resturant,
    String? foodID,
  }) async {
    final foodId = _fireStore.collection('food').doc();
    String? message;
    try {
      await si.firebaseService
          .addDoc(
        collection: 'food',
        data: ItemModel(
          food: food,
          resturant: resturant,
          foodID: foodId.id,
        ).toMap(),
        id: foodId.id,
      )
          .then((value) {
        if (value == true) {
          message = 'Successful';
        }
      });
    } catch (e) {
      message = 'Error occured $e';
    }
    return message;
  }

  //update food

}
