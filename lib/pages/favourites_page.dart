// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:food_recipes/pages/repository.dart';
import 'package:food_recipes/widgets/food_recipe_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavouritesPage extends StatelessWidget {
  FavouritesPage({super.key});
  final repo = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourites",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: ValueListenableBuilder(
        valueListenable: repo.box.listenable(),
        builder: (context, value, child) {
          final favouriteRecipes =
              repo.getRecipesFromDb().where((element) => element.isFavourite);
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            padding: const EdgeInsets.all(20),
            children: favouriteRecipes
                .map(
                  (recipe) => FoodRecipeItem(
                    name: recipe.name,
                    image: recipe.image,
                    duration: recipe.duration,
                    isFavourite: recipe.isFavourite,
                    onFavourite: () {
                      repo.toogleRecipeFavourite(recipe);
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
