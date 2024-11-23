part of 'produto_bloc.dart';

abstract class ProdutoEvent {}

class ProdutoIniciou extends ProdutoEvent {
  final Produto produto;
  ProdutoIniciou({required this.produto});
}
