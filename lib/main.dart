import 'package:flutter/material.dart';
import 'package:food_recipes/models/food_recipe_model.dart';
import 'package:food_recipes/pages/splash_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FoodRecipeModelAdapter());
  await Hive.openBox("default");
  await Hive.openBox<FoodRecipeModel>("recipes");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
