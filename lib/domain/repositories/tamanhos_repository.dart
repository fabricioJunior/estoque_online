import 'package:siv_codebar/domain/models/tamanho.dart';

abstract interface class TamanhosRepository {
  Future<List<Tamanho>> recuperarTamanhos();
}
