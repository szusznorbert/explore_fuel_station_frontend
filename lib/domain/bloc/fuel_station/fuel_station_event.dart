import 'package:equatable/equatable.dart';
import 'package:explore_fuel_stations/domain/entities/fuel_station_entity.dart';

class FuelStationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchFuelStations extends FuelStationEvent {
  @override
  List<Object?> get props => [];
}

class AddFuelStation extends FuelStationEvent {
  final FuelStationEntity fuelStation;
  AddFuelStation(this.fuelStation);

  @override
  List<Object?> get props => [fuelStation];
}

class UpdateFuelStation extends FuelStationEvent {
  final FuelStationEntity fuelStation;
  UpdateFuelStation(this.fuelStation);

  @override
  List<Object?> get props => [fuelStation];
}

class DeleteFuelStation extends FuelStationEvent {
  final String fuelStationId;
  DeleteFuelStation(this.fuelStationId);

  @override
  List<Object?> get props => [fuelStationId];
}
