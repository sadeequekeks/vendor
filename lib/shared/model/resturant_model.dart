class ResturantModel {
  final String name;
  final String description;
  final String rating;
  final String address;

  ResturantModel({
    required this.name,
    required this.address,
    required this.description,
    required this.rating,
  });

  Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "address": address,
        "rating": rating
      };
}
