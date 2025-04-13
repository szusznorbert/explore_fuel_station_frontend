class PumpDto {
  final int id;
  final String fuelType;
  final double price;
  final bool available;

  const PumpDto({required this.id, required this.fuelType, required this.price, required this.available});

  factory PumpDto.fromJson(Map<String, dynamic> json) {
    return PumpDto(
      id: json['id'] ?? 0,
      fuelType: json['fuel_type'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      available: json['available'] ?? false,
    );
  }

  toJson() {
    return {'id': id, 'fuel_type': fuelType, 'price': price, 'available': available};
  }
}
