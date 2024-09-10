import '../models.dart';

abstract interface class ProdutosRepository {
  Future<List<Produto>> recuperarProdutosDoServidor({
    String? cor,
    String? tamanho,
    String? busca,
  });
}
