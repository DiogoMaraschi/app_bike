import 'package:desafio_academy/global.dart';
import 'package:desafio_academy/model/trip.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class Share {
  Future<void> compartilharFotos(Trip trip) async {
    final fotos = await fotoRepository.buscarPorTrip(trip.id!);

    if (fotos.isEmpty) {
      return;
    }

    final arquivos = fotos.map((foto) => XFile(foto.image_path)).toList();

    await SharePlus.instance.share(
      ShareParams(
        title: 'Fotos da viagem',
        text: 'Fotos de ${trip?.local ?? 'minha viagem'}',
        files: arquivos,
      ),
    );
  }
}
