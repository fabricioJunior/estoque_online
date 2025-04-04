part of 'produtos_pedido_bloc.dart';

abstract class ProdutosPedidoEvent {}

class ProdutosPedidoEnviouNFDoDia extends ProdutosPedidoEvent {}

class ProdutosPedidoEnviouNF extends ProdutosPedidoEvent {
  final int idPedido;

  ProdutosPedidoEnviouNF({required this.idPedido});
}
