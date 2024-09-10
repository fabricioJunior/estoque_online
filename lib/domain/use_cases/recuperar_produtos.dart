import 'package:siv_codebar/domain/repositories/produtos_repository.dart';

import '../models/produto.dart';

class RecuperarProdutos {
  final ProdutosRepository _produtosRepository;

  RecuperarProdutos(this._produtosRepository);
  Future<List<Produto>> run() {
    return _produtosRepository.recuperarProdutosDoServidor();
  }
}
