import 'dart:convert';

import 'package:http/http.dart';

class ProdutoPedidosLocalClient {
  final String localServer;
  final Client client;

  const ProdutoPedidosLocalClient({
    required this.localServer,
    required this.client,
  });

  Future<List<Map<String, dynamic>>> getProdutoPedidosDeHoje() async {
    var uri = Uri.http(
      localServer,
      'pedidos',
    );
    var response = await client.get(uri);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }

    return (jsonDecode(response.body) as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }
}
