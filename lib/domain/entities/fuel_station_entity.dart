import 'package:equatable/equatable.dart';
import 'package:explore_fuel_stations/data/dtos/fuel_station_dto.dart';
import 'package:explore_fuel_stations/data/dtos/pump_dto.dart';
import 'package:explore_fuel_stations/domain/entities/pump_entity.dart';

class FuelStationEntity extends Equatable {
  final String? id;
  final String name;
  final String address;
  final String city;
  final double latitude;
  final double longitude;
  final List<PumpEntity> pumps;

  const FuelStationEntity({
    this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.pumps,
  });

  factory FuelStationEntity.fromDto(FuelStationDto dto) {
    return FuelStationEntity(
      id: dto.id,
      name: dto.name,
      address: dto.address,
      latitude: dto.latitude,
      longitude: dto.longitude,
      city: dto.city,
      pumps: dto.pumps.map((pump) => PumpEntity.fromDto(pump)).toList(),
    );
  }

  FuelStationEntity copyWith({
    String? id,
    String? name,
    String? address,
    String? city,
    double? latitude,
    double? longitude,
    List<PumpEntity>? pumps,
  }) {
    return FuelStationEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      pumps: pumps ?? this.pumps,
    );
  }

  toDto() {
    return FuelStationDto(
      id: id,
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      city: city,
      pumps: pumps.map<PumpDto>((pump) => pump.toDto()).toList(),
    );
  }

  @override
  List<Object?> get props => [id, name, address, city, latitude, longitude, pumps];
}
