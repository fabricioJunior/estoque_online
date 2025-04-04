import 'dart:convert';

import 'package:http/http.dart';
import 'package:siv_codebar/domain/models/produto_pedido.dart';

class ProdutoPedidosRemoteClient {
  final String remoteServer;
  final Client client;

  ProdutoPedidosRemoteClient(
      {required this.remoteServer, required this.client});

  Future<void> postProdutoPedido(List<ProdutoPedido> produtoPedidos) async {
    var uri = Uri.http(
      remoteServer,
      'produtoPedidos',
    );
    var response = await client.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(produtoPedidos),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
  }

  Future<String> emitirNotaFiscalDoDia() async {
    var uri = Uri.http(
      remoteServer,
      'notaFiscal',
    );
    var response = await client.post(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
    return response.body;
  }
}
