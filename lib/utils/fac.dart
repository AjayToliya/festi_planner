class Festivals {
  String name;
  String image;
  List<String> images;

  Festivals({
    required this.name,
    required this.image,
    required this.images,
  });

  factory Festivals.fromMap(Map<String, dynamic> data) {
    return Festivals(
      name: data["name"],
      image: data["image"],
      images: data["images"],
    );
  }
}
