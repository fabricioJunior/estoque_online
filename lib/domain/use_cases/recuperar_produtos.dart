import 'package:siv_codebar/domain/repositories/i_produtos_repository.dart';

import '../models/produto.dart';

class RecuperarProdutos {
  final IProdutosRepository _produtosRepository;

  RecuperarProdutos(this._produtosRepository);
  Future<List<Produto>> run() {
    return _produtosRepository.recuperarProdutosDoServidor();
  }
}
