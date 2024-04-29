class CategoryModel {
  late CategoryDataModel data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    data = CategoryDataModel.fromJson(json["data"]);
  }
}

class CategoryDataModel {
  late String category;
  List<DataModel_C>? data = [];

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    json['data'].forEach((element) {
      data?.add(DataModel_C.fromJson(element));
    });
  }
}

class DataModel_C {
  late String name;
  late String image;

  DataModel_C.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }
}
