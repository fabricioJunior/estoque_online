part of 'produtos_pedido_bloc.dart';

abstract class ProdutosPedidoState {}

class ProdutosPedidoNaoInicializado extends ProdutosPedidoState {}

class ProdutosPedidoSincronizarEmProgresso extends ProdutosPedidoState {}

class ProdutosPedidoSincronizarSucesso extends ProdutosPedidoState {}

class ProdutosPedidosSincronizarFalha extends ProdutosPedidoState {}

class ProdutosPedidosEnviarNFEmProgresso extends ProdutosPedidoState {}

class ProdutosPedidosEnviarNFSucesso extends ProdutosPedidoState {
  final String nf;

  ProdutosPedidosEnviarNFSucesso({required this.nf});
}

class ProdutosPedidosEnviarNFFalha extends ProdutosPedidoState {}
