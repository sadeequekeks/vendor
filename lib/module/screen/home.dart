import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                      fontSize: 13.0,
                    ),
                  ),
                  SizedBox(
                    width: 13.7,
                  ),
                  Icon(Icons.chevron_right)
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: 5,
            itemBuilder: (context, index) {
              return FoodBuddies(
                name: 'Barhak Restaurant',
                address: 'Student Market, Atbu Yelwa.',
                image: 'assets/res1.jpg',
                onTap: () {},
              );
            },
          ),
        )
      ],
    );
  }
}

class FoodBuddies extends StatelessWidget {
  final String name;
  final String image;
  final String address;
  final VoidCallback onTap;
  FoodBuddies(
      {required this.name,
      required this.address,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          height: 170.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(0, 0.1),
                color: Colors.blue,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100.0,
                  width: 145.6,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(image),
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
                      style: TextStyle(
                        color: Colors.blue[500],
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
                        'Vendors Home',
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
