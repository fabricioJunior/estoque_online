part of 'produto_bloc.dart';

abstract class ProdutoState {}

class ProdutoCarregarEmProgresso extends ProdutoState {}

class ProdutoCarregarSucesso extends ProdutoState {
  final Map<String, String> corTamanhoParaQuantidade;
  final List<String> cores;
  final List<String> tamanhos;

  ProdutoCarregarSucesso({
    required this.corTamanhoParaQuantidade,
    required this.cores,
    required this.tamanhos,
  });
}

class ProdutoCarregarFalha extends ProdutoState {}
