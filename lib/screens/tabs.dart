import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedTab = 0;
  final List<Meal> _favoriteMeals = [];
  void _onTabChanged(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  void setFavoriteMeal(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = CategoriesScreen(
      onSetFavoriteMeal: setFavoriteMeal,
    );
    String title = "Categories";
    if (_selectedTab == 1) {
      content = MealsScreen(
        meals: _favoriteMeals,
        onSetFavoriteMeal: setFavoriteMeal,
      );
      title = "Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabChanged,
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
