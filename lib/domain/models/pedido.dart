// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:siv_codebar/domain/models/pagamento.dart';
import 'package:siv_codebar/domain/models/pessoa.dart';
import 'package:siv_codebar/domain/models/produto_pedido.dart';

class Pedido {
  final int id;
  final double total;
  final double desconto;
  final double? taxaDeEntrega;

  final List<ProdutoPedido> produtos;

  final List<Pagamento> pagamentos;

  final Pessoa? pessoa;

  final String? urlDePagamento;
  final String? urlDanfe;
  final String? comprovanteDePagamento;
  Pedido({
    required this.id,
    required this.total,
    required this.desconto,
    required this.produtos,
    required this.pagamentos,
    required this.taxaDeEntrega,
    required this.pessoa,
    required this.urlDanfe,
    required this.urlDePagamento,
    required this.comprovanteDePagamento,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'total': total,
      'desconto': desconto,
      'produtos': produtos.map((x) => x.toMap()).toList(),
      'pagamentos': pagamentos.map((x) => x.toMap()).toList(),
      'taxaDeEntrega': taxaDeEntrega,
      'pessoa': pessoa?.toMap(),
      'urlDePagamento': urlDePagamento,
      'urlDanfe': urlDanfe,
      'comprovanteDePagamento': comprovanteDePagamento,
    };
  }

  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['id'] as int,
      total: double.tryParse(map['total'].toString()) ?? 0,
      desconto: double.tryParse(map['desconto'].toString()) ?? 0,
      taxaDeEntrega: double.tryParse(map['taxaDeEntrega'].toString()) ?? 0,
      produtos: List<ProdutoPedido>.from(
        (map['produtos'] as List<dynamic>).map<ProdutoPedido>(
          (x) => ProdutoPedido.fromMap(x as Map<String, dynamic>),
        ),
      ),
      pagamentos: List<Pagamento>.from(
        (map['pagamentos'] as List<dynamic>).map<Pagamento>(
          (x) => Pagamento.fromMap(x as Map<String, dynamic>),
        ),
      ),
      urlDanfe: map['urlDanfe'],
      urlDePagamento: map['urlDePagamento'],
      pessoa: map['pessoa'] != null
          ? Pessoa.fromMap(
              map['pessoa'],
            )
          : null,
      comprovanteDePagamento: map['comprovanteDePagamento'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Pedido.fromJson(String source) =>
      Pedido.fromMap(json.decode(source) as Map<String, dynamic>);
}

//[
//   {
//     "id": 6390,
//     "total": 166,
//     "desconto": 0,
//     "taxaDeEntrega": 7,
//     "produtos": [
//       {
//         "idPedido": 6390,
//         "desconto": 0,
//         "descricao": "SAIA JOZI CETIM MIDI",
//         "tamanho": "P",
//         "cor": "PRETO",
//         "valor": 159,
//         "quantidade": 1,
//         "codigoDeBarras": "9870100057089",
//         "dsrefer": "SAIA"
//       }
//     ],
//     "pagamentos": [
//       {
//         "formaDePagamento": "CARTAO 4X",
//         "valor": 159
//       },
//       {
//         "formaDePagamento": "PIX",
//         "valor": 7
//       }
//     ]
//   }
// ]
