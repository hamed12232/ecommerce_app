import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/features/personlization/data/models/address_model.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/models/banner_model.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/models/category_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/brand_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_attribute_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_variation_model.dart';

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
  

  /// -- List of all Categories
  static final List<CategoryModel> categoriesList = [
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

  /// -- List of all Products
  static final List<ProductModel> products = [
    ProductModel(
      id: '001',
      title: 'Green Nike sports shoe',
      stock: 15,
      price: 135,
      isFeatured: true,
      thumbnail: AppImages.productImage1,
      description: 'Green Nike sports shoe',
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
      sku: 'ABR4568',
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
          'This is a Product description for Blue Nike Sleeve less vest. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '6', image: AppImages.zaraLogo, name: 'ZARA'),
      images: [
        AppImages.productImage68,
        AppImages.productImage69,
        AppImages.productImage5,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
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
      price: 38000,
      isFeatured: false,
      thumbnail: AppImages.productImage64,
      description:
          'This is a Product description for Leather brown Jacket. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '6', image: AppImages.zaraLogo, name: 'ZARA'),
      images: [
        AppImages.productImage64,
        AppImages.productImage65,
        AppImages.productImage66,
        AppImages.productImage67,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: 'ProductType.single',
    ),

    ///Products after banner
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

class SortFilterModel {
  String id;
  String name;

  SortFilterModel({required this.id, required this.name});
}
