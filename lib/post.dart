class Post {
  final String cpf;
  final String senha;

  Post ({
    required this.cpf,
    required this.senha,
  });
  
  factory Post.fromJson(Map<String, dynamic> json) => Post(cpf: json['cpf'], senha: json['senha']);

}
