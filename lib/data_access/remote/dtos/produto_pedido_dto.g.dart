// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_pedido_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProdutoPedidoDto _$ProdutoPedidoDtoFromJson(Map<String, dynamic> json) =>
    ProdutoPedidoDto(
      idPedido: (json['idPedido'] as num).toInt(),
      descricao: json['descricao'] as String,
      tamanho: json['tamanho'] as String,
      cor: json['cor'] as String,
      preco: (json['preco'] as num).toDouble(),
      formaDePagamento: json['formaDePagamento'] as String,
      quantidade: (json['quantidade'] as num).toInt(),
    );

Map<String, dynamic> _$ProdutoPedidoDtoToJson(ProdutoPedidoDto instance) =>
    <String, dynamic>{
      'idPedido': instance.idPedido,
      'descricao': instance.descricao,
      'tamanho': instance.tamanho,
      'cor': instance.cor,
      'preco': instance.preco,
      'formaDePagamento': instance.formaDePagamento,
      'quantidade': instance.quantidade,
    };
