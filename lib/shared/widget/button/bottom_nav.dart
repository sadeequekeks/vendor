import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:vendors/module/screen/home.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> homePages = [
    const Center(child: Text('Me')),
    const Center(child: Home()),
    const Center(child: Text('Me')),
  ];
  late PageController tabController;
  @override
  void initState() {
    super.initState();
    tabController = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: homePages,
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.shopping_cart_outlined, title: 'Cart'),
          TabItem(icon: Icons.home_outlined, title: 'Home'),
          TabItem(icon: Icons.person_outline, title: 'Me'),
        ],
        backgroundColor: Colors.white,
        initialActiveIndex: 1,
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
