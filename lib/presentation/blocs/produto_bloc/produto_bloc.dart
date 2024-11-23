import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siv_codebar/domain/models/produto.dart';
import 'package:siv_codebar/repositories/produtos_repository.dart';
import 'package:collection/collection.dart';
part 'produto_state.dart';
part 'produto_event.dart';

class ProdutoBloc extends Bloc<ProdutoEvent, ProdutoState> {
  final ProdutosRepository produtosRepository;
  ProdutoBloc(
    this.produtosRepository,
  ) : super(ProdutoCarregarEmProgresso()) {
    on<ProdutoIniciou>(_onProdutoIniciou);
  }

  FutureOr<void> _onProdutoIniciou(
    ProdutoIniciou event,
    Emitter<ProdutoState> emit,
  ) async {
    var produtos = await produtosRepository
        .buscaProdutoDaMesmaReferecia(event.produto.referencia);
    var tamanhos = produtos.map((produto) => produto.tamanho).toSet().toList()
      ..sort();

    var cores = produtos.map((produto) => produto.cor).toSet().toList()..sort();

    Map<String, String> corTamanhoParaQuantidade = {};
    for (var cor in cores) {
      for (var tamanho in tamanhos) {
        var produto = produtos.firstWhereOrNull(
          (produto) => produto.cor == cor && produto.tamanho == tamanho,
        );
        corTamanhoParaQuantidade.addAll(
          {
            '${cor}_$tamanho':
                produto?.estoque == null ? '*' : produto!.estoque.toString()
          },
        );
      }
    }

    emit(
      ProdutoCarregarSucesso(
        corTamanhoParaQuantidade: corTamanhoParaQuantidade,
        tamanhos: tamanhos.toList(),
        cores: cores.toList(),
      ),
    );
  }
}
