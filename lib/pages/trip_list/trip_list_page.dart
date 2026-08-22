import 'package:desafio_academy/database/database_helper.dart';
import 'package:desafio_academy/pages/trip_list/trip_list_state.dart';
import 'package:desafio_academy/repository/trip_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripListPage extends StatelessWidget {
  const TripListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TripListState(),
      child: _TripListDetailsPage(),
    );
  }
}

class _TripListDetailsPage extends StatelessWidget {
  const _TripListDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TripListState>(builder: (context, state, child) {
      state.carregarLista();
      return Column(children: [
        Expanded(child: ListView.builder(itemCount: state.getList.length, itemBuilder: (context, index) {
          final trip = state.getList[index];

          return ListTile(
            title: Text(trip.dataFim.toString()),
          );
        },))
      ],);
    });

  }
}
