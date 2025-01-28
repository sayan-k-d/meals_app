import 'package:flutter/material.dart';
import 'package:meals_app/data/category_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_items.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onSetFavoriteMeal});
  final void Function(Meal meal) onSetFavoriteMeal;

  void _selectedCategory(BuildContext context, String id, String title) {
    final filteredCategory =
        dummyMeals.where((meal) => meal.categories.contains(id)).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: title,
          meals: filteredCategory,
          onSetFavoriteMeal: onSetFavoriteMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView(
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        children: [
          for (final category in availableCategories)
            CategoryItems(
              category: category,
              onSelectedCategory: (id, title) {
                _selectedCategory(context, id, title);
              },
            )
        ],
      ),
    );
  }
}
