class Referencia {
  final String identificador;
  final String descricao;

  Referencia(this.identificador, this.descricao);

  Referencia.fromJson(Map<String, dynamic> json)
      : identificador = json['identificador'],
        descricao = json['descricao'];
}
