import 'package:json_annotation/json_annotation.dart';

part 'cliente.g.dart';

@JsonSerializable()
class Cliente {
  final int id;
  final String nome;
  final String cpf;
  final String rg;
  final String sexo;

  Cliente({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.rg,
    required this.sexo,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) =>
      _$ClienteFromJson(json);
}
