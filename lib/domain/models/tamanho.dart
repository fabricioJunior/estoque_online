import 'package:json_annotation/json_annotation.dart';
part 'tamanho.g.dart';
@JsonSerializable()
class Tamanho {
  final int id;
  final String nome;

  Tamanho(this.id, this.nome);
}
