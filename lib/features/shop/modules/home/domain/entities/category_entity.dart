class CategoryEntity {
  final String id;
  final String name;
  final String image;
  final String parentId;
  final bool isFeatured;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.parentId,
    required this.isFeatured,
  });
}
