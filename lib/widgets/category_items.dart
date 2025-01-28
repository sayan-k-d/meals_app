import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({
    super.key,
    required this.category,
    required this.onSelectedCategory,
  });
  final Category category;
  final void Function(String id, String title) onSelectedCategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        onSelectedCategory(category.id, category.title);
      },
      splashColor: Theme.of(context).colorScheme.surface,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              category.color.withValues(alpha: 0.55),
              category.color.withValues(alpha: 0.9),
            ])),
        child: Center(
            child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
