import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/models/cart_item_model.dart';
import 'package:flutter/material.dart';

Map<String, dynamic> categories = {
  "images": [
    AppImages.shoeIcon,
    AppImages.jeweleryIcon,
    AppImages.electronicsIcon,
    AppImages.sportIcon,
    AppImages.clothIcon,
    AppImages.furnitureIcon,
    AppImages.animalIcon,
    AppImages.cosmeticsIcon,
    AppImages.toyIcon,
  ],
  "titles": [
    "Shoes",
    "Jewelery",
    "Electronics",
    "Sports",
    "Clothes",
    "Furniture",
    "Pets",
    "Cosmetics",
    "Toys",
  ],
};
final List<String> images = [
  AppImages.productImage1,
  AppImages.productImage5,
  AppImages.productImage7,
  AppImages.productImage9,
];

final List<Color> colors = [Colors.green, Colors.black, Colors.red];
final List<String> sizes = ['EU 30', 'EU 32', 'EU 34'];

final List<CartItemModel> cartItems = [
  CartItemModel(
    productId: 'P001',
    variationId: 'V001',
    quantity: 1,
    title: 'Nike Air Max Shoes',
    brandName: 'Nike',
    image: AppImages.nikeLogo,
    price: 120.0,
    selectedVariation: {'Size': '42', 'Color': 'Black'},
  ),
  CartItemModel(
    productId: 'P002',
    variationId: 'V002',
    quantity: 2,
    title: 'Adidas Ultraboost',
    brandName: 'Adidas',
    image: AppImages.zaraLogo,
    price: 150.0,
    selectedVariation: {'Size': '43', 'Color': 'White'},
  ),
  CartItemModel(
    productId: 'P003',
    variationId: 'V003',
    quantity: 1,
    title: 'Puma Running Shoes',
    brandName: 'Puma',
    image: AppImages.appleLogo,
    price: 99.0,
    selectedVariation: {'Size': '41', 'Color': 'Blue'},
  ),
  CartItemModel(
    productId: 'P004',
    variationId: 'V004',
    quantity: 3,
    title: 'Reebok Classic',
    brandName: 'Reebok',
    image: AppImages.appleLogo,
    price: 110.0,
    selectedVariation: {'Size': '44', 'Color': 'Grey'},
  ),
  CartItemModel(
    productId: 'P005',
    variationId: 'V005',
    quantity: 1,
    title: 'New Balance 574',
    brandName: 'New Balance',
    image: AppImages.appleLogo,
    price: 130.0,
    selectedVariation: {'Size': '42', 'Color': 'Navy'},
  ),
];
