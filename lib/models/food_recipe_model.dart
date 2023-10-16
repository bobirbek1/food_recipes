import 'package:hive_flutter/hive_flutter.dart';

part 'food_recipe_model.g.dart';

@HiveType(typeId: 0)
class FoodRecipeModel extends HiveObject {
  @HiveField(0)
   String id;
  @HiveField(1)
   String name;
  @HiveField(2)
   List<String> recipes;
  @HiveField(3)
   String image;
  @HiveField(4)
   int categoryIndex;
  @HiveField(5)
   int duration;
  @HiveField(6)
   String steps;
  @HiveField(7)
  bool isFavourite;
  @HiveField(8)
   String createdAt;

  FoodRecipeModel({
    required this.id,
    required this.name,
    required this.recipes,
    required this.image,
    required this.categoryIndex,
    required this.duration,
    required this.steps,
    this.isFavourite = false,
    required this.createdAt,
  });

  FoodCategories get getCategory => FoodCategories.values[categoryIndex];

  @override
  String toString() {
    return "food reciep, id => $id,name => $name, recipes => $recipes";
  }
}

enum FoodCategories {
  food,
  salads,
  drinks,
  desert,
}
