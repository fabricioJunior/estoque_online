part of 'pagamentos_bloc.dart';

abstract class PagamentosState {
  List<Pedido> get pedidos;
}

class PagamentosNaoInicializados extends PagamentosState {
  @override
  List<Pedido> get pedidos => [];
}

class PagamentosCarregarEmProgresso extends PagamentosState {
  @override
  List<Pedido> get pedidos => [];
}

class PagamentosCarregarSucesso extends PagamentosState {
  @override
  final List<Pedido> pedidos;

  PagamentosCarregarSucesso({required this.pedidos});
}

class PagamentosCarregarFalha extends PagamentosState {
  @override
  List<Pedido> get pedidos => [];
}

class PagamentosNovoPedidoEmProgresso extends PagamentosState {
  @override
  List<Pedido> get pedidos => [];
}

class PagamentosNovoPedidoSucesso extends PagamentosState {
  @override
  final List<Pedido> pedidos;

  PagamentosNovoPedidoSucesso({required this.pedidos});
}

class PagamentosNovoFalha extends PagamentosState {
  @override
  List<Pedido> get pedidos => [];
}
