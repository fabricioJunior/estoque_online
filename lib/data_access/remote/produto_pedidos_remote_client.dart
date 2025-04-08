import 'dart:convert';

import 'package:http/http.dart';
import 'package:siv_codebar/domain/models/nf_result.dart';

class PedidosRemoteClient {
  final String remoteServer;
  final Client client;

  PedidosRemoteClient({required this.remoteServer, required this.client});

  Future<void> postProdutoPedido(List<Map<String, dynamic>> pedidos) async {
    var uri = Uri.http(
      remoteServer,
      'pedidos',
    );
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
    var uri = Uri.http(
      remoteServer,
      'fiscal/notaFiscalDoDia',
    );
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
    var uri =
        Uri.http(remoteServer, 'fiscal', {'idPedido': idPedido.toString()});
    var response = await client.post(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
    return NfResult.fromJson(jsonDecode(response.body));
  }
}
