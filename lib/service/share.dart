import 'package:desafio_academy/model/foto.dart';
import 'package:share_plus/share_plus.dart';

class Share {
  Future<void> compartilharFotos(List<Foto> fotos) async {
    if (fotos.isEmpty) {
      return;
    }

    final arquivos = fotos.map((foto) => XFile(foto.image_path)).toList();

    await SharePlus.instance.share(ShareParams(files: arquivos));
  }
}
