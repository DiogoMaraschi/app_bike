import 'package:desafio_academy/database/database_helper.dart';
import 'package:desafio_academy/model/trip.dart';
import 'package:desafio_academy/pages/trip_list/dialog_new_trip.dart';
import 'package:desafio_academy/pages/trip_detail/trip_details_page.dart';
import 'package:desafio_academy/pages/trip_list/trip_list_state.dart';
import 'package:desafio_academy/repository/trip_repository.dart';
import 'package:desafio_academy/service/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripListPage extends StatelessWidget {
  const TripListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TripListState()..carregarLista(),
      child: _TripListDetailsPage(),
    );
  }
}

class _TripListDetailsPage extends StatelessWidget {
  const _TripListDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TripListState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Passeios')),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.getList.length,
                  itemBuilder: (context, index) {
                    final trip = state.getList[index];

                    return ListTile(
                      title: Text(trip.local),
                      subtitle: Text(
                        '${trip.dataInicio.day}/'
                        '${trip.dataInicio.month}/'
                        '${trip.dataInicio.year}',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TripDetailsPage(id: trip.id!),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final nome = await showDialog<String>(
                context: context,
                builder: (context) {
                  return const DialogNovaTrip();
                },
              );
              print('NOME RECEBIDO: $nome');

              if (nome == null) {
                return;
              }
              final id = await state.inserir(nome);

              if (!context.mounted) {
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TripDetailsPage(id: id),
                ),
              );
              if (!context.mounted) return;

              await state.carregarLista();
            },
            child: Icon(Icons.directions_bike),
          ),
        );
      },
    );
  }
}
