import 'package:flutter/material.dart';

String networkImageUri =
    'https://media-cdn.tripadvisor.com/media/photo-s/1c/88/f9/30/half-and-half-pepperoni.jpg';

class FoodCard extends StatelessWidget {
  const FoodCard({
    Key? key,
    required this.foodTitle,
    required this.foodContent,
    required this.onTap,
    required this.rating,
    required this.time,
  }) : super(key: key);
  final String foodTitle, foodContent;
  final String rating;
  final String time;

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(0, 2.5),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(6),
                      topLeft: Radius.circular(6),
                    ),
                    child: Image.network(
                      networkImageUri,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(foodTitle),
                subtitle: Text(foodContent),
                trailing: Column(
                  children: [
                    Text('⭐ $rating'),
                    const SizedBox(height: 8.0),
                    Text(
                      time,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
