part of 'pedidos_bloc.dart';

abstract class PedidosEvent {}

class PedidosEnviouNFDoDia extends PedidosEvent {}

class PedidosEnviouNF extends PedidosEvent {
  final int idPedido;

  PedidosEnviouNF({required this.idPedido});
}
