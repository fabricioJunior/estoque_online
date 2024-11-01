part of 'produtos_bloc.dart';

abstract class ProdutosState {
  final List<Produto> produtos;
  final List<String> tamanhos;
  final List<String> cores;
  final String source;
  final String? cor;
  final String? tamanho;

  ProdutosState({
    required this.produtos,
    required this.source,
    required this.cores,
    required this.tamanhos,
    this.cor,
    this.tamanho,
  });

  ProdutosState.fromLastState(
    ProdutosState lastState, {
    List<Produto>? produtos,
    List<String>? tamanhos,
    List<String>? cores,
    String? source,
    String? Function()? cor,
    String? Function()? tamanho,
  })  : produtos = produtos ?? lastState.produtos,
        source = source ?? lastState.source,
        cor = cor != null ? cor() : lastState.cor,
        tamanho = tamanho != null ? tamanho() : lastState.tamanho,
        cores = cores ?? lastState.cores,
        tamanhos = tamanhos ?? lastState.tamanhos;
}

class ProdutosInicial extends ProdutosState {
  ProdutosInicial({required super.produtos})
      : super(
          source: '',
          tamanhos: const [],
          cores: const [],
        );
}

class ProdutosPesquisarEmProgresso extends ProdutosState {
  ProdutosPesquisarEmProgresso(
    super.lastState, {
    required String source,
    super.cor,
    super.tamanho,
  }) : super.fromLastState(
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
    required super.tamanhos,
    required super.cores,
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
