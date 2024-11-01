part of 'produtos_bloc.dart';

abstract class ProdutosEvent {}

class ProdutosIniciou extends ProdutosEvent {}

class ProdutosPesquisou extends ProdutosEvent {
  final String pesquisa;
  final String? Function()? cor;
  final String? Function()? tamanho;
  ProdutosPesquisou(
    this.pesquisa, {
    this.cor,
    this.tamanho,
  });
}

class ProdutosSincronizou extends ProdutosEvent {}
