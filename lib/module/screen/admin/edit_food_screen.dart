import 'package:flutter/material.dart';
import 'package:vendors/core/service_injector/service_injector.dart';
import 'package:vendors/shared/model/food_model.dart';
import 'package:vendors/shared/model/resturant_model.dart';
import 'package:vendors/shared/widget/button/primary_button.dart';
import 'package:vendors/shared/widget/form/text_field.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditFoodScreen extends StatefulWidget {
  final String id;
  final FoodModel food;
  final ResturantModel res;
  const EditFoodScreen({
    Key? key,
    required this.food,
    required this.id,
    required this.res,
  }) : super(key: key);

  @override
  State<EditFoodScreen> createState() => _EditFoodScreenState();
}

class _EditFoodScreenState extends State<EditFoodScreen> {
  TextEditingController foodName = TextEditingController();
  TextEditingController foodDescripton = TextEditingController();
  TextEditingController foodCategory = TextEditingController();
  TextEditingController foodPrice = TextEditingController();
  TextEditingController resName = TextEditingController();
  TextEditingController resDescription = TextEditingController();
  TextEditingController resAddress = TextEditingController();
  TextEditingController resRating = TextEditingController();

  String imagePath = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      foodName.text = widget.food.name;
      foodDescripton.text = widget.food.description;
      foodCategory.text = widget.food.category;
      foodPrice.text = widget.food.price;
      resName.text = widget.res.name;
      resDescription.text = widget.res.description;
      resAddress.text = widget.res.address;
      resRating.text = widget.res.rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          child: Column(
            children: [
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
                  child: imagePath != '' ? null : const Icon(Icons.camera_alt),
                  radius: 70,
                  backgroundImage:
                      imagePath == '' ? null : FileImage(File(imagePath)),
                ),
              ),
              const SizedBox(height: 20.0),
              InputTextField(
                controller: foodName,
                hintText: widget.food.name,
                labelText: 'Food name',
                icon: Icons.food_bank,
              ),
              const SizedBox(
                height: 10.0,
              ),
              InputTextField(
                controller: foodDescripton,
                hintText: widget.food.description,
                labelText: 'Description',
                icon: Icons.description,
              ),
              const SizedBox(
                height: 10.0,
              ),
              InputTextField(
                controller: foodCategory,
                hintText: widget.food.category,
                labelText: 'Category',
                icon: Icons.category,
              ),
              const SizedBox(
                height: 10.0,
              ),
              InputTextField(
                controller: foodPrice,
                hintText: widget.food.price,
                labelText: 'Price',
                icon: Icons.money,
              ),
              const SizedBox(
                height: 10.0,
              ),
              InputTextField(
                controller: resName,
                hintText: widget.res.name,
                labelText: 'Resturant name',
                icon: Icons.restaurant,
              ),
              const SizedBox(
                height: 10.0,
              ),
              InputTextField(
                controller: resDescription,
                hintText: widget.res.description,
                labelText: 'Resturant Description',
                icon: Icons.description,
              ),
              const SizedBox(
                height: 10.0,
              ),
              InputTextField(
                controller: resAddress,
                hintText: widget.res.address,
                labelText: 'Address',
                icon: Icons.restaurant_menu,
              ),
              const SizedBox(
                height: 10.0,
              ),
              InputTextField(
                controller: resRating,
                hintText: widget.res.rating,
                labelText: 'Rating',
                icon: Icons.rate_review,
              ),
              const SizedBox(
                height: 30.0,
              ),
              PrimaryButton(
                title: 'Update',
                onTap: (startLoading, stopLoading, btnState) {},
              ),
            ],
          ),
        ),
      )),
    );
  }
}
