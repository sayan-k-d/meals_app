import 'package:flutter/material.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

const kDefaultFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedTab = 0;
  // final List<Meal> _favoriteMeals = [];
  // Map<Filters, bool> _filters = kDefaultFilters;

  void _onTabChanged(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  // void _displaySnackBar(String msg) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(msg),
  //     ),
  //   );
  // }

  // void setFavoriteMeal(Meal meal) {
  //   if (_favoriteMeals.contains(meal)) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //       _displaySnackBar("Meal Is No Longer Favorite!");
  //     });
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _displaySnackBar("Meal Is Marked as Favorite!");
  //     });
  //   }
  // }

  void _onSelectScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      await Navigator.push<Map<Filters, bool>>(
        context,
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
              // filters: _filters,
              ),
        ),
      );
      // setState(() {
      //   _filters = filtersMap ?? kDefaultFilters;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final filters = ref.watch(filtersProvider);
    final availableFIlteredMeals = meals.where((meal) {
      if (filters[Filters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filters[Filters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filters[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (filters[Filters.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget content = CategoriesScreen(
      // onSetFavoriteMeal: setFavoriteMeal,
      availableFilteredMeals: availableFIlteredMeals,
    );
    String title = "Categories";
    if (_selectedTab == 1) {
      content = MealsScreen(
        meals: favoriteMeals,
        // onSetFavoriteMeal: setFavoriteMeal,
      );
      title = "Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      drawer: MainDrawer(
        onTapMenu: _onSelectScreen,
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
