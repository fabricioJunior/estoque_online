import '../models.dart';

abstract interface class IProdutosRepository {
  Future<List<Produto>> recuperarProdutosDoServidor({
    String? cor,
    String? tamanho,
    String? busca,
  });
}
