import 'package:flutter_bloc/flutter_bloc.dart';

part 'produtos_pedido_state.dart';
part 'produtos_pedido_event.dart';

class ProdutosPedidoBloc
    extends Bloc<ProdutosPedidoEvent, ProdutosPedidoState> {
  final ProdutoPedidoRepository pedidoRepository;
  ProdutosPedidoBloc() : super(ProdutosPedidoNaoInicializado()) {
    on<ProdutosPedidoEnviouNFDoDia>(_onProdutosPedidoEnviouNFDoDia);
  }

  Future<void> _onProdutosPedidoEnviouNFDoDia(
    ProdutosPedidoEnviouNFDoDia event,
    Emitter<ProdutosPedidoState> emit,
  ) async {
    try {
      emit(ProdutosPedidoSincronizarEmProgresso());
    } catch (e, s) {}
  }
}
