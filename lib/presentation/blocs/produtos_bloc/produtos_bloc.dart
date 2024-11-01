import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siv_codebar/domain/models.dart';
import 'package:siv_codebar/repositories/produtos_repository.dart';

part 'produtos_event.dart';
part 'produtos_state.dart';

class ProdutosBloc extends Bloc<ProdutosEvent, ProdutosState> {
  final ProdutosRepository produtosRepository;

  Timer? time;
  ProdutosBloc(
    this.produtosRepository,
  ) : super(ProdutosInicial(produtos: const [])) {
    on<ProdutosIniciou>(_onProdutosIniciou);
    on<ProdutosPesquisou>(_onProdutosPesquisou);
    on<ProdutosSincronizou>(_onProdutosSincronizou);
  }

  FutureOr<void> _onProdutosPesquisou(
    ProdutosPesquisou event,
    Emitter<ProdutosState> emit,
  ) async {
    try {
      emit(
        ProdutosPesquisarEmProgresso(
          state,
          source: event.pesquisa,
          cor: event.cor,
          tamanho: event.tamanho,
        ),
      );
      var produtos = await produtosRepository.buscaProdutos(
        event.pesquisa,
        cor: state.cor,
        tamanho: state.tamanho,
      );

      emit(ProdutosPesquisarSucesso(state, produtos: produtos.toList()));
    } catch (e, s) {
      addError(e, s);
      emit(ProdutosPesquisarFalha(state, produtos: [], error: e.toString()));
    }
  }

  FutureOr<void> _onProdutosSincronizou(
    ProdutosSincronizou event,
    Emitter<ProdutosState> emit,
  ) async {
    try {
      emit(ProdutosSincronizarEmProgress.fromLastState(state));
      await produtosRepository.syncLocalData();
      emit(ProdutosSincronizarSucesso.fromLastState(state, DateTime.now()));
    } catch (e, s) {
      addError(e, s);
    }
  }

  FutureOr<void> _onProdutosIniciou(
    ProdutosIniciou event,
    Emitter<ProdutosState> emit,
  ) async {
    try {
      emit(ProdutosCarregarEmProgresso.fromLastState(state));
      // time = Timer.periodic(const Duration(minutes: 1), (_) {
      //   syncServerData();
      // });
      var produtos = await produtosRepository.buscaTodosProdutos();

      var tamanhos =
          produtos.map((produto) => produto.tamanho).toSet().toList();

      var cores = produtos.map((produto) => produto.cor).toSet().toList();

      var produtosList = produtos.toList();

      produtosList.sort((a, b) => b.estoque.compareTo(a.estoque));
      tamanhos.sort((a, b) => a.compareTo(b));
      cores.sort((a, b) => a.compareTo(b));

      emit(
        ProdutosCarregarSucesso.fromLastState(
          state,
          produtos: produtosList,
          cores: cores,
          tamanhos: tamanhos,
        ),
      );
      add(ProdutosSincronizou());
    } catch (e, s) {
      addError(e, s);
    }
  }

  Future<void> syncServerData() async {
    await produtosRepository.syncServeData();
    await Future.delayed(const Duration(minutes: 1));
  }

  @override
  Future<void> close() {
    time?.cancel();
    return super.close();
  }
}
