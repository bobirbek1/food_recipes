import 'package:flutter/material.dart';
import 'package:food_recipes/models/food_recipe_model.dart';
import 'package:food_recipes/pages/repository.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController imageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController stepsController = TextEditingController();
  final List<TextEditingController> recipeControllers = [
    TextEditingController(),
    TextEditingController()
  ];

  int? durationValue = 15;
  int? categoryValue = 0;

  final Repository repo = Repository();

  @override
  void initState() {
    print("recipe in db => ${repo.getRecipesFromDb()}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add recipe",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final recipe = FoodRecipeModel(
                id: UniqueKey().toString(),
                name: nameController.text,
                recipes: recipeControllers.map((ctrl) => ctrl.text).toList(),
                image: imageController.text,
                categoryIndex: categoryValue!,
                duration: durationValue!,
                steps: stepsController.text,
                createdAt: DateTime.now().toString(),
              );
              repo.addRecipeToDb(recipe);
            },
            child: const Text("Save"),
          )
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageContainer(),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add Image",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          "Add image url",
                          imageController,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                            minimumSize: const Size(
                              80,
                              56,
                            ),
                          ),
                          child: const Text("Load")),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Recipe name",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  _buildTextField(
                    "Recipe name",
                    nameController,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Recipes",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  ...List.generate(recipeControllers.length * 2 - 1, (index) {
                    return index.isOdd
                        ? const SizedBox(
                            height: 8,
                          )
                        : _buildTextField("", recipeControllers[index ~/ 2]);
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          recipeControllers.add(TextEditingController());
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Add recipe",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Duration",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          DropdownButton(
                            value: durationValue,
                            items: List.generate(
                              8,
                              (index) => DropdownMenuItem(
                                value: index * 15 + 15,
                                child: Text(
                                  "${index * 15 + 15}",
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                durationValue = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          DropdownButton(
                            value: categoryValue,
                            items: FoodCategories.values
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.index,
                                    child: Text(
                                      e.name,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (index) {
                              setState(() {
                                categoryValue = index;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Steps",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black26,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: TextField(
                      maxLines: null,
                      controller: stepsController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: "Enter steps...",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildImageContainer() {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.black12,
      child: imageController.text.isEmpty
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image,
                  color: Colors.black38,
                  size: 100,
                ),
                SizedBox(
                  height: 8,
                ),
                Text("Add image"),
              ],
            )
          : Image.network(
              imageController.text,
              fit: BoxFit.cover,
            ),
    );
  }

  _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12,
          ),
          borderSide: const BorderSide(
            color: Colors.black45,
            width: 2,
          ),
        ),
        hintText: hint,
      ),
    );
  }
}
