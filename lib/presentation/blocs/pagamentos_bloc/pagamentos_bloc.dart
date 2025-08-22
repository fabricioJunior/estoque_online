import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siv_codebar/domain/models/pedido.dart';
import 'package:siv_codebar/repositories/produtos_pedidos_repository.dart';

part 'pagamentos_state.dart';
part 'pagamentos_event.dart';

class PagamentosBloc extends Bloc<PagamentoEvent, PagamentosState> {
  final PedidosRepository _pedidosRepository;
  PagamentosBloc(
    this._pedidosRepository,
  ) : super(PagamentosNaoInicializados()) {
    on<PagamentosIniciou>(_onPagamentosIniciou);
    on<PagamentoCriouNovoPedido>(_onPagamentoCriouNovoPedido);
    on<PagamentoExcluiu>(_onPagamentoExcluiu);
  }

  FutureOr<void> _onPagamentosIniciou(
    PagamentosIniciou event,
    Emitter<PagamentosState> emit,
  ) async {
    try {
      emit(PagamentosCarregarEmProgresso());
      var pedidos = await _pedidosRepository.getPedidos();
      emit(PagamentosCarregarSucesso(pedidos: pedidos));
    } catch (e) {
      emit(PagamentosCarregarFalha());
    }
  }

  FutureOr<void> _onPagamentoCriouNovoPedido(
    PagamentoCriouNovoPedido event,
    Emitter<PagamentosState> emit,
  ) async {
    try {
      emit(PagamentosNovoPedidoEmProgresso());
      await _pedidosRepository.syncPedidoParaPagamento(
          event.idPedido, event.desconto);
      await _pedidosRepository.url(event.idPedido);

      var pedidos = await _pedidosRepository.getPedidos();
      emit(PagamentosCarregarSucesso(pedidos: pedidos));
    } catch (e) {
      emit(PagamentosNovoFalha(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onPagamentoExcluiu(
    PagamentoExcluiu event,
    Emitter<PagamentosState> emit,
  ) async {
    try {
      emit(PagamentosCarregarEmProgresso());
      await _pedidosRepository.excluir(event.idPedido);
      var pedidos = await _pedidosRepository.getPedidos();
      emit(PagamentosCarregarSucesso(pedidos: pedidos));
    } catch (e) {
      emit(PagamentosCarregarFalha());
    }
  }
}
