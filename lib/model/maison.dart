

class Maison{
  int id;
  String item_code;
  String price;
  String localisation;
  String description;
  int bathrooms;
  int area;
  String model;
  String category;
  String path;

  Maison({
      required this.id,
      required this.item_code,
      required this.price,
      required this.localisation,
      required this.description,
      required this.bathrooms,
      required this.area,
      required this.model,
      required this.category,
      required this.path});

  factory Maison.fromMap(dynamic map,String host) {
    return Maison(id: map['id'], item_code: map['item_code'], price: map['price'], localisation: map['localisation'], description: map['description'], bathrooms: map['bathrooms'], area: map['area'], model: map['model'], category: map['category'], path: host+map['path']

    );
  }
}