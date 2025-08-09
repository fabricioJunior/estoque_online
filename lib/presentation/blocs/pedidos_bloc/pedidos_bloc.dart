import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siv_codebar/repositories/produtos_pedidos_repository.dart';

import '../../../domain/models/nf_result.dart';

part 'pedidos_state.dart';
part 'pedidos_event.dart';

class PedidosBloc extends Bloc<PedidosEvent, PedidosState> {
  final PedidosRepository repository;

  PedidosBloc(this.repository) : super(PedidosNaoInicializado()) {
    on<PedidosEnviouNFDoDia>(_onProdutosPedidoEnviouNFDoDia);
    on<PedidosEnviouNF>(_onPedidosEnviouNF);
  }

  Future<void> _onPedidosEnviouNF(
    PedidosEnviouNF event,
    Emitter<PedidosState> emit,
  ) async {
    try {
      emit(PedidosSincronizarEmProgresso());
      await repository.syncPedidos();
      emit(PedidosSincronizarSucesso());
    } catch (e, s) {
      addError(e, s);
      emit(PedidosSincronizarFalha());
      return;
    }
    try {
      emit(PedidosEnviarNFEmProgresso());
      var nfProcessadas = await repository.emitirNotaFiscal(event.idPedido);
      emit(PedidosEnviarNFSucesso(nf: nfProcessadas));
    } catch (e, s) {
      emit(PedidosEnviarNFFalha());
      addError(e, s);
    }
  }

  Future<void> _onProdutosPedidoEnviouNFDoDia(
    PedidosEnviouNFDoDia event,
    Emitter<PedidosState> emit,
  ) async {
    try {
      emit(PedidosSincronizarEmProgresso());
      await repository.syncPedidos();
      emit(PedidosSincronizarSucesso());
    } catch (e, s) {
      addError(e, s);
      emit(PedidosSincronizarFalha());
      return;
    }
    try {
      emit(PedidosEnviarNFEmProgresso());
      var nfProcessadas = await repository.emitirNotaFiscalDoDia();
      emit(PedidosEnviarNFSucesso(nf: nfProcessadas));
    } catch (e, s) {
      emit(PedidosEnviarNFFalha());
      addError(e, s);
    }
  }
}
