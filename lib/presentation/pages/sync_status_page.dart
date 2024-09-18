import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siv_codebar/presentation/blocs/sync_bloc/sync_bloc.dart';
import 'package:siv_codebar/presentation/blocs/sync_bloc/sync_state.dart';

class SyncStatusPage extends StatelessWidget {
  const SyncStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Sincronização'),
        BlocBuilder<SyncBloc, SyncState>(builder: (context, state) {
          if (state is SyncEmProgresso) {
            return _syncInProgress();
          }
          if (state is SyncSucesso) {
            return _syncSucess(ultimaSincronizacao: state.ultimaSincronizacao);
          }
          if (state is SyncFalha) {
            return _syncFalha(
              ultimaSincronizacao: state.ultimaSincronizacao,
              erro: state.erroMessage,
            );
          }
          return const SizedBox();
        }),
      ],
    );
  }

  Widget _syncSucess({
    required DateTime ultimaSincronizacao,
  }) =>
      Column(
        children: [
          const Icon(Icons.check),
          const SizedBox(
            height: 16,
          ),
          const Text('Sincronização realizada com sucesso'),
          const SizedBox(
            height: 16,
          ),
          Text(
              'ultima sincronização concluída ás: ${ultimaSincronizacao.toIso8601String()}')
        ],
      );

  Widget _syncInProgress() => const Column(
        children: [
          CircularProgressIndicator(),
        ],
      );

  Widget _syncFalha({
    required DateTime ultimaSincronizacao,
    required String erro,
  }) =>
      Column(
        children: [
          const Icon(Icons.close),
          const SizedBox(
            height: 16,
          ),
          const Text('Falha na sincronização'),
          const SizedBox(
            height: 16,
          ),
          Text(
              'ultima tentativa de sincronização concluída ás: ${ultimaSincronizacao.toIso8601String()}'),
          const SizedBox(
            height: 16,
          ),
          Text(erro),
        ],
      );
}
