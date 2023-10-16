import 'package:flutter/material.dart';
import 'package:food_recipes/pages/add_recipe_page.dart';
import 'package:food_recipes/pages/favourites_page.dart';
import 'package:food_recipes/pages/food_recipes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(),
      body: _currentIndex == 0
          ? const FoodRecipesPage()
          : _currentIndex == 1
              ? const AddRecipePage()
              : FavouritesPage(),
      bottomNavigationBar: _buildBottomNavigaton(),
    );
  }

  _buildBottomNavigaton() {
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              activeIcon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              activeIcon: Icon(
                Icons.add,
              ),
              label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
              ),
              activeIcon: Icon(
                Icons.favorite,
              ),
              label: "Favourite"),
        ]);
  }
}
