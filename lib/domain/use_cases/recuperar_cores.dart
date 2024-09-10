import 'package:siv_codebar/domain/models/cor.dart';
import 'package:siv_codebar/domain/repositories/cores_repository.dart';

class RecuperarCores {
  final ICoresRepository _coresRepository;

  RecuperarCores(this._coresRepository);
  Future<List<Cor>> run() async {
    return _coresRepository.recuperarCores();
  }
}
