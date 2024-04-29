import 'package:ecom_app/Models/product_model.dart';

class GetCartModel {
  late bool status;
  List<Product> products = [];

  GetCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    json['data']['data'].forEach((product) {
      products.add(Product.fromMap(product['product']));
    });
  }
}
