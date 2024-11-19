class CartModel {
  String? nama;
  String? price;
  String? imagePath;
  String? quantity;

  CartModel({
    this.nama,
    this.price,
    this.imagePath,
    this.quantity,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    price = json['price'];
    imagePath = json['imagePath'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['price'] = price;
    data['imagePath'] = imagePath;
    data['quantity'] = quantity;
    return data;
  }
}
