import 'dart:ui';

import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/features/personlization/data/models/address_model.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/models/brand_category_model.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/models/brand_model.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/models/banner_model.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/models/category_model.dart';
import 'package:ecommerce_app/features/shop/modules/order/data/models/order_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_attribute_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_category_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_variation_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TDummyData {
  /// -- User
  // static final UserModel user = UserModel(
  //   fullName: 'Coding with T',
  //   email: 'support@codingwithT.com',
  //   phoneNumber: '+14155552671',
  //   profilePicture: AppImages.user,
  static List<AddressModel> addresses = [
    AddressModel(
      id: '1',
      name: 'Coding with T',
      phoneNumber: '+923178059528',
      street: '82356 Timmy Coves',
      city: 'South Liana',
      state: 'Maine',
      postalCode: '87665',
      country: 'USA',
    ),
    AddressModel(
      id: '6',
      name: 'John Doe',
      phoneNumber: '+1234567890',
      street: '123 Main Street',
      city: 'New York',
      state: 'New York',
      postalCode: '10001',
      country: 'United States',
    ),

    AddressModel(
      id: '2',
      name: 'Alice Smith',
      phoneNumber: '+9876543210',
      street: '456 Elm Avenue',
      city: 'Los Angeles',
      state: 'California',
      postalCode: '90001',
      country: 'United States',
    ),

    AddressModel(
      id: '3',
      name: 'Taimoor Sikander',
      phoneNumber: '+923178059528',
      street: 'Street 35',
      city: 'Islamabad',
      state: 'Federal',
      postalCode: '48000',
      country: 'Pakistan',
    ),

    AddressModel(
      id: '4',
      name: 'Maria Garcia',
      phoneNumber: '+5412345678',
      street: '789 Oak Road',
      city: 'Buenos Aires',
      state: 'Buenos Aires',
      postalCode: '1001',
      country: 'Argentina',
    ),

    AddressModel(
      id: '5',
      name: 'Liam Johnson',
      phoneNumber: '+447890123456',
      street: '10 Park Lane',
      city: 'London',
      state: 'England',
      postalCode: 'SW1A 1AA',
      country: 'United Kingdom',
    ),
  ];

  static final List<BrandModel> brands = [
    BrandModel(
      id: '1',
      image: AppImages.nikeLogo,
      name: 'Nike',
      productsCount: 265,
      isFeatured: true,
    ),
    BrandModel(
      id: '6',
      image: AppImages.zaraLogo,
      name: 'ZARA',
      productsCount: 10,
      isFeatured: true,
    ),
    BrandModel(
      id: '2',
      image: AppImages.appleLogo,
      name: 'Apple',
      productsCount: 15,
      isFeatured: true,
    ),
  ];

  /// -- List of all Categories (parents: parentId empty) + Subcategories (parentId = parent category id)
  static final List<CategoryModel> categoriesList = [
    // --- Parent categories (parentId: '')
    CategoryModel(
      id: '1',
      name: 'Shoes',
      image: AppImages.shoeIcon,
      parentId: '',
      isFeatured: true,
    ),
    CategoryModel(
      id: '2',
      name: 'Jewelery',
      image: AppImages.jeweleryIcon,
      parentId: '',
      isFeatured: true,
    ),
    CategoryModel(
      id: '3',
      name: 'Electronics',
      image: AppImages.electronicsIcon,
      parentId: '',
      isFeatured: true,
    ),
    CategoryModel(
      id: '4',
      name: 'Sports',
      image: AppImages.sportIcon,
      parentId: '',
      isFeatured: true,
    ),
    CategoryModel(
      id: '5',
      name: 'Clothes',
      image: AppImages.clothIcon,
      parentId: '',
      isFeatured: true,
    ),
    CategoryModel(
      id: '6',
      name: 'Furniture',
      image: AppImages.furnitureIcon,
      parentId: '',
      isFeatured: true,
    ),
    CategoryModel(
      id: '7',
      name: 'Pets',
      image: AppImages.animalIcon,
      parentId: '',
      isFeatured: true,
    ),
    CategoryModel(
      id: '8',
      name: 'Cosmetics',
      image: AppImages.cosmeticsIcon,
      parentId: '',
      isFeatured: true,
    ),
    CategoryModel(
      id: '9',
      name: 'Toys',
      image: AppImages.toyIcon,
      parentId: '',
      isFeatured: true,
    ),
    // --- Subcategories (parentId = parent category id)
    CategoryModel(
      id: '10',
      name: 'Running Shoes',
      image: AppImages.shoeIcon,
      parentId: '1',
      isFeatured: true,
    ),
    CategoryModel(
      id: '11',
      name: 'Casual Shoes',
      image: AppImages.shoeIcon,
      parentId: '1',
      isFeatured: true,
    ),
    CategoryModel(
      id: '12',
      name: 'Phones',
      image: AppImages.electronicsIcon,
      parentId: '3',
      isFeatured: true,
    ),
    CategoryModel(
      id: '13',
      name: 'T-Shirts',
      image: AppImages.clothIcon,
      parentId: '5',
      isFeatured: true,
    ),
    CategoryModel(
      id: '14',
      name: 'Jackets',
      image: AppImages.clothIcon,
      parentId: '5',
      isFeatured: true,
    ),
  ];

  /// -- Brand ↔ Category mappings (brandId → categoryId)
  /// Nike (1): Shoes, Sports, Running, Casual
  /// Apple (2): Electronics, Phones
  /// ZARA (6): Clothes, Shoes, T-Shirts, Jackets
  static final List<BrandCategoryModel> brandCategories = [
    BrandCategoryModel(brandId: '1', categoryId: '1'),  // Nike → Shoes
    BrandCategoryModel(brandId: '1', categoryId: '4'),   // Nike → Sports
    BrandCategoryModel(brandId: '1', categoryId: '10'), // Nike → Running Shoes
    BrandCategoryModel(brandId: '1', categoryId: '11'), // Nike → Casual Shoes
    BrandCategoryModel(brandId: '2', categoryId: '3'),   // Apple → Electronics
    BrandCategoryModel(brandId: '2', categoryId: '12'), // Apple → Phones
    BrandCategoryModel(brandId: '6', categoryId: '5'),  // ZARA → Clothes
    BrandCategoryModel(brandId: '6', categoryId: '1'),   // ZARA → Shoes
    BrandCategoryModel(brandId: '6', categoryId: '13'), // ZARA → T-Shirts
    BrandCategoryModel(brandId: '6', categoryId: '14'), // ZARA → Jackets
  ];

  /// -- Product ↔ Category mappings (productId → categoryId)
  static final List<ProductCategoryModel> productCategories = [
    ProductCategoryModel(productId: '001', categoryId: '1'),
    ProductCategoryModel(productId: '001', categoryId: '4'),
    ProductCategoryModel(productId: '001', categoryId: '10'),
    ProductCategoryModel(productId: '002', categoryId: '5'),
    ProductCategoryModel(productId: '002', categoryId: '13'),
    ProductCategoryModel(productId: '003', categoryId: '5'),
    ProductCategoryModel(productId: '003', categoryId: '14'),
    ProductCategoryModel(productId: '004', categoryId: '1'),
    ProductCategoryModel(productId: '004', categoryId: '10'),
    ProductCategoryModel(productId: '005', categoryId: '3'),
    ProductCategoryModel(productId: '005', categoryId: '12'),
    ProductCategoryModel(productId: '006', categoryId: '4'),
    ProductCategoryModel(productId: '006', categoryId: '1'),
    ProductCategoryModel(productId: '007', categoryId: '5'),
    ProductCategoryModel(productId: '007', categoryId: '13'),
    ProductCategoryModel(productId: '008', categoryId: '1'),
    ProductCategoryModel(productId: '008', categoryId: '11'),
    ProductCategoryModel(productId: '009', categoryId: '3'),
    ProductCategoryModel(productId: '009', categoryId: '12'),
    ProductCategoryModel(productId: '010', categoryId: '5'),
    ProductCategoryModel(productId: '010', categoryId: '14'),
  ];

  static final List<BannerModel> banners = [
    BannerModel(
      id: '1',
      imageUrl: AppImages.promoBanner1,
      targetScreen: '/search',
      active: true,
    ),
    BannerModel(
      id: '2',
      imageUrl: AppImages.promoBanner2,
      targetScreen: '/search',
      active: true,
    ),
    BannerModel(
      id: '3',
      imageUrl: AppImages.promoBanner3,
      targetScreen: '/search',
      active: true,
    ),
  ];

  /// -- List of all Products (10+ with images)
  static final List<ProductModel> products = [
    ProductModel(

      id: '001',
      title: 'Green Nike sports shoe',
      stock: 15,
      price: 135,
      isFeatured: true,
      thumbnail: AppImages.productImage1,
      description: 'Green Nike sports shoe.',
      brand: BrandModel(
        id: '1',
        image: AppImages.nikeLogo,
        name: 'Nike',
        productsCount: 265,
        isFeatured: true,
      ),
      images: [
        AppImages.productImage1,
        AppImages.productImage23,
        AppImages.productImage21,
        AppImages.productImage9,
      ],
      salePrice: 30,
      sku: 'NKE-001',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        ProductAttributeModel(
          name: 'Size',
          values: ['EU 30', 'EU 32', 'EU 34'],
        ),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 34,
          price: 134,
          salePrice: 122.6,
          image: AppImages.productImage1,
          description:
              'This is a Product description for Green Nike sports shoe.',
          attributeValues: {'Color': 'Green', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '2',
          stock: 15,
          price: 132,
          image: AppImages.productImage23,
          attributeValues: {'Color': 'Black', 'Size': 'EU 32'},
        ),
        ProductVariationModel(
          id: '3',
          stock: 0,
          price: 234,
          image: AppImages.productImage23,
          attributeValues: {'Color': 'Black', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '4',
          stock: 222,
          price: 232,
          image: AppImages.productImage1,
          attributeValues: {'Color': 'Green', 'Size': 'EU 32'},
        ),
        ProductVariationModel(
          id: '5',
          stock: 0,
          price: 334,
          image: AppImages.productImage21,
          attributeValues: {'Color': 'Red', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '6',
          stock: 11,
          price: 332,
          image: AppImages.productImage21,
          attributeValues: {'Color': 'Red', 'Size': 'EU 32'},
        ),
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '002',
      title: 'Blue T-shirt for all ages',
      stock: 15,
      price: 35,
      isFeatured: true,
      thumbnail: AppImages.productImage69,
      description:
          'Comfortable blue T-shirt for all ages. Perfect for casual wear.',
      brand: BrandModel(
        id: '6',
        image: AppImages.zaraLogo,
        name: 'ZARA',
        productsCount: 10,
        isFeatured: true,
      ),
      images: [
        AppImages.productImage68,
        AppImages.productImage69,
        AppImages.productImage5,
      ],
      salePrice: 30,
      sku: 'ZAR-002',
      categoryId: '5',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '003',
      title: 'Leather brown Jacket',
      stock: 15,
      price: 380,
      isFeatured: true,
      thumbnail: AppImages.productImage64,
      description:
          'Premium leather brown jacket. Classic style for any occasion.',
      brand: BrandModel(
        id: '6',
        image: AppImages.zaraLogo,
        name: 'ZARA',
        productsCount: 10,
        isFeatured: true,
      ),
      images: [
        AppImages.productImage64,
        AppImages.productImage65,
        AppImages.productImage66,
        AppImages.productImage67,
      ],
      salePrice: 320,
      sku: 'ZAR-003',
      categoryId: '5',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Brown', 'Black']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '004',
      title: 'Nike Air Max Running Shoe',
      stock: 25,
      price: 149,
      isFeatured: true,
      thumbnail: AppImages.productImage21,
      description: 'Lightweight Nike Air Max for running and daily wear.',
      brand: BrandModel(
        id: '1',
        image: AppImages.nikeLogo,
        name: 'Nike',
        productsCount: 265,
        isFeatured: true,
      ),
      images: [
        AppImages.productImage21,
        AppImages.productImage1,
        AppImages.productImage23,
      ],
      salePrice: 129,
      sku: 'NKE-004',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Red', 'Black', 'White']),
        ProductAttributeModel(name: 'Size', values: ['EU 40', 'EU 42', 'EU 44']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '005',
      title: 'Smartphone Pro',
      stock: 50,
      price: 899,
      isFeatured: true,
      thumbnail: AppImages.productImage11,
      description: 'Latest smartphone with premium display and camera.',
      brand: BrandModel(
        id: '2',
        image: AppImages.appleLogo,
        name: 'Apple',
        productsCount: 15,
        isFeatured: true,
      ),
      images: [
        AppImages.productImage11,
        AppImages.productImage12,
        AppImages.productImage13,
      ],
      salePrice: 849,
      sku: 'APL-005',
      categoryId: '3',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Black', 'Silver']),
        ProductAttributeModel(name: 'Storage', values: ['128GB', '256GB']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '006',
      title: 'Nike Basketball Shoe Green Black',
      stock: 20,
      price: 120,
      isFeatured: true,
      thumbnail: AppImages.productImage22,
      description: 'Durable basketball shoes for court performance.',
      brand: BrandModel(
        id: '1',
        image: AppImages.nikeLogo,
        name: 'Nike',
        productsCount: 265,
        isFeatured: true,
      ),
      images: [
        AppImages.productImage22,
        AppImages.productImage21,
        AppImages.productImage23,
      ],
      salePrice: 99,
      sku: 'NKE-006',
      categoryId: '4',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU 41', 'EU 42', 'EU 43']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '007',
      title: 'Red Collar T-Shirt',
      stock: 30,
      price: 29,
      isFeatured: false,
      thumbnail: AppImages.productImage60,
      description: 'Casual red collar T-shirt. Soft cotton blend.',
      brand: BrandModel(
        id: '6',
        image: AppImages.zaraLogo,
        name: 'ZARA',
        productsCount: 10,
        isFeatured: true,
      ),
      images: [
        AppImages.productImage60,
        AppImages.productImage61,
        AppImages.productImage62,
      ],
      sku: 'ZAR-007',
      categoryId: '5',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Red', 'Yellow', 'Green']),
        ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '008',
      title: 'Nike Air Jordan White Red',
      stock: 18,
      price: 185,
      isFeatured: true,
      thumbnail: AppImages.productImage10,
      description: 'Classic Nike Air Jordan in white and red.',
      brand: BrandModel(
        id: '1',
        image: AppImages.nikeLogo,
        name: 'Nike',
        productsCount: 265,
        isFeatured: true,
      ),
      images: [
        AppImages.productImage10,
        AppImages.productImage9,
        AppImages.productImage19,
      ],
      salePrice: 165,
      sku: 'NKE-008',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU 39', 'EU 40', 'EU 41']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '009',
      title: 'Smartphone with Back Cover',
      stock: 40,
      price: 749,
      isFeatured: true,
      thumbnail: AppImages.productImage12,
      description: 'Sleek smartphone with premium build.',
      brand: BrandModel(
        id: '2',
        image: AppImages.appleLogo,
        name: 'Apple',
        productsCount: 15,
        isFeatured: true,
      ),
      images: [
        AppImages.productImage12,
        AppImages.productImage11,
        AppImages.productImage13,
      ],
      salePrice: 699,
      sku: 'APL-009',
      categoryId: '3',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Black', 'Blue']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '010',
      title: 'Leather Jacket Black',
      stock: 12,
      price: 420,
      isFeatured: true,
      thumbnail: AppImages.productImage65,
      description: 'Black leather jacket. Timeless style.',
      brand: BrandModel(
        id: '6',
        image: AppImages.zaraLogo,
        name: 'ZARA',
        productsCount: 10,
        isFeatured: true,
      ),
      images: [
        AppImages.productImage65,
        AppImages.productImage64,
        AppImages.productImage66,
        AppImages.productImage67,
      ],
      salePrice: 380,
      sku: 'ZAR-010',
      categoryId: '5',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L', 'XL']),
      ],
      productType: 'ProductType.single',
    ),
  ];

  /// -- Sorting Filters for search
  static final sortingFilters = [
    SortFilterModel(id: '1', name: 'Name'),
    SortFilterModel(id: '2', name: 'Lowest Price'),
    SortFilterModel(id: '3', name: 'Most Popular'),
    SortFilterModel(id: '4', name: 'Highest Price'),
    SortFilterModel(id: '5', name: 'Newest'),
    SortFilterModel(id: '6', name: 'Most Suitable'),
  ];
}
  IconData getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Iconsax.clock;
      case OrderStatus.processing:
        return Iconsax.shopping_bag;
      case OrderStatus.shipped:
        return Iconsax.truck;
      case OrderStatus.delivered:
        return Iconsax.tick_circle;
      case OrderStatus.cancelled:
        return Iconsax.close_circle;
    }
  }

  Color getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.processing:
        return const Color.fromARGB(255, 28, 34, 62);
      case OrderStatus.shipped:
        return AppColors.primary;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

class SortFilterModel {
  String id;
  String name;

  SortFilterModel({required this.id, required this.name});
}
