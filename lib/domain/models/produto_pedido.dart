// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProdutoPedido {
  final int idPedido;
  final String descricao;
  final String tamanho;
  final String cor;
  final double valor;
  final double desconto;
  final int quantidade;
  final String codigoDeBarras;
  final String dsrefer;

  ProdutoPedido({
    required this.idPedido,
    required this.descricao,
    required this.tamanho,
    required this.cor,
    required this.valor,
    required this.quantidade,
    required this.codigoDeBarras,
    required this.desconto,
    required this.dsrefer,
  });

  ProdutoPedido copyWith({
    int? idPedido,
    String? descricao,
    String? tamanho,
    String? cor,
    double? preco,
    String? formaDePagamento,
    int? quantidade,
  }) {
    return ProdutoPedido(
      idPedido: idPedido ?? this.idPedido,
      descricao: descricao ?? this.descricao,
      tamanho: tamanho ?? this.tamanho,
      cor: cor ?? this.cor,
      valor: preco ?? this.valor,
      quantidade: quantidade ?? this.quantidade,
      codigoDeBarras: codigoDeBarras,
      desconto: desconto,
      dsrefer: '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idPedido': idPedido,
      'descricao': descricao,
      'tamanho': tamanho,
      'cor': cor,
      'preco': valor,
      'desconto': desconto,
      'quantidade': quantidade,
      'codigoDeBarras': codigoDeBarras,
    };
  }

  factory ProdutoPedido.fromMap(Map<String, dynamic> map) {
    return ProdutoPedido(
      idPedido: map['idPedido'] as int,
      descricao: map['descricao'] as String,
      tamanho: map['tamanho'] as String,
      cor: map['cor'] as String,
      valor: map['preco'] as double,
      desconto: map['desconto'] as double,
      quantidade: map['quantidade'] as int,
      codigoDeBarras: map['codigoDeBarras'] as String,
      dsrefer: map['dsrefer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoPedido.fromJson(String source) =>
      ProdutoPedido.fromMap(json.decode(source) as Map<String, dynamic>);
}

// public int pedido { get; set; }
// 		public double desconto { get; set; }
// 		public string descricao { get; set; }
// 		public string tamanho { get; set; }
// 		public string cor { get; set; }
// 		public double preco { get; set; }
// 		public string formaDePagamento { get; set; }
// 		public int quantidade { get; set; }
