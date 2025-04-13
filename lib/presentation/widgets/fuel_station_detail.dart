import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_bloc.dart';
import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_event.dart';
import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_state.dart';
import 'package:explore_fuel_stations/domain/entities/fuel_station_entity.dart';
import 'package:explore_fuel_stations/presentation/common/toast_message.dart';
import 'package:explore_fuel_stations/presentation/widgets/pump_detail.dart';
import 'package:explore_fuel_stations/presentation/widgets/update_fuel_station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FuelStationDetail extends StatelessWidget {
  final FuelStationEntity station;
  const FuelStationDetail({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FuelStationBloc, FuelStationState>(
      listener: (context, state) {
        if (state.status == FuelStationEventStatus.deleted) {
          _close(context);
          ToastMessage.displayToastMessage('Fuel station deleted successfully');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(station.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('${station.address}, ${station.city}'),
            const Text('Pumps:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: station.pumps.length,
                itemBuilder: (context, index) {
                  final pump = station.pumps[index];
                  return PumpDetail(pump: pump);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
                ElevatedButton(
                  onPressed: () {
                    final bloc = BlocProvider.of<FuelStationBloc>(context, listen: false);
                    _close(context);
                    _editFuelStation(context: context, fuelStation: station, bloc: bloc);
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<FuelStationBloc>().add(DeleteFuelStation(station.id!));
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _close(BuildContext context) {
    Navigator.pop(context);
  }

  void _editFuelStation({required FuelStationEntity fuelStation, required BuildContext context, required FuelStationBloc bloc}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(value: bloc, child: UpdateFuelStationForm(fuelStation: fuelStation)),
    );
  }
}
