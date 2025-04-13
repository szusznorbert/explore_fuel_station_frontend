import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_bloc.dart';
import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_event.dart';
import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_state.dart';
import 'package:explore_fuel_stations/domain/entities/fuel_station_entity.dart';
import 'package:explore_fuel_stations/domain/entities/pump_entity.dart';
import 'package:explore_fuel_stations/presentation/common/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FuelStationForm extends StatefulWidget {
  const FuelStationForm({super.key, required this.position});

  final LatLng position;

  @override
  State<FuelStationForm> createState() => _FuelStationFormState();
}

class _FuelStationFormState extends State<FuelStationForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();

  final List<PumpInput> _pumps = [PumpInput()];

  void _addPump() {
    setState(() {
      _pumps.add(PumpInput());
    });
  }

  void _removePump(int index) {
    setState(() {
      _pumps.removeAt(index);
    });
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final address = _addressController.text.trim();
      final city = _cityController.text.trim();
      final List<PumpEntity> pumpList =
          _pumps.map((p) {
            return PumpEntity(
              id: DateTime.now().microsecondsSinceEpoch,
              fuelType: p.fuelTypeController.text.trim(),
              price: double.tryParse(p.priceController.text.trim()) ?? 0.0,
              available: p.available,
            );
          }).toList();
      context.read<FuelStationBloc>().add(
        AddFuelStation(
          FuelStationEntity(
            name: name,
            address: address,
            city: city,
            pumps: pumpList,
            latitude: widget.position.latitude,
            longitude: widget.position.longitude,
          ),
        ),
      );
    }
  }

  void _close() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FuelStationBloc, FuelStationState>(
      listener: (context, state) {
        if (state.status == FuelStationEventStatus.created) {
          ToastMessage.displayToastMessage('Fuel station created successfully');
          Navigator.pop(context);
        } else if (state.status == FuelStationEventStatus.error) {
          ToastMessage.displayToastMessage('Error adding fuel station');
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: ListView(
            children: [
              const Text('Add Fuel Station', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Station Name'),
                textInputAction: TextInputAction.next,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                textInputAction: TextInputAction.next,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
                textInputAction: TextInputAction.next,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
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
                          controller: pump.fuelTypeController,
                          decoration: const InputDecoration(labelText: 'Fuel Type'),
                          validator: (value) => value!.isEmpty ? 'Required' : null,
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
                            Switch(value: pump.available, onChanged: (val) => setState(() => pump.available = val)),
                            const Spacer(),
                            if (_pumps.length > 1)
                              IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _removePump(index)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              TextButton.icon(onPressed: _addPump, icon: const Icon(Icons.add), label: const Text('Add Pump')),
              ElevatedButton(onPressed: _submit, child: const Text('Save Station')),
              ElevatedButton(onPressed: _close, child: const Text('Close')),
            ],
          ),
        ),
      ),
    );
  }
}

class PumpInput {
  final TextEditingController fuelTypeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool available = true;
}
