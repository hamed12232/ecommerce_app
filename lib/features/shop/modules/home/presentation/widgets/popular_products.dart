import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/product_card_vertical.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key, required this.products});
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return GridLayout(
      itemCount: products.length,
      itemBuilder: (_, index) => ProductCardVertical(product: products[index]),
    );
  }
}
