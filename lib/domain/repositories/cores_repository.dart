import 'package:siv_codebar/domain/models/cor.dart';

abstract interface class ICoresRepository {
  Future<List<Cor>> recuperarCores();
}
