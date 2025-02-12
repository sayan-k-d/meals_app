import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItems extends StatelessWidget {
  const MealItems({
    super.key,
    required this.meal,
    required this.onSelectedMeal,
  });
  final Meal meal;
  final void Function() onSelectedMeal;

  String _formatComplexity(Complexity complexity) {
    return complexity.name[0].toUpperCase() + complexity.name.substring(1);
  }

  String _formatAffordability(Affordability affordability) {
    return affordability.name[0].toUpperCase() +
        affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onSelectedMeal,
        splashColor: Theme.of(context).colorScheme.onSurface,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(color: Colors.black54),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          metaData: '${meal.duration} min',
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          metaData: _formatComplexity(meal.complexity),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MealItemTrait(
                          icon: Icons.schedule,
                          metaData: _formatAffordability(meal.affordability),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
