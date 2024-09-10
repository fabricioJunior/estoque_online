import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siv_codebar/presentation/blocs/produtos_bloc/produtos_bloc.dart';
import 'package:siv_codebar/injections.dart';

import '../../domain/models.dart';

class PesquisarProdutosPage extends StatelessWidget {
  final Debouncer debouncer = Debouncer(milliseconds: 300);

  final ProdutosBloc bloc = sl<ProdutosBloc>();
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
              TextField(
                onChanged: (value) {
                  debouncer.run(() {
                    bloc.add(ProdutosPesquisou(value));
                  });
                },
                decoration: const InputDecoration(
                  hintText:
                      'Digite a referencia que deseja imprimir as etiquetas',
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
            return _produtoCard(produto);
          },
        );
      });

  Widget _produtoCard(Produto produto) => Card(
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
