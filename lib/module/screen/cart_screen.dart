import 'package:flutter/material.dart';
import 'package:vendors/core/helper/format_money.dart';
import 'package:vendors/core/service_injector/service_injector.dart';
import 'package:vendors/shared/model/cart_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final priceTextStyle = TextStyle(
  color: Colors.grey.shade600,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Helper _helper = Helper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: const Text(
              'My Cart',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ),
          FutureBuilder<List<CartModel>>(
            future: si.vendorService.getAllCartFood(),
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
                return const Center(
                    child: Text(
                  'NO DATA!',
                  style: TextStyle(color: Colors.red),
                ));
              } else if (snapshot.hasData) {
                final data = snapshot.data!;
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      16.0,
                      16.0,
                      14.0,
                      14.0,
                    ),
                    itemCount: data.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 15.0),
                    itemBuilder: (BuildContext context, int index) {
                      CartModel cart = CartModel(
                        id: data[index].id,
                        name: data[index].name,
                        quantity: data[index].quantity,
                        price: data[index].price,
                      );
                      return OrderListItem(
                        item: OrderItem(
                            title: cart.name,
                            qty: int.parse(cart.quantity),
                            price: _helper.formattNumber(int.parse(cart.price)),
                            bgColor: Colors.deepOrange,
                            image:
                                'https://natashaskitchen.com/wp-content/uploads/2019/04/Best-Burger-4-500x375.jpg'),
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          FutureBuilder<int>(
            future: si.vendorService.getTotalCartAmount(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitCircle(
                    color: Colors.white,
                    size: 50.0,
                  ),
                );
              } else if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDivider(),
                    const SizedBox(height: 10.0),
                    const SizedBox(width: 40.0),
                    Text(
                      "Total",
                      style: priceTextStyle.copyWith(color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          _helper.formattNumber(snapshot.data ?? 0),
                          textAlign: TextAlign.left,
                          style: priceTextStyle.copyWith(color: Colors.indigo),
                        ),
                        const Spacer(),
                        MaterialButton(
                          padding: const EdgeInsets.all(16.0),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          color: Colors.blue,
                          child: const Text(
                            "Checkout",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 20.0),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    _buildDivider(),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      height: 2.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}

class OrderItem {
  final String? title;
  int qty;
  final String? price;
  final String? image;
  final Color? bgColor;
  OrderItem(
      {this.title, required this.qty, this.price, this.image, this.bgColor});
}

class OrderListItem extends StatefulWidget {
  final OrderItem? item;

  const OrderListItem({Key? key, this.item}) : super(key: key);

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: widget.item!.bgColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: widget.item!.image != null
                ? Image.network(
                    widget.item!.image!,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.item!.title!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  "x${widget.item!.qty}",
                  style: priceTextStyle,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            "${widget.item!.price}",
            style: priceTextStyle,
          ),
        ],
      ),
    );
  }
}
