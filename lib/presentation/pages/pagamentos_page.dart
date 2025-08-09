import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siv_codebar/domain/models/pedido.dart';
import 'package:siv_codebar/injections.dart';
import 'package:siv_codebar/presentation/blocs/pagamentos_bloc/pagamentos_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class PagamentosPage extends StatelessWidget {
  PagamentosPage({super.key});
  final ScrollController scrollController = ScrollController();
  final bloc = sl<PagamentosBloc>()..add(PagamentosIniciou());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PagamentosBloc>(
        create: (context) => bloc,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BackButton(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Orçamentos e links'),
                      Row(
                        children: [
                          BlocBuilder<PagamentosBloc, PagamentosState>(
                            builder: (context, state) {
                              return IconButton(
                                onPressed: () {
                                  bloc.add(PagamentosIniciou());
                                },
                                icon: const Icon(Icons.update),
                              );
                            },
                          ),
                          BlocBuilder<PagamentosBloc, PagamentosState>(
                            builder: (context, state) {
                              return IconButton(
                                onPressed: () {
                                  _onNewPedido(context);
                                },
                                icon: const Icon(Icons.add),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<PagamentosBloc, PagamentosState>(
                      builder: (context, state) {
                        if (state is PagamentosCarregarFalha) {
                          return const Text('Falha ao carregar orçamentos');
                        }
                        if (state is PagamentosNovoFalha) {
                          return const Text('Falha ao carregar pedido');
                        }
                        if (state is PagamentosCarregarEmProgresso ||
                            state is PagamentosNovoPedidoEmProgresso) {
                          return const CircularProgressIndicator.adaptive();
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: state.pedidos.length,
                          itemBuilder: (context, index) {
                            return _pedidoCard(state.pedidos[index]);
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onNewPedido(BuildContext context) async {
    final controller = TextEditingController();
    final controllerPedido = TextEditingController();
    final formater =
        CurrencyTextInputFormatter.currency(locale: 'BR', symbol: '\$');
    var result = await showDialog<DialogResult>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Romaneio e Desconto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controllerPedido,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Romaneio",
                ),
              ),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [formater],
                decoration: const InputDecoration(hintText: "desconto"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cencelar'),
              onPressed: () {
                Navigator.pop(context); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () {
                var result = DialogResult(
                  desconto:
                      double.parse(formater.getUnformattedValue().toString()),
                  idPedido: int.parse(controllerPedido.text),
                );
                Navigator.pop(
                  context,
                  result,
                ); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
    if (result != null) {
      bloc.add(PagamentoCriouNovoPedido(
          idPedido: result.idPedido, desconto: result.desconto));
    }
  }

  Widget _pedidoCard(Pedido pedido) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                      '${pedido.id} - ${pedido.pessoa?.nome} - ${pedido.pessoa?.cpf}'),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                launchUrl(Uri.parse(
                    'https://use-por-onde-flor.vercel.app/pagamento?idPedido=${pedido.id}'));
              },
              child: Text(
                'https://use-por-onde-flor.vercel.app/pagamento?idPedido=${pedido.id}',
              ),
            ),
            if (pedido.comprovanteDePagamento != null)
              TextButton(
                onPressed: () {
                  launchUrl(Uri.parse(pedido.comprovanteDePagamento!));
                },
                child: Text(
                  pedido.comprovanteDePagamento!,
                ),
              )
          ],
        ),
      ),
    );
  }
}

class DialogResult {
  final double desconto;
  final int idPedido;

  DialogResult({required this.desconto, required this.idPedido});
}
