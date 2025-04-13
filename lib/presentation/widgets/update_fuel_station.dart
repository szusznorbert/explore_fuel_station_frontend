import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_bloc.dart';
import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_event.dart';
import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_state.dart';
import 'package:explore_fuel_stations/domain/entities/fuel_station_entity.dart';
import 'package:explore_fuel_stations/domain/entities/pump_entity.dart';
import 'package:explore_fuel_stations/presentation/common/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateFuelStationForm extends StatefulWidget {
  final FuelStationEntity fuelStation;

  const UpdateFuelStationForm({super.key, required this.fuelStation});

  @override
  State<UpdateFuelStationForm> createState() => _UpdateFuelStationFormState();
}

class _UpdateFuelStationFormState extends State<UpdateFuelStationForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late List<PumpInput> _pumps;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.fuelStation.name);
    _pumps =
        widget.fuelStation.pumps.map((pump) {
          return PumpInput(id: pump.id, fuelType: pump.fuelType, price: pump.price, available: pump.available);
        }).toList();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedPumps =
          _pumps.map((p) {
            return PumpEntity(
              id: p.id,
              fuelType: p.fuelType,
              price: double.tryParse(p.priceController.text.trim()) ?? 0.0,
              available: p.available,
            );
          }).toList();

      final updatedStation = widget.fuelStation.copyWith(name: _nameController.text.trim(), pumps: updatedPumps);
      context.read<FuelStationBloc>().add(UpdateFuelStation(updatedStation));
    }
  }

  void _close() {
    Navigator.pop(context); // Close the modal
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FuelStationBloc, FuelStationState>(
      listener: (context, state) {
        if (state.status == FuelStationEventStatus.updated) {
          ToastMessage.displayToastMessage('Fuel station updated successfully');
          _close();
        } else if (state.status == FuelStationEventStatus.error) {
          ToastMessage.displayToastMessage(state.message);
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: ListView(
            children: [
              const Text('Update Fuel Station', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Station Name'),
                textInputAction: TextInputAction.done,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              Text('${widget.fuelStation.address}, ${widget.fuelStation.city}'),
              const SizedBox(height: 16),
              const Text('Pumps', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              ..._pumps.asMap().entries.map((entry) {
                final index = entry.key;
                final pump = entry.value;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        TextFormField(
                          enabled: false,
                          initialValue: widget.fuelStation.pumps[index].fuelType,
                          decoration: const InputDecoration(labelText: 'Fuel Type'),
                        ),
                        TextFormField(
                          controller: pump.priceController,
                          decoration: const InputDecoration(labelText: 'Price'),
                          validator: (value) => double.tryParse(value!) == null ? 'Invalid price' : null,
                        ),
                        Row(
                          children: [
                            const Text('Available'),
                            const SizedBox(width: 8),
                            Icon(pump.available ? Icons.check_circle : Icons.cancel, color: pump.available ? Colors.green : Colors.red),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              ElevatedButton(onPressed: _submit, child: const Text('Save Changes')),
              ElevatedButton(onPressed: _close, child: const Text('Close')),
            ],
          ),
        ),
      ),
    );
  }
}

class PumpInput {
  final int id;
  final TextEditingController priceController;
  final bool available;
  final String fuelType;
  final double price;

  PumpInput({required this.id, required this.fuelType, this.price = 0.0, this.available = true})
    : priceController = TextEditingController(text: price.toString());
}
