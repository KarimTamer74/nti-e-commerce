class ProductModel {
  final int id, stock;
  final String image, title, desc, category;
  final double price, rating;

  ProductModel({
    required this.id,
    required this.stock,
    required this.image,
    required this.title,
    required this.desc,
    required this.category,
    required this.price,
    required this.rating,
  });
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      stock: map['stock'],
      image: map['thumbnail'],
      title: map['title'],
      desc: map['description'],
      category: map['category'],
      price: map['price'],
      rating: map['rating'],
    );
  }
  toMap() {
    return {
      'id': id,
      'stock': stock,
      'thumbnail': image,
      'title': title,
      'description': desc,
      'category': category,
      'price': price,
      'rating': rating,
    };
  }
}
