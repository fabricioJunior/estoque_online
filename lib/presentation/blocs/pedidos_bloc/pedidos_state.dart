part of 'pedidos_bloc.dart';

abstract class PedidosState {}

class PedidosNaoInicializado extends PedidosState {}

class PedidosSincronizarEmProgresso extends PedidosState {}

class PedidosSincronizarSucesso extends PedidosState {}

class PedidosSincronizarFalha extends PedidosState {}

class PedidosEnviarNFEmProgresso extends PedidosState {}

class PedidosEnviarNFSucesso extends PedidosState {
  final NfResult nf;

  PedidosEnviarNFSucesso({required this.nf});
}

class PedidosEnviarNFFalha extends PedidosState {}
