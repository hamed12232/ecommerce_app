import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart'; // Optional for nice icons

class SortDropdown extends StatefulWidget {
  const SortDropdown({super.key});

  @override
  State<SortDropdown> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown> {
  String selectedValue = 'Name';
  final List<String> options = ['Name', 'Price', 'Date', 'Category'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
      onChanged: (value) {},
      items:
          [
                'Name',
                'Higher Price',
                'Lower Price',
                'Sale',
                'Newest',
                'Popularity',
              ]
              .map(
                (option) => DropdownMenuItem(
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
