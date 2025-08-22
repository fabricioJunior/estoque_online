import 'dart:convert';

import 'package:http/http.dart';
import 'package:siv_codebar/domain/models/pedido.dart';

class ProdutoPedidosLocalClient {
  final String localServer;
  final Client client;

  const ProdutoPedidosLocalClient({
    required this.localServer,
    required this.client,
  });

  Future<List<Map<String, dynamic>>> getPedidosDeHoje() async {
    var uri = Uri.parse(
      localServer,
    );
    uri = uri.replace(path: 'pedidos');
    var response = await client.get(uri);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }

    return (jsonDecode(response.body) as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }

  Future<Pedido> getPedido(int idPedido) async {
    var uri = Uri.parse(
      localServer,
    );
    uri = uri.replace(path: '$idPedido');
    var response = await client.get(uri);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }

    return Pedido.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
