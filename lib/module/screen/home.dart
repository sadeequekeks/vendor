import 'package:flutter/material.dart';
import 'package:vendors/core/helper/format_money.dart';
import 'package:vendors/core/service_injector/service_injector.dart';
import 'package:vendors/module/screen/food_single_screen.dart';
import 'package:vendors/shared/model/food_model.dart';
import 'package:vendors/shared/model/item_model.dart';
import 'package:vendors/shared/widget/card/categories_card.dart';
import 'package:vendors/shared/widget/card/food_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum Food {
  burger,
  pizza,
  cake,
}

class Home extends StatefulWidget {
  // final UserModel user;
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Helper _helper = Helper();

  @override
  void initState() {
    super.initState();
    selectedSalary = Food.burger;
  }

  late Food selectedSalary;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FlexBalanceDash(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Your Food Buddies',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 13.7,
                      ),
                      Icon(Icons.chevron_right)
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     CategoriesCard(
                  //       name: '🍔 Burger',
                  //       color: selectedSalary == Food.burger
                  //           ? Colors.blue
                  //           : Colors.white,
                  //       textColor: selectedSalary == Food.burger
                  //           ? Colors.white
                  //           : Colors.black,
                  //       onTap: () {
                  //         setState(() {
                  //           selectedSalary = Food.burger;
                  //         });
                  //       },
                  //     ),
                  //     CategoriesCard(
                  //       name: '🍕 Pizza',
                  //       color: selectedSalary == Food.pizza
                  //           ? Colors.blue
                  //           : Colors.white,
                  //       textColor: selectedSalary == Food.pizza
                  //           ? Colors.white
                  //           : Colors.black,
                  //       onTap: () {
                  //         setState(() {
                  //           selectedSalary = Food.pizza;
                  //         });
                  //       },
                  //     ),
                  //     CategoriesCard(
                  //       name: '🎂 Cake',
                  //       color: selectedSalary == Food.cake
                  //           ? Colors.blue
                  //           : Colors.white,
                  //       textColor: selectedSalary == Food.cake
                  //           ? Colors.white
                  //           : Colors.black,
                  //       onTap: () {
                  //         setState(() {
                  //           selectedSalary = Food.cake;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 15.0),
                  const Text(
                    'Popular',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
            FutureBuilder<List<ItemModel>>(
              future: si.vendorService.getAllFood(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                      size: 50.0,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('NO DATA!'));
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        // String id = data[index].id;
                        FoodModel food = FoodModel(
                          name: data[index].food.name,
                          category: data[index].food.category,
                          description: data[index].food.description,
                          price: data[index].food.price,
                        );
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FoodCard(
                            foodTitle: food.name,
                            foodContent: food.category,
                            rating: '2.5',
                            time: _helper.formattNumber(
                              int.parse(food.price),
                            ),
                            onTap: () {
                              si.routerService.nextScreen(
                                  context,
                                  RecipeSinglePage(
                                    item: data[index],
                                  ));
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FlexBalanceDash extends StatelessWidget {
  const FlexBalanceDash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          constraints:
              const BoxConstraints(maxHeight: 220.0, maxWidth: double.infinity),
          child: Column(
            children: <Widget>[
              Container(
                height: 150.0,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0,
                      offset: Offset(0, 1.5),
                      color: Colors.blue,
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Let\'s eat Quality food🙂',
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Profile image
        Positioned(
          top: 100.0,
          child: Container(
            height: 90.0,
            width: MediaQuery.of(context).size.width - 35,
            padding: const EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage('assets/food.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Vendor Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 4.5,
                ),
                Text(
                  'Good Food Good Mood',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
