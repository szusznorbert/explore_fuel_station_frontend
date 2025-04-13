import 'package:explore_fuel_stations/data/dtos/pump_dto.dart';

class FuelStationDto {
  final String? id;
  final String name;
  final String address;
  final String city;
  final double latitude;
  final double longitude;
  final List<PumpDto> pumps;

  const FuelStationDto({
    this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.pumps,
  });

  factory FuelStationDto.fromJson(Map<String, dynamic> json) {
    return FuelStationDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      latitude: (json['latitude']).toDouble(),
      longitude: (json['longitude']).toDouble(),
      city: json['city'] ?? '',
      pumps: (json['pumps'] as List<dynamic>).map((pump) => PumpDto.fromJson(pump)).toList(),
    );
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'pumps': pumps.map((pump) => pump.toJson()).toList(),
    };
  }
}
