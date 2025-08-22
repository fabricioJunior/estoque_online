import 'dart:convert';

import 'package:http/http.dart';
import 'package:siv_codebar/domain/models/cliente.dart';

class ClientesClient {
  final String server;
  final Client client;

  ClientesClient({required this.server, required this.client});

  Future<List<Cliente>> clientes(String busca) async {
    final queryParameters = {
      'busca': busca,
    };
    var uri = Uri.parse(
      server,
    );
    uri = uri.replace(path: 'api/pessoas', queryParameters: queryParameters);

    var response = await client.get(
      uri,
    );
    return criarObjetos(response);
  }

  List<Cliente> criarObjetos(Response response) {
    var decodeJson = jsonDecode(response.body);
    if (decodeJson is List<dynamic>) {
      return decodeJson
          .map<Cliente>(
              (objeto) => Cliente.fromJson(objeto as Map<String, dynamic>))
          .toList();
    }

    return <Cliente>[];
  }
}
