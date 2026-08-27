import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'trip_details_state.dart';

class TripDetailsPage extends StatelessWidget {
  final int? id;

  const TripDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TripDetailsState(id: id!)
        ..carregarTrip()
        ..carregarFotos(),
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
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(trip.local),
                          Text(
                            '${trip.dataInicio.day}/'
                            '${trip.dataInicio.month}/'
                            '${trip.dataInicio.year}',
                          ),
                          Text(
                            trip.dataFim == null
                                ? 'Viagem em andamento'
                                : 'Viagem finalizada em ${trip.dataFim}',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: state.getFotos.isEmpty
                          ? const Center(
                              child: Text('Nenhuma foto nesta viagem'),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: state.getFotos.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                  ),
                              itemBuilder: (context, index) {
                                final foto = state.getFotos[index];

                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(foto.image_path),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
          floatingActionButton: trip == null
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      heroTag: 'share',
                      onPressed: state.compartilharFotos,
                      child: const Icon(Icons.share),
                    ),

                    if (trip.dataFim == null) ...[
                      const SizedBox(height: 12),

                      FloatingActionButton(
                        heroTag: 'camera',
                        onPressed: state.salvarFoto,
                        child: const Icon(Icons.camera_alt),
                      ),

                      const SizedBox(height: 12),

                      FloatingActionButton.extended(
                        heroTag: 'finish',
                        onPressed: () async {
                          final confirmar = await showDialog<bool>(
                            context: context,
                            builder: (dialogContext) {
                              return AlertDialog(
                                title: const Text('Finalizar viagem?'),
                                content: const Text(
                                  'Depois disso, não será possível adicionar fotos.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(dialogContext, false);
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(dialogContext, true);
                                    },
                                    child: const Text('Finalizar'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirmar == true) {
                            await state.finalizarTrip();
                          }
                        },
                        icon: const Icon(Icons.flag),
                        label: const Text('Finalizar'),
                      ),
                    ],
                  ],
                ),
        );
      },
    );
  }
}
