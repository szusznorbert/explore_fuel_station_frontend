import 'package:explore_fuel_stations/domain/entities/pump_entity.dart';
import 'package:flutter/material.dart';

class PumpDetail extends StatelessWidget {
  final PumpEntity pump;

  const PumpDetail({super.key, required this.pump});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.local_gas_station, color: Colors.green),
        const SizedBox(width: 8),
        Expanded(child: Text(pump.fuelType)),
        Text('${pump.price.toStringAsFixed(2)} €'),
        const SizedBox(width: 8),
        Icon(pump.available ? Icons.check_circle : Icons.cancel, color: pump.available ? Colors.green : Colors.red),
      ],
    );
  }
}
