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

  final bool? pedidoPagamento;

  final bool? pagamentoPendente;
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
    this.pedidoPagamento = false,
    this.pagamentoPendente = false,
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
      'pedidoPagamento': pedidoPagamento,
      'pagamentoPendente': pagamentoPendente,
    };
  }

  // ...existing code...

  Pedido copyWith({
    int? id,
    double? total,
    double? desconto,
    double? taxaDeEntrega,
    List<ProdutoPedido>? produtos,
    List<Pagamento>? pagamentos,
    Pessoa? pessoa,
    String? urlDePagamento,
    String? urlDanfe,
    String? comprovanteDePagamento,
    bool? pedidoPagamento,
    bool? pagamentoPendente,
  }) {
    return Pedido(
      id: id ?? this.id,
      total: total ?? this.total,
      desconto: desconto ?? this.desconto,
      taxaDeEntrega: taxaDeEntrega ?? this.taxaDeEntrega,
      produtos: produtos ?? this.produtos,
      pagamentos: pagamentos ?? this.pagamentos,
      pessoa: pessoa ?? this.pessoa,
      urlDePagamento: urlDePagamento ?? this.urlDePagamento,
      urlDanfe: urlDanfe ?? this.urlDanfe,
      comprovanteDePagamento:
          comprovanteDePagamento ?? this.comprovanteDePagamento,
      pedidoPagamento: pedidoPagamento ?? this.pedidoPagamento,
      pagamentoPendente: pagamentoPendente ?? this.pagamentoPendente,
    );
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
      comprovanteDePagamento: map['urlComprovante'],
      pagamentoPendente: map['pagamentoPendente'] as bool?,
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
