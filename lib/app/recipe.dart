//enum RecipeType { meat_dish, veggie_dish, dessert }

import 'package:firebase_database/firebase_database.dart';

class Recipe {
  Recipe({
    this.type = "meat_dish",
    this.name,
    this.desc,
    this.photo,
    this.ingredients = const ["Mlieko", "Cukor", "Vajcia"],
    this.manual,
    this.isFavorite = false,
  });

  Recipe.fromSnapshot(DataSnapshot snapshot)
    : key = snapshot.key,
      name = snapshot.value['name'],
      desc = snapshot.value['desc'],
      //ingredients = snapshot.value['ingredients'].toString(),
      manual = snapshot.value['manual'],
      photo = "images/meat_dish.jpg";

  toJson() {
    return {
      "type": type,
      "name": name,
      "desc": desc,
      "manual": manual,
    };
  }

  final String key;
  final String type;
  final String name;
  final String desc;
  final String photo;
  final List<String> ingredients;
  final String manual;
  bool isFavorite;

  String get tag => key;
}

