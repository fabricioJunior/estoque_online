// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:siv_codebar/domain/models/pagamento.dart';
import 'package:siv_codebar/domain/models/produto_pedido.dart';

class Pedido {
  final int id;
  final double total;
  final double desconto;

  final List<ProdutoPedido> produtos;

  final List<Pagamento> pagamentos;

  Pedido(
      {required this.id,
      required this.total,
      required this.desconto,
      required this.produtos,
      required this.pagamentos});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'total': total,
      'desconto': desconto,
      'produtos': produtos.map((x) => x.toMap()).toList(),
      'pagamentos': pagamentos.map((x) => x.toMap()).toList(),
    };
  }

  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['id'] as int,
      total: map['total'] as double,
      desconto: map['desconto'] as double,
      produtos: List<ProdutoPedido>.from(
        (map['produtos'] as List<int>).map<ProdutoPedido>(
          (x) => ProdutoPedido.fromMap(x as Map<String, dynamic>),
        ),
      ),
      pagamentos: List<Pagamento>.from(
        (map['pagamentos'] as List<int>).map<Pagamento>(
          (x) => Pagamento.fromMap(x as Map<String, dynamic>),
        ),
      ),
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
