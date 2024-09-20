// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Produto _$ProdutoFromJson(Map<String, dynamic> json) => Produto(
      json['codigoDeBarras'] as String,
      json['codigoReduzido'] as String,
      json['tamanho'] as String,
      json['cor'] as String,
      (json['estoque'] as num).toInt(),
      json['descricao'] as String,
      json['referencia'] as String,
      (json['valor'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$ProdutoToJson(Produto instance) => <String, dynamic>{
      'codigoDeBarras': instance.codigoDeBarras,
      'codigoReduzido': instance.codigoReduzido,
      'tamanho': instance.tamanho,
      'cor': instance.cor,
      'estoque': instance.estoque,
      'descricao': instance.descricao,
      'referencia': instance.referencia,
      'valor': instance.valor,
    };
