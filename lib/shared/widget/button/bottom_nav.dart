import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:vendors/module/screen/cart_screen.dart';
import 'package:vendors/module/screen/home.dart';
import 'package:vendors/module/screen/profile_screen.dart';
import 'package:vendors/shared/model/user_model.dart';

class BottomNav extends StatefulWidget {
  final UserModel user;
  const BottomNav({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  // List<Widget> homePages = [
  //   const Center(child: Text('Me')),
  //   Center(child: Home(user: widget.user)),
  //   const Center(child: Text('Me')),
  // ];
  late PageController tabController;
  @override
  void initState() {
    super.initState();
    tabController = PageController(initialPage: 1 - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const Center(child: Home()),
            const Center(child: CartScreen()),
            const Center(child: Text('Favourite')),
            Center(
                child: ProfileScreen(
              user: widget.user,
            )),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home_outlined, title: 'Home'),
          TabItem(icon: Icons.shopping_cart_outlined, title: 'Cart'),
          TabItem(icon: Icons.favorite, title: 'Favourite'),
          TabItem(icon: Icons.person_outline, title: 'Me'),
        ],
        backgroundColor: Colors.white,
        initialActiveIndex: 0,
        activeColor: Colors.blue,
        color: Colors.grey,
        onTabNotify: (int? index) {
          tabController.jumpToPage(index!);
          return true;
        },
      ),
    );
  }
}
