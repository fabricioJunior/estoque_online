part of 'produtos_bloc.dart';

abstract class ProdutosEvent {}

class ProdutosIniciou extends ProdutosEvent {}

class ProdutosPesquisou extends ProdutosEvent {
  final String pesquisa;

  ProdutosPesquisou(this.pesquisa);
}

class ProdutosSincronizou extends ProdutosEvent {}
