import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SortDropdown extends StatelessWidget {
  const SortDropdown({
    super.key,
    required this.onChanged,
    this.initialValue = 'Name',
  });

  final void Function(String?)? onChanged;
  final String initialValue;

  static const List<String> _sortOptions = [
    'Name',
    'Higher Price',
    'Lower Price',
    'Sale',
    'Newest',
    'Popularity',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: initialValue,
      decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
      onChanged: onChanged,
      items: _sortOptions
          .map(
            (option) => DropdownMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          )
          .toList(),
    );
  }
}
