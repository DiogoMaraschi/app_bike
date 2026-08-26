import 'package:flutter/material.dart';

class DialogNovaTrip extends StatefulWidget {
  const DialogNovaTrip({super.key});

  @override
  State<DialogNovaTrip> createState() => _DialogNovaTripState();
}

class _DialogNovaTripState extends State<DialogNovaTrip> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova corrida'),

      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: 'Nome da corrida',
          border: OutlineInputBorder(),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),

        ElevatedButton(
          onPressed: () {
            final nome = _controller.text.trim();

            if (nome.isEmpty) {
              return;
            }

            Navigator.pop(context, nome);
          },
          child: const Text('Criar'),
        ),
      ],
    );
  }
}
