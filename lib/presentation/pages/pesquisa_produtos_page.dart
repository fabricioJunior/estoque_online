import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siv_codebar/presentation/blocs/produtos_bloc/produtos_bloc.dart';
import 'package:siv_codebar/injections.dart';

import '../../domain/models.dart';

class PesquisarProdutosPage extends StatelessWidget {
  final Debouncer debouncer = Debouncer(milliseconds: 300);

  final ProdutosBloc bloc = sl<ProdutosBloc>()..add(ProdutosIniciou());
  PesquisarProdutosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Pesquisa de Produto',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              BlocBuilder<ProdutosBloc, ProdutosState>(
                bloc: bloc,
                builder: (context, state) => TextField(
                  onChanged: (value) {
                    debouncer.run(() {
                      bloc.add(ProdutosPesquisou(value));
                    });
                  },
                  decoration: InputDecoration(
                    hintText:
                        'Digite a referencia que deseja imprimir as etiquetas',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        var tipo = await SelecionarFiltroModal
                            .showSelecionarFiltroModal(
                          context,
                          temFiltroDeCor: state.cor != null,
                          temFiltroDeTamanho: state.tamanho != null,
                        );
                        if (tipo == TipoFiltro.cor) {
                          var cor = await CoresModal.showCoresModal(
                            // ignore: use_build_context_synchronously
                            context,
                            cores: state.cores,
                          );
                          bloc.add(
                            ProdutosPesquisou(state.source, cor: () => cor),
                          );
                        }
                        if (tipo == TipoFiltro.tamanho) {
                          var tamanho = await TamanhosModal.showTamanhosModals(
                            // ignore: use_build_context_synchronously
                            context,
                            tamanhos: state.tamanhos,
                          );
                          bloc.add(
                            ProdutosPesquisou(
                              state.source,
                              tamanho: () => tamanho,
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.filter_list_alt,
                        color: state.cor != null || state.tamanho != null
                            ? Colors.red.shade300
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<ProdutosBloc, ProdutosState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is ProdutosPesquisarEmProgresso) {
                    return const CircularProgressIndicator();
                  }
                  if (state.produtos.isEmpty && state.source.isNotEmpty) {
                    return const Text('Nada encontrado');
                  }
                  return Expanded(
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: _produtosList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _produtosList() => BlocBuilder<ProdutosBloc, ProdutosState>(
      bloc: bloc,
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.produtos.length,
          shrinkWrap: true,
          controller: ScrollController(),
          itemBuilder: (context, index) {
            var produto = state.produtos[index];
            return _produtoCard(context, produto);
          },
        );
      });

  Widget _produtoCard(BuildContext context, Produto produto) => Card(
        child: Ink(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                '/produto_page',
                arguments: produto,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(child: Text(produto.descricao)),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(produto.cor),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(produto.tamanho),
                            const SizedBox(
                              width: 8.0,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Quantidade em Estoque: ${produto.estoque}',
                            ),
                            Text(produto.valor.toString())
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

enum TipoFiltro {
  tamanho,
  cor,
}

class SelecionarFiltroModal extends StatelessWidget {
  final bool temFiltroDeTamanho;
  final bool temFiltroDeCor;

  const SelecionarFiltroModal({
    super.key,
    required this.temFiltroDeTamanho,
    required this.temFiltroDeCor,
  });

  static Future<TipoFiltro?> showSelecionarFiltroModal(
    BuildContext context, {
    required bool temFiltroDeCor,
    required bool temFiltroDeTamanho,
  }) async {
    return await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (context) {
        return SelecionarFiltroModal(
          temFiltroDeTamanho: temFiltroDeTamanho,
          temFiltroDeCor: temFiltroDeCor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColoredBox(
            color:
                temFiltroDeTamanho ? Colors.green.shade400 : Colors.transparent,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop(TipoFiltro.tamanho);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('TAMANHO'),
                ],
              ),
            ),
          ),
          const Divider(),
          ColoredBox(
            color: temFiltroDeCor ? Colors.green.shade400 : Colors.transparent,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop(TipoFiltro.cor);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('COR'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CoresModal extends StatelessWidget {
  final List<String> cores;

  const CoresModal({super.key, required this.cores});

  static Future<String?> showCoresModal(
    BuildContext context, {
    required List<String> cores,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      enableDrag: false,
      builder: (context) {
        return CoresModal(cores: cores);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione a cor'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var cor = cores[index];
                return _corButton(context, cor);
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: cores.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _corButton(BuildContext context, String cor) => TextButton(
        onPressed: () {
          Navigator.of(context).pop(cor);
        },
        child: Text(cor),
      );
}

class TamanhosModal extends StatelessWidget {
  final List<String> tamanhos;

  const TamanhosModal({super.key, required this.tamanhos});

  static Future<String?> showTamanhosModals(
    BuildContext context, {
    required List<String> tamanhos,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      enableDrag: false,
      builder: (context) {
        return TamanhosModal(tamanhos: tamanhos);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione o tamanho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var cor = tamanhos[index];
                return _tamanhosButton(context, cor);
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: tamanhos.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tamanhosButton(BuildContext context, String tamanho) => TextButton(
        onPressed: () {
          Navigator.of(context).pop(tamanho);
        },
        child: Text(tamanho),
      );
}
