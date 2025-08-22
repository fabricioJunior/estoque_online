part of 'pagamentos_bloc.dart';

abstract class PagamentoEvent {}

class PagamentosIniciou extends PagamentoEvent {}

class PagamentoCriouNovoPedido extends PagamentoEvent {
  final int idPedido;
  final double desconto;

  PagamentoCriouNovoPedido({required this.idPedido, required this.desconto});
}

class PagamentoExcluiu extends PagamentoEvent {
  final int idPedido;

  PagamentoExcluiu({required this.idPedido});
}
