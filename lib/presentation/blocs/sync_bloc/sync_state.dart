abstract class SyncState {
  final DateTime ultimaSincronizacao;

  SyncState({required this.ultimaSincronizacao});

  SyncState.lastState(
    SyncState state, {
    DateTime? ultimaSincronizacao,
  }) : ultimaSincronizacao = ultimaSincronizacao ?? state.ultimaSincronizacao;
}

class SyncNaoInicializado extends SyncState {
  SyncNaoInicializado({required super.ultimaSincronizacao});
}

class SyncEmProgresso extends SyncState {
  SyncEmProgresso(super.state) : super.lastState();
}

class SyncSucesso extends SyncState {
  SyncSucesso({required super.ultimaSincronizacao});
}

class SyncFalha extends SyncState {
  final String erroMessage;

  SyncFalha({
    required super.ultimaSincronizacao,
    required this.erroMessage,
  });
}
