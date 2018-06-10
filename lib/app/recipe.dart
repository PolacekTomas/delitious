//enum RecipeType { meat_dish, veggie_dish, dessert }

import 'package:firebase_database/firebase_database.dart';

class Recipe {
  Recipe.fromSnapshot(DataSnapshot snapshot) {
    this.key = snapshot.key;
    this.name = snapshot.value['name'];
    this.desc = snapshot.value['desc'];
    List<dynamic> ingredients = snapshot.value['ingredients'];
    ingredients.forEach((ing) => this.ingredients.add(ing));
    this.manual = snapshot.value['manual'];
    this.photo = "images/meat_dish.jpg";
  }

  toJson() {
    return {
      "name": name,
      "desc": desc,
      "manual": manual,
    };
  }

  String key;
  String name;
  String desc;
  String photo;
  List<String> ingredients = <String>[];
  String manual;
  //bool isFavorite;

  String get tag => key;
}

