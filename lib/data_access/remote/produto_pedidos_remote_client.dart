import 'dart:convert';

import 'package:http/http.dart';
import 'package:siv_codebar/domain/models/nf_result.dart';
import 'package:siv_codebar/domain/models/pedido.dart';

class PedidosRemoteClient {
  final String remoteServer;
  final Client client;

  PedidosRemoteClient({required this.remoteServer, required this.client});

  Future<void> postProdutoPedido(List<Map<String, dynamic>> pedidos) async {
    var uri = Uri.parse(
      remoteServer,
    );
    uri = uri.replace(path: 'pedidos');
    var response = await client.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(pedidos),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
  }

  Future<NfResult> emitirNotaFiscalDoDia() async {
    var uri = Uri.parse(
      remoteServer,
    );
    uri = uri.replace(path: 'fiscal/notaFiscalDoDia');
    var response = await client.post(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
    return NfResult.fromJson(jsonDecode(response.body));
  }

  Future<NfResult> emitirNotaFiscal(int idPedido) async {
    var uri = Uri.parse(
      remoteServer,
    );
    uri = uri.replace(
        path: 'fiscal', queryParameters: {'idPedido': idPedido.toString()});
    var response = await client.post(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
    return NfResult.fromJson(jsonDecode(response.body));
  }

  Future<String> getUrl(int idPedido) async {
    var uri = Uri.parse(
      remoteServer,
    );
    uri = uri.replace(
      path: 'pagamento/url',
      queryParameters: {'idPedido': idPedido.toString()},
    );
    var response = await client.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    return response.body;
  }

  Future<List<Pedido>> getPedidos() async {
    var uri = Uri.parse(
      remoteServer,
    );
    uri = uri.replace(path: 'pagamento/pedidosComPagamentoPendente');
    var response = await client.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    var json = jsonDecode(response.body);
    return (json as List<dynamic>)
        .map((e) => Pedido.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> excluirPagamento(int idPedido) async {
    var uri = Uri.parse(
      remoteServer,
    );
    uri = uri.replace(path: 'pagamento/cancelar', queryParameters: {
      'idPedido': idPedido.toString(),
    });

    var response = await client.post(
      uri,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
  }
}
