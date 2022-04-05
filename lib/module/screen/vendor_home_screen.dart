import 'package:flutter/material.dart';

String networkImageUri =
    'https://media-cdn.tripadvisor.com/media/photo-s/1c/88/f9/30/half-and-half-pepperoni.jpg';

class VendorHome extends StatefulWidget {
  const VendorHome({Key? key}) : super(key: key);

  @override
  State<VendorHome> createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Home')),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Domino\'s Pizza Cold Stone, Kaduna.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                '22 Ali akilu road, Kaduna.',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 9.0),
              Row(
                children: const [
                  Text(
                    '⭐ 2.5',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    '(254 reviews)',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      'Delivery',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Open Time',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      'Free',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '8:00 AM',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              const Divider(),
              const SizedBox(height: 15.0),
              const Text(
                'FEATURED ITEMS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 150.0,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                  child: Image.network(
                    networkImageUri,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Beef Pizza & Sausage',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 9.0,
              ),
              const Text(
                '\$ 200.00',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 17.0),
              const Text(
                'POPULAR ITEMS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return FoodBuddies(
                      name: 'Beef Burger & Cheese',
                      address: 'Beef, Lemon, Cheese, Irish Potatoe',
                      image:
                          'https://images.food52.com/u0UcAvp-Ly2nK5eY8RF_Iw0Q6Qc=/1200x900/f55f7e17-489f-43ac-9097-a9da39d9701b--2019-0618_blue-cheese-burger-for-one_3x2_bobbi-lin_4166.jpg',
                      onTap: () {
                        // si.routerService.nextScreen(
                        //   context,
                        //   const RecipeSinglePage(),
                        // );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodBuddies extends StatelessWidget {
  final String name;
  final String image;
  final String address;
  final VoidCallback onTap;
  const FoodBuddies(
      {required this.name,
      required this.address,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 165,
          height: 200.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.blue, width: 0.1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100.0,
                  width: 145.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 2.5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      address,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
