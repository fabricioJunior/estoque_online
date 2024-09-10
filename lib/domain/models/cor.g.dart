// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cor _$CorFromJson(Map<String, dynamic> json) => Cor(
      (json['id'] as num).toInt(),
      json['nome'] as String,
    );

Map<String, dynamic> _$CorToJson(Cor instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
    };
