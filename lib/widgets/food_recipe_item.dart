import 'package:flutter/material.dart';

class FoodRecipeItem extends StatelessWidget {
  final String image;
  final String name;
  final int duration;
  final bool isFavourite;
  final VoidCallback? onPressed;
  final VoidCallback? onFavourite;
  const FoodRecipeItem(
      {required this.name,
      required this.image,
      required this.duration,
      this.onPressed,
      this.onFavourite,
      this.isFavourite = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          image: DecorationImage(
              image: NetworkImage(
                image,
              ),
              fit: BoxFit.cover),
        ),
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Material(
              color: Colors.black.withOpacity(0.4),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(
                  12,
                ),
              ),
              child: IconButton(
                onPressed: onFavourite,
                splashRadius: 20,
                iconSize: 24,
                icon: isFavourite
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
            const Expanded(child: SizedBox()),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  0.4,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(
                    20,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "$duration min",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
