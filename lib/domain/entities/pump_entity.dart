import 'package:equatable/equatable.dart';
import 'package:explore_fuel_stations/data/dtos/pump_dto.dart';

class PumpEntity extends Equatable {
  final int id;
  final String fuelType;
  final bool available;
  final double price;

  const PumpEntity({required this.id, required this.fuelType, required this.available, required this.price});

  factory PumpEntity.fromDto(PumpDto dto) {
    return PumpEntity(id: dto.id, fuelType: dto.fuelType, available: dto.available, price: dto.price);
  }

  toDto() {
    return PumpDto(id: id, fuelType: fuelType, available: available, price: price);
  }

  @override
  List<Object?> get props => [id, fuelType, available, price];
}
