import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

class FilterItems extends ConsumerWidget {
  const FilterItems({
    super.key,
    this.isFilterChecked = false,
    // required this.onCheckedFilter,
    required this.title,
    required this.subTitle,
    required this.filterIdentifier,
  });
  final bool isFilterChecked;
  final String title;
  final String subTitle;
  final Filters filterIdentifier;
  // final void Function(bool value, String filterIdentifier) onCheckedFilter;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      value: isFilterChecked,
      onChanged: (value) {
        ref.read(filtersProvider.notifier).setFilter(filterIdentifier, value);
        // onCheckedFilter(value, filterIdentifier);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
