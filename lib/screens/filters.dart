import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/widgets/filter_items.dart';

// enum Filters {
//   glutenFree,
//   lactoseFree,
//   vegetarian,
//   vegan,
// }

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});
  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  bool _glutenFilter = false;
  bool _lactoseFilter = false;
  bool _vegetarianFilter = false;
  bool _veganFilter = false;

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filtersProvider);
    _glutenFilter = activeFilters[Filters.glutenFree]!;
    _lactoseFilter = activeFilters[Filters.lactoseFree]!;
    _vegetarianFilter = activeFilters[Filters.vegetarian]!;
    _veganFilter = activeFilters[Filters.vegan]!;
  }

  void _onFilterChecked(bool value, String filterIdentifier) {
    if (filterIdentifier == 'glutenFree') {
      setState(() {
        _glutenFilter = value;
      });
    } else if (filterIdentifier == 'lactoseFree') {
      setState(() {
        _lactoseFilter = value;
      });
    } else if (filterIdentifier == 'vegetarian') {
      setState(() {
        _vegetarianFilter = value;
      });
    } else {
      setState(() {
        _veganFilter = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          ref.read(filtersProvider.notifier).setFilters({
            Filters.glutenFree: _glutenFilter,
            Filters.lactoseFree: _lactoseFilter,
            Filters.vegetarian: _vegetarianFilter,
            Filters.vegan: _veganFilter,
          });
          // Navigator.of(context).pop({
          //   Filters.glutenFree: _glutenFilter,
          //   Filters.lactoseFree: _lactoseFilter,
          //   Filters.vegetarian: _vegetarianFilter,
          //   Filters.vegan: _veganFilter,
          // });
        },
        child: Column(
          children: [
            FilterItems(
              // onCheckedFilter: _onFilterChecked,
              title: 'Gluten-free',
              subTitle: "Only include gluten-free meals.",
              filterIdentifier: Filters.glutenFree,
              isFilterChecked: _glutenFilter,
            ),
            FilterItems(
              // onCheckedFilter: _onFilterChecked,
              title: 'Lactose-free',
              subTitle: "Only include lactose-free meals.",
              filterIdentifier: Filters.lactoseFree,
              isFilterChecked: _lactoseFilter,
            ),
            FilterItems(
              // onCheckedFilter: _onFilterChecked,
              title: 'Vegetarian',
              subTitle: "Only include vegetarian meals.",
              filterIdentifier: Filters.vegetarian,
              isFilterChecked: _vegetarianFilter,
            ),
            FilterItems(
              // onCheckedFilter: _onFilterChecked,
              title: 'Vegan',
              subTitle: "Only include vegan meals.",
              filterIdentifier: Filters.vegan,
              isFilterChecked: _veganFilter,
            ),
          ],
        ),
      ),
    );
  }
}
