class Email {
  String titulo;
  String descricao;
  String origem;
  String data;
  String status;

  Email({
    required this.titulo,
    required this.descricao,
    required this.origem,
    required this.data,
    this.status = "seguro"
  });

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      titulo: json['titulo'],
      descricao: json['descricao'],
      origem: json['origem'],
      data: json['data'],
      status: "seguro"
    );
  }
}
