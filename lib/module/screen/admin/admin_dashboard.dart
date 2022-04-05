import 'package:flutter/material.dart';
import 'package:vendors/core/service_injector/service_injector.dart';
import 'package:vendors/shared/model/food_model.dart';
import 'package:vendors/shared/model/item_model.dart';
import 'package:vendors/shared/widget/card/admin_food.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const TextStyle whiteText = TextStyle(color: Colors.white);

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildTile(
                    title: 'Number of Foods Added',
                    data: '12',
                    color: Colors.red,
                    icon: Icons.food_bank,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  _buildTile(
                    title: 'No. Foods Deleted',
                    data: '2',
                    color: Colors.blue,
                    icon: Icons.food_bank,
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                'All Foods',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15.0,
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
                            child: AdminFoodCard(
                              foodTitle: food.name,
                              foodContent: food.category,
                              onPressed: () {},
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
      ),
    );
  }
}

Container _buildTile(
    {Color? color,
    IconData? icon,
    required String title,
    required String data}) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    height: 150.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: color,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          title,
          style: whiteText.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          data,
          style:
              whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      ],
    ),
  );
}


// Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: AdminFoodCard(
//                   foodTitle: 'Yam',
//                   foodContent: 'Yam and Beans',
//                   onPressed: () {},
//                 ),
//               ),