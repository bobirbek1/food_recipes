import 'package:food_recipes/models/food_recipe_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Repository {
  final Box<FoodRecipeModel> box = Hive.box("recipes");

  Repository();

  void addRecipeToDb(FoodRecipeModel recipe) async {
    try {
      box.add(recipe);
    } catch (e) {
      print("add recipe to db throw an error => $e");
    }
  }

  List<FoodRecipeModel> getRecipesFromDb() {
    try {
      return box.values.toList();
    } catch (e) {
      print("get recipes from db throw an error => $e");
      return [];
    }
  }

  Future<void> toogleRecipeFavourite(FoodRecipeModel recipe) async {
    try {
      recipe.isFavourite = !recipe.isFavourite;
      await recipe.save();
    } catch (e) {
      print("change recipe favourite error => $e");
    }
  }
}
