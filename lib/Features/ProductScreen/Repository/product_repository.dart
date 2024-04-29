import 'dart:convert';

import 'package:ecom_app/Models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final productRepositoryProvider = Provider(
  (ref) => ProductRepository(),
);

class ProductRepository {
  // Future fetchRestaurants() async {
  //   Product datas;
  //   try {
  //     final response =
  //         await http.get((Uri.parse("https://fakestoreapi.com/products")));
  //     print("status code");
  //     print(response.statusCode);
  //     print("body");
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       print(data);
  //       // datas = Restaurants.fromJson(data);
  //       // return datas;
  //       // _resto = Restaurants.fromJson(data);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     // datas = Restaurants.fromJson(a);
  //   }
  // }
  Future<List<Product>> fetchProducts() async {
    List<Product> fetchData = [];
    try {
      final response =
          await http.get((Uri.parse("https://fakestoreapi.com/products")));
      print("status code");
      print(response.statusCode);
      print("body");
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        print(data);
        for (var i in data) {
          final product = Product.fromMap(i);
          final res = product.copyWith(cart: 0);
          fetchData.add(res);
        }
      }
      return fetchData;
    } catch (e) {
      print(e.toString());
      return fetchData;
    }
  }
}
