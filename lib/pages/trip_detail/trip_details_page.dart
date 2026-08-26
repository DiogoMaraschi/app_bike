import 'package:desafio_academy/service/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'trip_details_state.dart';

class TripDetailsPage extends StatelessWidget {
  final int? id;

  const TripDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TripDetailsState(id: id!)..carregarTrip(),
      child: _TripDetailsPage(),
    );
  }
}

class _TripDetailsPage extends StatelessWidget {
  const _TripDetailsPage();

  @override
  Widget build(BuildContext context) {
    return Consumer<TripDetailsState>(
      builder: (context, state, child) {
        final trip = state.trip;

        return Scaffold(
          appBar: AppBar(title: Text(trip?.local ?? 'Local da Viagem')),
          body: trip == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Text(trip.local),
                    Text(
                      '${trip.dataInicio.day}/'
                      '${trip.dataInicio.month}/'
                      '${trip.dataInicio.year}',
                    ),
                  ],
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await state.salvarNota();
            },
          ),
        );
      },
    );
  }
}
