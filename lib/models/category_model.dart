class CategoryModel {
  List<String> menApparel = [];
  List<String> womenApparel = [];
  List<CategoryItemModel> items = [];

  CategoryModel.formJson(Map<String, dynamic> data) {
    data["MEN APPAREL"].forEach((element) {
      menApparel.add(element);
    });
    data["WOMEN APPAREL"].forEach((element) {
      womenApparel.add(element);
    });
    data["items"].forEach((element) {
      items.add(CategoryItemModel.fromJson(element));
    });
  }
}

class CategoryItemModel {
  String? name;
  String? icon;
  String? color;

  CategoryItemModel.fromJson(Map<String, dynamic> data) {
    name = data["name"];
    icon = data["icon"];
    color = data["color"];
  }
}
