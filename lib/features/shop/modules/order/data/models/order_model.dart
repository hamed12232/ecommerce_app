import 'package:ecommerce_app/features/shop/modules/cart/data/models/cart_item_model.dart';

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

class OrderModel {
  final String id;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String paymentMethod;
  final String? addressId;
  final String? address;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.status = OrderStatus.pending,
    required this.totalAmount,
    required this.orderDate,
    this.deliveryDate,
    this.paymentMethod = 'Paypal',
    this.addressId,
    this.address,
    this.items = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.name,
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'paymentMethod': paymentMethod,
      'addressId': addressId,
      'address': address,
      'items': items.map((e) => e.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      status: OrderStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => OrderStatus.pending,
      ),
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      orderDate: map['orderDate'] != null
          ? DateTime.parse(map['orderDate'])
          : DateTime.now(),
      deliveryDate: map['deliveryDate'] != null
          ? DateTime.parse(map['deliveryDate'])
          : null,
      paymentMethod: map['paymentMethod'] ?? 'Paypal',
      addressId: map['addressId'],
      address: map['address'],
      items: map['items'] != null
          ? (map['items'] as List)
                .map((e) => CartItemModel.fromMap(e as Map<String, dynamic>))
                .toList()
          : [],
    );
  }

  String get formattedOrderDate => _formatDate(orderDate);

  String get formattedDeliveryDate =>
      deliveryDate != null ? _formatDate(deliveryDate!) : '';

  String get orderStatusText {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipment on the way';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  static String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
  }
}
