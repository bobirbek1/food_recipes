import 'package:flutter/material.dart';
import 'package:food_recipes/models/food_recipe_model.dart';
import 'package:food_recipes/pages/recipe_detail_page.dart';
import 'package:food_recipes/pages/repository.dart';
import 'package:food_recipes/widgets/food_recipe_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FoodRecipesPage extends StatefulWidget {
  const FoodRecipesPage({super.key});

  @override
  State<FoodRecipesPage> createState() => _FoodRecipesPageState();
}

class _FoodRecipesPageState extends State<FoodRecipesPage> {
  int _tabIndex = 0;

  final repo = Repository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Food recipes",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: repo.box.listenable(),
                builder: (context, value, child) {
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    padding: const EdgeInsets.all(20),
                    children: _getFilteredRecipes(repo.getRecipesFromDb())
                        .map(
                          (recipe) => FoodRecipeItem(
                            name: recipe.name,
                            image: recipe.image,
                            duration: recipe.duration,
                            isFavourite: recipe.isFavourite,
                            onFavourite: () {
                              repo.toogleRecipeFavourite(recipe);
                            },
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RecipeDetailPage(),
                                  settings: RouteSettings(
                                    arguments: recipe,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTabBar() {
    return TabBar(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        isScrollable: true,
        onTap: (value) {
          setState(() {
            _tabIndex = value;
          });
        },
        tabs: [
          _buildTab("All"),
          _buildTab("Foods"),
          _buildTab("Salads"),
          _buildTab("Drinks"),
          _buildTab("Deserts"),
        ]);
  }

  List<FoodRecipeModel> _getFilteredRecipes(List<FoodRecipeModel> recipes) {
    switch (_tabIndex) {
      case 0:
        return recipes;
      case 1:
        return recipes
            .where(
                (element) => element.categoryIndex == FoodCategories.food.index)
            .toList();
      case 2:
        return recipes
            .where((element) =>
                element.categoryIndex == FoodCategories.salads.index)
            .toList();
      case 3:
        return recipes
            .where((element) =>
                element.categoryIndex == FoodCategories.drinks.index)
            .toList();
      case 4:
        return recipes
            .where((element) =>
                element.categoryIndex == FoodCategories.desert.index)
            .toList();
      default:
        return [];
    }
  }

  _buildTab(String? text) {
    return Tab(
      text: text,
    );
  }
}

final demoFoodRecipes = [
  FoodRecipeModel(
    id: "0",
    name: "Alfredo",
    recipes: [
      "Yog' 100 ml",
      "Un 200gr",
      "Sir 50gr",
      "Moloko 120ml",
      "tuxum 2 dona"
    ],
    image:
        "https://img.delicious.com.au/G-2mxbOh/w1200/del/2022/08/parmesan-crumbed-chicken-schnitzel-fried-eggs-and-apple-cabbage-slaw-173352-2.jpg",
    categoryIndex: FoodCategories.salads.index,
    duration: 60,
    isFavourite: true,
    steps: "Some steps",
    createdAt: DateTime.now().toString(),
  ),
  FoodRecipeModel(
    id: "1",
    name: "Osh",
    recipes: [
      "Yog' 100 ml",
      "Un 200gr",
      "Sir 50gr",
      "Moloko 120ml",
      "tuxum 2 dona"
    ],
    image:
        "https://img.delicious.com.au/G-2mxbOh/w1200/del/2022/08/parmesan-crumbed-chicken-schnitzel-fried-eggs-and-apple-cabbage-slaw-173352-2.jpg",
    categoryIndex: FoodCategories.food.index,
    duration: 120,
    steps: "Some steps",
    createdAt: DateTime.now().toString(),
  ),
  FoodRecipeModel(
    id: "2",
    name: "Mastava",
    recipes: [
      "Yog' 100 ml",
      "Un 200gr",
      "Sir 50gr",
      "Moloko 120ml",
      "tuxum 2 dona"
    ],
    isFavourite: true,
    image:
        "https://img.delicious.com.au/G-2mxbOh/w1200/del/2022/08/parmesan-crumbed-chicken-schnitzel-fried-eggs-and-apple-cabbage-slaw-173352-2.jpg",
    categoryIndex: FoodCategories.food.index,
    duration: 90,
    steps: "Some steps",
    createdAt: DateTime.now().toString(),
  ),
  FoodRecipeModel(
    id: "3",
    name: "Sezar",
    recipes: [
      "Yog' 100 ml",
      "Un 200gr",
      "Sir 50gr",
      "Moloko 120ml",
      "tuxum 2 dona"
    ],
    image:
        "https://img.delicious.com.au/G-2mxbOh/w1200/del/2022/08/parmesan-crumbed-chicken-schnitzel-fried-eggs-and-apple-cabbage-slaw-173352-2.jpg",
    categoryIndex: FoodCategories.salads.index,
    duration: 150,
    steps: "Some steps",
    createdAt: DateTime.now().toString(),
  ),
  FoodRecipeModel(
    id: "4",
    name: "Napaleon",
    recipes: [
      "Yog' 100 ml",
      "Un 200gr",
      "Sir 50gr",
      "Moloko 120ml",
      "tuxum 2 dona"
    ],
    image:
        "https://img.delicious.com.au/G-2mxbOh/w1200/del/2022/08/parmesan-crumbed-chicken-schnitzel-fried-eggs-and-apple-cabbage-slaw-173352-2.jpg",
    categoryIndex: FoodCategories.desert.index,
    duration: 60,
    steps: "Some steps",
    createdAt: DateTime.now().toString(),
  ),
  FoodRecipeModel(
    id: "5",
    name: "Makaron",
    recipes: [
      "Yog' 100 ml",
      "Un 200gr",
      "Sir 50gr",
      "Moloko 120ml",
      "tuxum 2 dona"
    ],
    image:
        "https://img.delicious.com.au/G-2mxbOh/w1200/del/2022/08/parmesan-crumbed-chicken-schnitzel-fried-eggs-and-apple-cabbage-slaw-173352-2.jpg",
    categoryIndex: FoodCategories.food.index,
    duration: 90,
    steps: "Some steps",
    isFavourite: true,
    createdAt: DateTime.now().toString(),
  ),
];
