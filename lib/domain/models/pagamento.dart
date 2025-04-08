// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Pagamento {
  final String formaDePagamento;
  final double valor;

  Pagamento({required this.formaDePagamento, required this.valor});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'formaDePagamento': formaDePagamento,
      'valor': valor,
    };
  }

  factory Pagamento.fromMap(Map<String, dynamic> map) {
    return Pagamento(
      formaDePagamento: map['formaDePagamento'] as String,
      valor: map['valor'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pagamento.fromJson(String source) =>
      Pagamento.fromMap(json.decode(source) as Map<String, dynamic>);
}
