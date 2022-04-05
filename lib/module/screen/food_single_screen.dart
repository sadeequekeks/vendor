import 'package:flutter/material.dart';
import 'package:vendors/core/helper/format_money.dart';
import 'package:vendors/core/service_injector/service_injector.dart';
import 'package:vendors/shared/model/item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipeSinglePage extends StatefulWidget {
  final ItemModel item;
  const RecipeSinglePage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<RecipeSinglePage> createState() => _RecipeSinglePageState();
}

class _RecipeSinglePageState extends State<RecipeSinglePage> {
  final Color color1 = const Color.fromARGB(255, 22, 154, 194);

  final Color color2 = const Color.fromARGB(255, 52, 183, 223);

  final Color color3 = const Color.fromARGB(255, 40, 133, 221);

  int itemQ = 0;
  final Helper _helper = Helper();
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          int newCost =
              costCalculationAdd(int.parse(widget.item.food.price), itemQ);
          await si.vendorService
              .addtoCart(
                userId: FirebaseAuth.instance.currentUser!.uid,
                quantity: itemQ.toString(),
                price: newCost.toString(),
                name: widget.item.food.name,
              )
              .then((value) => si.dialogService.showToaster(value!));
        },
        label: const Text('Add to Cart'),
        icon: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 22, 154, 194),
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
                top: 350,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [color2, color3],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                )),
            Positioned(
                top: 350,
                left: 0,
                right: 150,
                bottom: 80,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: color1,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(50.0))),
                )),
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40.0),
                    Text(
                      widget.item.food.name.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 30.0),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      widget.item.food.description,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 50.0),
                    SizedBox(
                      height: 30.0,
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.white),
                          const SizedBox(width: 5.0),
                          const Text(
                            "2.5",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          const Spacer(),
                          const VerticalDivider(color: Colors.white),
                          const Spacer(),
                          Text(
                            widget.item.food.category,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18.0),
                          ),
                          const Spacer(),
                          const VerticalDivider(color: Colors.white),
                          const Spacer(),
                          // const Icon(Icons.money, color: Colors.white),
                          const SizedBox(width: 5.0),
                          Text(
                            _helper.formattNumber(
                              int.parse(widget.item.food.price),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 380,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black38, blurRadius: 30.0)
              ]),
              child: const SizedBox(
                height: 350,
                child: Image(
                  image: NetworkImage(
                    'https://images.food52.com/u0UcAvp-Ly2nK5eY8RF_Iw0Q6Qc=/1200x900/f55f7e17-489f-43ac-9097-a9da39d9701b--2019-0618_blue-cheese-burger-for-one_3x2_bobbi-lin_4166.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 325,
              left: 20,
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 22, 154, 194),
                radius: 25,
                child: IconButton(
                    color: isSelected == true ? Colors.red : Colors.white,
                    onPressed: () {
                      setState(() {
                        isSelected = true;
                      });
                      // si.dialogService.showToaster('Added to favorite');
                    },
                    icon: const Icon(
                      Icons.favorite,
                    )),
              ),
            ),
            Positioned(
              top: 325,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 40.0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      iconSize: 18.0,
                      color: Colors.blue,
                      padding: const EdgeInsets.all(2.0),
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          itemQ--;
                        });
                      },
                    ),
                    Text(
                      itemQ.toString(),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    IconButton(
                      iconSize: 18.0,
                      color: Colors.blue,
                      padding: const EdgeInsets.all(2.0),
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          itemQ++;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
                height: 70.0,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                )),
          ],
        ),
      ),
    );
  }
}

int costCalculationAdd(int cost, int quantity) {
  return cost * quantity;
}
