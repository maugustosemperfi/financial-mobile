import 'dart:convert';

import 'package:financial/application.dart';
import 'package:financial/model/category.dart';

class CategoriesService {
  static dynamic getCategoriesJson() async {
    final categoriesJson = await Application.dio.get('categories');

    return categoriesJson.data;
  }

  static getCategories() async {
    final categoriesJson = await Application.dio.get('categories');

    final categories = (jsonDecode(categoriesJson.data) as List)
        .map((category) => Category.fromJson(category))
        .toList();

    return categories;
  }
}
