import 'package:core/html_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siv_codebar/injections.dart';
import 'package:siv_codebar/presentation/blocs/produtos_pedido_bloc/pedidos_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/models/nf_result.dart';

class NfPage extends StatelessWidget {
  NfPage({super.key});

  final TextEditingController romaneioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PedidosBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nota Fiscal'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<PedidosBloc, PedidosState>(
                    builder: (context, state) {
                      if (state is PedidosNaoInicializado) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Romaneio'),
                            Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 70,
                                    width: 300,
                                    child: TextField(
                                      controller: romaneioController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]'),
                                        ),
                                      ],
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        filled: true,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        hintText: "Digite o número do romaneio",
                                        fillColor: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: ElevatedButton(
                                  onPressed: () {
                                    context.read<PedidosBloc>().add(
                                        PedidosEnviouNF(
                                            idPedido: int.parse(
                                                romaneioController.text)));
                                  },
                                  child: const Text('Emitir nota')),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<PedidosBloc>()
                                            .add(PedidosEnviouNFDoDia());
                                      },
                                      child: const Text('Enviar Notas do Dia')),
                                ],
                              ),
                            )
                          ],
                        );
                      }

                      if (state is PedidosSincronizarEmProgresso) {
                        return const Text('enviando produtos');
                      }
                      if (state is PedidosSincronizarFalha) {
                        return const Text('Falha ao sincronizar pedidos');
                      }

                      if (state is PedidosEnviarNFEmProgresso) {
                        return const Text('gerando NF produtos');
                      }
                      if (state is PedidosEnviarNFEmProgresso) {
                        return const Text('enviando notas fiscais');
                      }
                      if (state is PedidosEnviarNFFalha) {
                        return const Text('Falha ao enviar notas');
                      }

                      if (state is PedidosEnviarNFSucesso) {
                        return Expanded(child: _nfView(context, state.nf));
                      }

                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nfView(BuildContext context, NfResult nfs) {
    return Column(
      children: [
        Text('Total: ${nfs.total}'),
        Expanded(
            child: ListView.builder(
          itemCount: nfs.nfs.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => TextButton(
            onPressed: () {
              launchUrl(Uri.parse(nfs.nfs[index]));
            },
            child: Text(nfs.nfs[index]),
          ),
        )),
      ],
    );
  }
}
