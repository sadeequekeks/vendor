class FoodModel {
  final String name;
  final String description;
  final String price;
  final String category;

  FoodModel(
      {required this.name,
      required this.category,
      required this.description,
      required this.price});

  Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "price": price,
        "category": category
      };
}
