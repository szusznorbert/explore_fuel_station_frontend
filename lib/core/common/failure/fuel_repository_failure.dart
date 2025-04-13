import 'package:explore_fuel_stations/core/common/failure/failure.dart';

class FuelRepositoryFailure extends Failure {
  const FuelRepositoryFailure.create() : super('Unable to create fuel station');
  const FuelRepositoryFailure.delete() : super('Unable to delete fuel station');
  const FuelRepositoryFailure.update() : super('Unable to update fuel station');
  const FuelRepositoryFailure.fetch() : super('Unable to fetch fuel stations');
}
