import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siv_codebar/presentation/blocs/sync_bloc/sync_event.dart';
import 'package:siv_codebar/presentation/blocs/sync_bloc/sync_state.dart';
import 'package:siv_codebar/repositories/produtos_repository.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final ProdutosRepository produtosRepository;

  SyncBloc(
    this.produtosRepository,
  ) : super(SyncNaoInicializado(ultimaSincronizacao: DateTime(2020))) {
    on<SyncIniciou>(_onSyncIniciou);
  }

  FutureOr<void> _onSyncIniciou(
    SyncIniciou event,
    Emitter<SyncState> emit,
  ) async {
    try {
      emit(SyncEmProgresso(state));
      await produtosRepository.syncServeData();
      emit(SyncSucesso(
        ultimaSincronizacao: DateTime.now(),
      ));
    } catch (e, s) {
      emit(
        SyncFalha(
          ultimaSincronizacao: DateTime.now(),
          erroMessage: e.toString(),
        ),
      );

      addError(e, s);
    }
  }
}
