import 'package:flutter/material.dart';
import 'package:vendors/core/service_injector/service_injector.dart';
import 'package:vendors/shared/model/food_model.dart';
import 'package:vendors/shared/model/resturant_model.dart';
import 'package:vendors/shared/widget/button/primary_button.dart';
import 'package:vendors/shared/widget/form/text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  TextEditingController foodName = TextEditingController();
  TextEditingController foodDescripton = TextEditingController();
  TextEditingController foodCategory = TextEditingController();
  TextEditingController foodPrice = TextEditingController();
  TextEditingController resName = TextEditingController();
  TextEditingController resDescription = TextEditingController();
  TextEditingController resAddress = TextEditingController();
  TextEditingController resRating = TextEditingController();

  List<TextEditingController> controllers = [];

  String imagePath = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    controllers.addAll([
      foodName,
      foodDescripton,
      foodCategory,
      foodPrice,
      resName,
      resDescription,
      resAddress,
      resRating,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Add Food',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  'Note: All field are required',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                GestureDetector(
                  onTap: () async {
                    await si.utilityService
                        .getImage(imgSource: ImageSource.gallery)
                        .then((file) {
                      setState(() {
                        imagePath = file!.path;
                        // print(imagePath);
                      });
                    });
                  },
                  child: CircleAvatar(
                    child:
                        imagePath != '' ? null : const Icon(Icons.camera_alt),
                    radius: 70,
                    backgroundImage:
                        imagePath == '' ? null : FileImage(File(imagePath)),
                  ),
                ),
                const SizedBox(height: 20.0),
                InputTextField(
                  controller: foodName,
                  hintText: 'Fried Rice',
                  labelText: 'Food name',
                  icon: Icons.food_bank,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InputTextField(
                  controller: foodDescripton,
                  hintText: 'Rice with meat and salad',
                  labelText: 'Description',
                  icon: Icons.description,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InputTextField(
                  controller: foodCategory,
                  hintText: 'Rice',
                  labelText: 'Category',
                  icon: Icons.category,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InputTextField(
                  controller: foodPrice,
                  hintText: '2000',
                  labelText: 'Price',
                  icon: Icons.money,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InputTextField(
                  controller: resName,
                  hintText: 'Dominos Pizza',
                  labelText: 'Resturant name',
                  icon: Icons.restaurant,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InputTextField(
                  controller: resDescription,
                  hintText: 'Give you the best',
                  labelText: 'Resturant Description',
                  icon: Icons.description,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InputTextField(
                  controller: resAddress,
                  hintText: 'No. 3 example road',
                  labelText: 'Address',
                  icon: Icons.restaurant_menu,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InputTextField(
                  controller: resRating,
                  hintText: '3.4',
                  labelText: 'Rating',
                  icon: Icons.rate_review,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                PrimaryButton(
                  title: 'Add',
                  onTap: (startLoading, stopLoading, btnState) async {
                    startLoading();
                    var food = FoodModel(
                      name: foodName.text,
                      category: foodCategory.text,
                      description: foodDescripton.text,
                      price: foodPrice.text,
                    );
                    var resturant = ResturantModel(
                      name: resName.text,
                      address: resAddress.text,
                      description: resDescription.text,
                      rating: resRating.text,
                    );
                    startLoading();

                    await si.vendorService
                        .addFood(
                      food: food,
                      resturant: resturant,
                    )
                        .then((value) {
                      if (value == 'Successful') {
                        stopLoading();
                        si.dialogService.showToaster(value!);
                        si.utilityService.clearFields(controllers);
                      } else {
                        stopLoading();
                        si.dialogService
                            .showToaster('An error occured while adding food');
                      }
                    });
                    stopLoading();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
