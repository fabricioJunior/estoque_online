part of 'produtos_bloc.dart';

abstract class ProdutosState {
  final List<Produto> produtos;
  final String source;

  ProdutosState({
    required this.produtos,
    required this.source,
  });

  ProdutosState.fromLastState(
    ProdutosState lastState, {
    List<Produto>? produtos,
    String? source,
  })  : produtos = produtos ?? lastState.produtos,
        source = source ?? lastState.source;
}

class ProdutosInicial extends ProdutosState {
  ProdutosInicial({required super.produtos}) : super(source: '');
}

class ProdutosPesquisarEmProgresso extends ProdutosState {
  ProdutosPesquisarEmProgresso(super.lastState, {required String source})
      : super.fromLastState(
          source: source,
        );
}

class ProdutosCarregarEmProgresso extends ProdutosState {
  ProdutosCarregarEmProgresso.fromLastState(super.lastState)
      : super.fromLastState();
}

class ProdutosCarregarSucesso extends ProdutosState {
  ProdutosCarregarSucesso.fromLastState(
    super.lastState, {
    required super.produtos,
  }) : super.fromLastState();
}

class ProdutosCarregarFalha extends ProdutosState {
  ProdutosCarregarFalha.fromLastState(super.lastState) : super.fromLastState();
}

class ProdutosPesquisarSucesso extends ProdutosState {
  ProdutosPesquisarSucesso(super.lastState, {required List<Produto> produtos})
      : super.fromLastState(
          produtos: produtos,
        );
}

class ProdutosPesquisarFalha extends ProdutosState {
  final String error;

  ProdutosPesquisarFalha(
    ProdutosState lastState, {
    required super.produtos,
    required this.error,
  }) : super.fromLastState(lastState);
}

class ProdutosSincronizarEmProgress extends ProdutosState {
  ProdutosSincronizarEmProgress.fromLastState(super.lastState)
      : super.fromLastState();
}

class ProdutosSincronizarSucesso extends ProdutosState {
  final DateTime horaFinalizacao;

  ProdutosSincronizarSucesso.fromLastState(
    super.lastState,
    this.horaFinalizacao,
  ) : super.fromLastState();
}

class ProdutosSincronizarFalha extends ProdutosState {
  ProdutosSincronizarFalha.fromLastState(super.lastState)
      : super.fromLastState();
}
