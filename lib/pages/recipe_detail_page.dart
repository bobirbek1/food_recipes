import 'package:flutter/material.dart';
import 'package:food_recipes/models/food_recipe_model.dart';
import 'package:food_recipes/pages/edit_recipe_page.dart';
import 'package:food_recipes/pages/repository.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({super.key});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  FoodRecipeModel? recipe;

  final repo = Repository();

  @override
  void didChangeDependencies() {
    recipe ??= ModalRoute.of(context)?.settings.arguments as FoodRecipeModel?;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(
        recipe!.name,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        SizedBox(
          width: 36,
          child: IconButton(
            onPressed: () async {
              await recipe?.delete();
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            splashRadius: 18,
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.delete_rounded,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: 36,
          child: IconButton(
            onPressed: () {
              Navigator.push<FoodRecipeModel>(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditRecipePage(),
                  settings: RouteSettings(
                    arguments: recipe,
                  ),
                ),
              ).then((value) => setState(() {
                    recipe = value ?? recipe;
                  }));
            },
            splashRadius: 18,
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    recipe!.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Material(
                color: Colors.black.withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    12,
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    repo.toogleRecipeFavourite(recipe!).then((value) {
                      setState(() {});
                    });
                  },
                  splashRadius: 20,
                  iconSize: 24,
                  icon: recipe!.isFavourite
                      ? const Icon(
                          Icons.favorite,
                          size: 28,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border_rounded,
                          size: 28,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Category: ${recipe!.getCategory.name}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Text(
                  "Duration: ${recipe!.duration} min",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              "Recipes",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ...recipe!.recipes
                .map(
                  (e) => Text(
                    e,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                )
                .toList(),
            const SizedBox(
              height: 32,
            ),
            const Text(
              "Steps",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                recipe!.steps,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
